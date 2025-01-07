module 0x60af4d9198e528662cc54f27d300ce1b29baa2b0c324491b4de7e6ec6fbfe75a::sippo {
    struct SIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIPPO>(arg0, 6, b"SIPPO", b"SUI HIPPO", b"The unofficial hippo of SUI network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/img_Mz_M4_NA_16e73f8618.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

