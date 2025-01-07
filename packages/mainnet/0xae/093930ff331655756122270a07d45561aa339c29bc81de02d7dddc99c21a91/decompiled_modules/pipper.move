module 0xae093930ff331655756122270a07d45561aa339c29bc81de02d7dddc99c21a91::pipper {
    struct PIPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPPER>(arg0, 6, b"PIPPER", b"Pipper der Flipper", b"Pipper der Flipper, the famous dolphin meme from Instagram. By far the coolest and most badass sea animal on the Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X_ug_CT_Ii_400x400_a21e648bec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

