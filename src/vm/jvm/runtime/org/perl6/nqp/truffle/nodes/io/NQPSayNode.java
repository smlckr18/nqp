package org.perl6.nqp.truffle.nodes.io;

import org.perl6.nqp.truffle.nodes.NQPNode;
import com.oracle.truffle.api.frame.VirtualFrame;
import com.oracle.truffle.api.CompilerDirectives.TruffleBoundary;
import com.oracle.truffle.api.dsl.NodeChildren;
import com.oracle.truffle.api.dsl.NodeChild;

@NodeChildren({@NodeChild("arg")})
public class NQPSayNode extends NQPNode {
    @Child private NQPNode arg;

    public NQPSayNode(NQPNode arg) {
      this.arg = arg;
    }

    @Override
    public Object execute(VirtualFrame frame) {
        String value = this.arg.executeString(frame);
        doSay(value);
        return value;
    }

    @TruffleBoundary
    private void doSay(String value) {
        System.out.println(value);
    }
}
