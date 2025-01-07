module 0x93b873fdac12649ac53965688cf033d433a61cb8b9d9754ae8715a9e38a4549f::le {
    struct LE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LE>(arg0, 9, b"LE", b"Thai", b"yiu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7dd00579-2b71-489c-8c37-62420e45f890.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LE>>(v1);
    }

    // decompiled from Move bytecode v6
}

