module 0x9452ec5a5c517b2d8a411c043a87ea6d84352ace3f5f2ee9e24bd1d567eb51dd::sjdnfn {
    struct SJDNFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJDNFN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJDNFN>(arg0, 9, b"SJDNFN", b"Twwhs", b"Djdndn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/099ebcd2-2f16-4bd6-8f80-4cd45cc2605e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJDNFN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJDNFN>>(v1);
    }

    // decompiled from Move bytecode v6
}

