module 0xfb156fe100028d47d079f0dc28d29d4df11f5919cc4518318e3a99c5b2d356bd::octo {
    struct OCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCTO>(arg0, 6, b"Octo", b"OctoSui", b"First octopus on sui best meme coin and soon utility", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736073063095.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCTO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

