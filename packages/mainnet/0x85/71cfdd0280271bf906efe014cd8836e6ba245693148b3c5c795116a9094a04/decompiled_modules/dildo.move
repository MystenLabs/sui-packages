module 0x8571cfdd0280271bf906efe014cd8836e6ba245693148b3c5c795116a9094a04::dildo {
    struct DILDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DILDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DILDO>(arg0, 6, b"DILDO", b"Dildo BagHands On Sui", b"First Dildo BagHands On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1719653157423_4858afc9c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DILDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DILDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

