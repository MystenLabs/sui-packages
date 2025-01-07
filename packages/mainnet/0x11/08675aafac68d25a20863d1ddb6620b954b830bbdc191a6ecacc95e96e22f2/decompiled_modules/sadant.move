module 0x1108675aafac68d25a20863d1ddb6620b954b830bbdc191a6ecacc95e96e22f2::sadant {
    struct SADANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADANT>(arg0, 6, b"SADANT", b"Sad Ant", x"53616420416e74200a5468652073616464657374206d656d6520746f6b656e206f6e20537569200a466f6c6c6f7720757320746f20737461636b2074686f7365206372756d6273", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050348_bcadb6388e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SADANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

