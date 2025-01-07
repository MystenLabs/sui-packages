module 0xf9db5c955aa5f6bb42dddac52bf874736b5e600149889ad10456a6c38ac52c7a::tolol {
    struct TOLOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLOL>(arg0, 9, b"TOLOL", b"tolol ", b"just idiot bump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0ea53873-9763-49ef-a04f-dbfbec8f14e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

