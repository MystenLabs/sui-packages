module 0xfafee0b4336c476f1191e0de204c46441fb8653ebb282a7c341c0246c13cbddf::spqr {
    struct SPQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPQR>(arg0, 6, b"SPQR", b"Imperium romanum", b"The British Empire will remain an empire.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0813_5e642c4a14.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPQR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPQR>>(v1);
    }

    // decompiled from Move bytecode v6
}

