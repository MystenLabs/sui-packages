module 0x7c0910064fb1da5fdbf61d6944f9c80059f1a6423a5e4ca76bed46f3b42320dd::riko {
    struct RIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIKO>(arg0, 6, b"RIKO", b"Sui Riko", x"4120646966666572656e74206b696e64206f662063617420686173206d6164652069747320617070656172616e63650a0a5468697320636174206973206b6e6f776e206173202452494b4f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3ec49a231f1e4234d58b6f34591a8f93_eed3b103ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

