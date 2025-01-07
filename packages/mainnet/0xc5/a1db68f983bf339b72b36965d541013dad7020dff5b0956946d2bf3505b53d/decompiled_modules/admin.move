module 0xc5a1db68f983bf339b72b36965d541013dad7020dff5b0956946d2bf3505b53d::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xc5a1db68f983bf339b72b36965d541013dad7020dff5b0956946d2bf3505b53d::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

