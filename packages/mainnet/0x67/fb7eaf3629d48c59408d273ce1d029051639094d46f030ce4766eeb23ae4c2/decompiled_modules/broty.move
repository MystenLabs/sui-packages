module 0x67fb7eaf3629d48c59408d273ce1d029051639094d46f030ce4766eeb23ae4c2::broty {
    struct BROTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROTY>(arg0, 9, b"BROTY", b"ssetsf", b"nhjufsrw", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6a0fff59-e15c-4ca8-afb0-50d52238d103.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

