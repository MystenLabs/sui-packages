module 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::admin {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::create(0x2::tx_context::sender(arg0), arg0);
    }

    public fun removeAdmin(arg0: &mut 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg0, v0), 3);
        assert!(arg1 != v0, 100);
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::remove_admin(arg0, arg1);
    }

    public fun setAdmin(arg0: &mut 0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::Admin, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::is_admin(arg0, 0x2::tx_context::sender(arg2)), 3);
        0xdc2909a35c5ec8975e10ca185d657d053cf8412291c8e98da6b77e28428813c5::permission::set_admin(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

