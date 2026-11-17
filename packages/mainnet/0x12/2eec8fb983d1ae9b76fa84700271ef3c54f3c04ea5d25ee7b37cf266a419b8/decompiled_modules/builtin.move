module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::builtin {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::new(0x1::ascii::string(b"Mysten Labs"), arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        list_missing(v4, &v2, arg0);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::share(v3);
        0x2::transfer::public_transfer<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::AuditorCap>(v2, 0x2::tx_context::sender(arg0));
    }

    fun list<T0: drop>(arg0: &mut 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::AuditorCap, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        if (0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::is_listed<T0>(arg0)) {
            return
        };
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::list_exchange<T0>(arg0, arg1, 0x1::ascii::string(arg2), 1, b"", arg3);
    }

    entry fun list_missing(arg0: &mut 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::Registry, arg1: &0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::AuditorCap, arg2: &0x2::tx_context::TxContext) {
        list<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::deepbook::DeepBookAdapter>(arg0, arg1, b"deepbook-v3", arg2);
        list<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::cetus::CetusAdapter>(arg0, arg1, b"cetus-clmm", arg2);
        list<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::momentum::MomentumAdapter>(arg0, arg1, b"momentum-v3", arg2);
        list<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::turbos::TurbosAdapter>(arg0, arg1, b"turbos-clmm", arg2);
        list<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::bluefin::BluefinAdapter>(arg0, arg1, b"bluefin-spot", arg2);
    }

    // decompiled from Move bytecode v7
}

