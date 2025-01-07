module 0x38efdb40835a940dc36698b5d404d172792136f9d341cf77b923c86e96f76ae0::biby {
    struct BIBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIBY>(arg0, 6, b"BIBY", b"Sui Biby", b"$BIBY the Three-Eyed Fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bebek_2_4ae426e434.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

