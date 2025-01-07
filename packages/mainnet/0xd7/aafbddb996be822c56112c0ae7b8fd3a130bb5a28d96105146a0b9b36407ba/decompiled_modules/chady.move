module 0xd7aafbddb996be822c56112c0ae7b8fd3a130bb5a28d96105146a0b9b36407ba::chady {
    struct CHADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHADY>(arg0, 6, b"CHADY", b"Chady on Sui", b"Hi, Im Chady on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/figg_23a807c1ea.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHADY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

