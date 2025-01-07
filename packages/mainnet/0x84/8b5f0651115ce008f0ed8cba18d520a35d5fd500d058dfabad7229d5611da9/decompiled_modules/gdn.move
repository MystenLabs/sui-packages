module 0x848b5f0651115ce008f0ed8cba18d520a35d5fd500d058dfabad7229d5611da9::gdn {
    struct GDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GDN>(arg0, 9, b"GDN", b"Goodone", b"New token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3441cc52-61bf-4f80-8952-25c05fc70048.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

