module 0x5305c4b3f212cdd4ecfdcf0bb8a8add32f719638e7b127ab4666fbfc11d2b472::soda {
    struct SODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SODA>(arg0, 9, b"SODAX", b"SODA", b"Sodax Official Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/icon-project/sodax-frontend/refs/heads/main/apps/web/public/Sodax.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

