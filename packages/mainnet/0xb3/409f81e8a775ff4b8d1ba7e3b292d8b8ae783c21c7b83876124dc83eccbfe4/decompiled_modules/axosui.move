module 0xb3409f81e8a775ff4b8d1ba7e3b292d8b8ae783c21c7b83876124dc83eccbfe4::axosui {
    struct AXOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOSUI>(arg0, 6, b"AXOSUI", b"new axol poke", b"The axolotl has transformed into the new and powerful Pokmon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_05_12_13_28_31_80a3615327.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

