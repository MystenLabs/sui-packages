module 0x92295625bbe1d46c5e21b2443282da0d15c4246d78457da7cdcc257fa34075c7::joozy {
    struct JOOZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOOZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOOZY>(arg0, 6, b"JOOZY", b"Joozy Assistant", b"Joozy is an AI assistant app that has revolutionized the way people interact with the Web3 world. With its advanced features, Joozy allows users to seamlessly navigate the decentralized web, including blockchain networks, cryptocurrency exchanges, and other peer-to-peer systems. $Joozy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_23_26_07_de2d31668f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOOZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOOZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

