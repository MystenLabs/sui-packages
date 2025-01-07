module 0x1551b0b761648a8024f068185903793faa025f1e151ff60aab14b348abb3b24a::rosie {
    struct ROSIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSIE>(arg0, 6, b"Rosie", b"Rosie the Robot", b"Powered by AI, dedicated to moms, $ROSIE got your back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061121_4c08cf342b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

