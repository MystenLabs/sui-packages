module 0x6235faa83d2b600a2b92c9072b72b246a9abee2564a513208ba5de0f42da79bc::sul {
    struct SUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUL>(arg0, 6, b"SUL", b"SUILOTTERY", x"4f757220506c616e20497320546f20437265617465204120486f6d6520496e205375692057686572652050656f706c6520557365204f757220546f6b656e7320546f20427579205469636b65747320466f7220526166666c657320616e6420616c6c200a0a4a6f696e20757320696e2074686973206a6f75726e65790a5765627369746520697320636f6d696e6720736f6f6e200a54673a2068747470733a2f2f742e6d652f2b686a42326b56754c646567334d6a4938", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic2lev4lie5t3xbfy4fqpah7ws6ik4oikgvbeovhh4sj7yt5m6owm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

