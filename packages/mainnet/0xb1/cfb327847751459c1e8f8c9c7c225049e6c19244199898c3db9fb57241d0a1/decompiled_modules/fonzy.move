module 0xb1cfb327847751459c1e8f8c9c7c225049e6c19244199898c3db9fb57241d0a1::fonzy {
    struct FONZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FONZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FONZY>(arg0, 6, b"FONZY", b"FONZY THE NOBLE FROG KING", b"$Fonzy is a memecoin built on the Solana blockchain. It aims to create a fun and engaging community while also building out unique utilities. with a strong focus on safety, $Fonzy aims to stand out in the growing world of crypto and blockchain projects.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3fa05434_ee8a_4083_b090_612529c10758_291318dad7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FONZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FONZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

