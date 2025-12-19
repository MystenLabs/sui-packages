module 0xf825ae8c00798b809678feff81fed85cd517ac3df042c1c91304bd2e95c0d6ae::sq {
    struct SQR has store, key {
        id: 0x2::object::UID,
        ci: u64,
        aw: address,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = SQR{
            id : 0x2::object::new(arg0),
            ci : 0,
            aw : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<SQR>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    entry fun csst(arg0: &mut SQR, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.aw == 0x2::tx_context::sender(arg4), 202);
        if (0x2::clock::timestamp_ms(arg1) > arg3) {
            abort 201
        };
        if (arg0.ci > arg2) {
            abort 200
        };
        arg0.ci = arg2;
    }

    entry fun rci(arg0: &mut SQR, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.aw == 0x2::tx_context::sender(arg1), 202);
        arg0.ci = 0;
    }

    // decompiled from Move bytecode v6
}

