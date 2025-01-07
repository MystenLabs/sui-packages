module 0x2d7cea0dc97874c5a0b8865ed2a534b9303a5ff5e6c170af2b247b08a9caf12c::trl {
    struct TRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRL>(arg0, 9, b"TRL", b"TROLL G", b"TROLL FIGHTERS ARE THE STRONGEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9bb5d321-1d98-449f-b230-8b74b831bef2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

