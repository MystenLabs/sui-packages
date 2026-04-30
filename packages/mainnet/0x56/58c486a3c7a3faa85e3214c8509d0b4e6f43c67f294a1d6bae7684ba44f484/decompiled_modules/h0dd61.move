module 0x5658c486a3c7a3faa85e3214c8509d0b4e6f43c67f294a1d6bae7684ba44f484::h0dd61 {
    struct H5961a has store, key {
        id: 0x2::object::UID,
        h6afdd: u64,
        hce7b7: address,
    }

    entry fun h4c6a7(arg0: &mut H5961a, arg1: &0x2::clock::Clock, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.hce7b7 == 0x2::tx_context::sender(arg4), 202);
        if (0x2::clock::timestamp_ms(arg1) > arg3) {
            abort 201
        };
        if (arg0.h6afdd > arg2) {
            abort 200
        };
        arg0.h6afdd = arg2;
    }

    public fun h909f0(arg0: &mut 0x2::tx_context::TxContext) : address {
        let v0 = H5961a{
            id     : 0x2::object::new(arg0),
            h6afdd : 0,
            hce7b7 : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<H5961a>(v0);
        0x2::object::uid_to_address(&v0.id)
    }

    entry fun he9b6c(arg0: &mut H5961a, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.hce7b7 == 0x2::tx_context::sender(arg1), 202);
        arg0.h6afdd = 0;
    }

    // decompiled from Move bytecode v6
}

