module 0x3dae7b0bc82a4a49eb178b9aa088354d9a738e66fa711005666c431a063e8a28::gonk {
    struct GONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONK>(arg0, 6, b"GONK", b"SUIGONK", b"Gonk your way to financial freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_055242998_975903ddac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

