module 0xd51f83b70b3dac75554de855d3264129ac1fd6d9d228bdc8144a5de6a5dff6b6::admin {
    public fun is_admin(arg0: address, arg1: address) {
        assert!(arg0 == arg1, 0xd51f83b70b3dac75554de855d3264129ac1fd6d9d228bdc8144a5de6a5dff6b6::err::wrong_launchpad_admin());
    }

    // decompiled from Move bytecode v6
}

