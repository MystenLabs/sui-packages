module 0xfdb7ffb556a761dd9bc2d8733387c7cf8b5276845d02cc8b7eaa131abdfe1e5d::curut {
    struct CURUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CURUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CURUT>(arg0, 9, b"CURUT", b"Curut SUI", b"Curut on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c51db0ea-912b-4b74-8170-83aa704ef18c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CURUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CURUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

