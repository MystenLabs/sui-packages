module 0x4e53449e7bc18a2fc10a4f95b5e5b989b30ca0bcef1baa1df1d21a905a95bc8a::leona {
    struct LEONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEONA>(arg0, 6, b"LEONA", b"SUILONA", b"Save the President's daughter? No, we are here to save your portfolio with $SUILANA. Grab your herbs and let's go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2026_04_01_18_35_58_582c85b4a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LEONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

