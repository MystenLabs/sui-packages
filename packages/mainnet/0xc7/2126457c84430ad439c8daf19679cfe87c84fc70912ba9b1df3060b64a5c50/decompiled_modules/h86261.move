module 0xc72126457c84430ad439c8daf19679cfe87c84fc70912ba9b1df3060b64a5c50::h86261 {
    struct H8e662 has store, key {
        id: 0x2::object::UID,
        h4e7c7: u64,
        h77bcf: address,
    }

    public fun h5cab4(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = H8e662{
            id     : 0x2::object::new(arg0),
            h4e7c7 : 0,
            h77bcf : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<H8e662>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    entry fun h8b64d(arg0: &mut H8e662, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.h77bcf == 0x2::tx_context::sender(arg4), 202);
        if (0x2::clock::timestamp_ms(arg1) > arg3) {
            abort 201
        };
        if (arg0.h4e7c7 > arg2) {
            abort 200
        };
        arg0.h4e7c7 = arg2;
    }

    entry fun ha53ca(arg0: &mut H8e662, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.h77bcf == 0x2::tx_context::sender(arg1), 202);
        arg0.h4e7c7 = 0;
    }

    // decompiled from Move bytecode v6
}

