module 0xa26e71eb29ee098808be2ab870444e16e8f4c235263bb44b1c9cd87cd34b8a6e::sili {
    struct SILI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SILI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SILI>(arg0, 6, b"SILI", b"SILI on SUI", b"When crypto gets silly, SILI keeps it chill-y. Silly memes from your $Sili seal ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ui_C3_XYS_3_400x400_185052a721.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SILI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SILI>>(v1);
    }

    // decompiled from Move bytecode v6
}

