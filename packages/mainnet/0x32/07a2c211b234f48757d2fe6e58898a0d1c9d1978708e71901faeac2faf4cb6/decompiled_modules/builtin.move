module 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::builtin {
    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::new(0x1::ascii::string(b"Mysten Labs"), arg0);
        let v2 = v1;
        let v3 = v0;
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::list_exchange<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::deepbook::DeepBookAdapter>(&mut v3, &v2, 0x1::ascii::string(b"deepbook-v3"), 1, b"", arg0);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::list_exchange<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::cetus::CetusAdapter>(&mut v3, &v2, 0x1::ascii::string(b"cetus-clmm"), 1, b"", arg0);
        0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::share(v3);
        0x2::transfer::public_transfer<0x3207a2c211b234f48757d2fe6e58898a0d1c9d1978708e71901faeac2faf4cb6::registry::AuditorCap>(v2, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

