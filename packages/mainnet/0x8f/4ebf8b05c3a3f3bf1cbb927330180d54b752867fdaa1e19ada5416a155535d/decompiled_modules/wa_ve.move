module 0x8f4ebf8b05c3a3f3bf1cbb927330180d54b752867fdaa1e19ada5416a155535d::wa_ve {
    struct WA_VE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WA_VE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WA_VE>(arg0, 9, b"WA_VE", b"hailee", b"dddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29d8b79d-925b-4031-b4d6-75774d8e732e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WA_VE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WA_VE>>(v1);
    }

    // decompiled from Move bytecode v6
}

