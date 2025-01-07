module 0x63e825ac83635b37bd2acdfa884b051018f189110fbe673ea51669473c11a71e::wuen {
    struct WUEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUEN>(arg0, 9, b"WUEN", b"hejd", b"bdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a2ba681-35b6-43a9-bd56-8d65deba4635.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

