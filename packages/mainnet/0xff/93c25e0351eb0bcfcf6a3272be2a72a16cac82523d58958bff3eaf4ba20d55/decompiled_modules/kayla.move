module 0xff93c25e0351eb0bcfcf6a3272be2a72a16cac82523d58958bff3eaf4ba20d55::kayla {
    struct KAYLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAYLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAYLA>(arg0, 9, b"KAYLA", b"Chill", b"Seorang bocil yang menggemaskan. Orang yang ada di sekitarnya selalu tersenyum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1dd95967-6de7-4f70-b42c-76eccb67f545.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAYLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAYLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

