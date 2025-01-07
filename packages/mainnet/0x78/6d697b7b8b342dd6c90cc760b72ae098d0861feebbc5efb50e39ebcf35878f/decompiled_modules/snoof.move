module 0x786d697b7b8b342dd6c90cc760b72ae098d0861feebbc5efb50e39ebcf35878f::snoof {
    struct SNOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOF>(arg0, 6, b"SNOOF", b"Snoof Frog Sui", b"$SNOOF Is the meme token inspired by #SnoopDogg a Legendary American Rapper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013180_0e6605be96.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

