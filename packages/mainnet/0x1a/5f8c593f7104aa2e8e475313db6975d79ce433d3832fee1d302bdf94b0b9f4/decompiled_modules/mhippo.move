module 0x1a5f8c593f7104aa2e8e475313db6975d79ce433d3832fee1d302bdf94b0b9f4::mhippo {
    struct MHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHIPPO>(arg0, 6, b"MHippo", b"Mr. Hippo", b"Great Hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731258399045.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHIPPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHIPPO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

