module 0x52a6646adf9b7270d5a510324c84240827bec5c59ffe73c0a7c0e188691cab73::dopins {
    struct DOPINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPINS>(arg0, 6, b"DOPINS", b"DOPIN THE DOLPHIN", x"54686520646f70656420636f6d6d756e69747920636f696e206d616b696e67207761766573206f6e2053554920405375694e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xcb796b97c03d816b39eef6b98d7abcebf2e16ae4f92e7a9d5a371205dadaf8c2_dopin_dopin_7c18c5f643.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

