module 0xa2d8207699d106cefcec64d3c5dc4e3e5d5e00770dbd3cb08cfcd9d475af07d1::chinochino {
    struct CHINOCHINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINOCHINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINOCHINO>(arg0, 9, b"CHINOCHINO", b"Capuchino", b"It is created for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b26484f0-1ddf-4074-bd30-79a699b97d9c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINOCHINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHINOCHINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

