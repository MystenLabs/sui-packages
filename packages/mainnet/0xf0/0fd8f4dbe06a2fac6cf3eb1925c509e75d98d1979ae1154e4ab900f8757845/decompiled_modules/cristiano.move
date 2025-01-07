module 0xf00fd8f4dbe06a2fac6cf3eb1925c509e75d98d1979ae1154e4ab900f8757845::cristiano {
    struct CRISTIANO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRISTIANO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRISTIANO>(arg0, 9, b"CRISTIANO", b"CR7", b"SUI SUI RONALDO, MEME RONALDO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/da4fdd9a-98f8-4784-a2a4-162380c7273e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRISTIANO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CRISTIANO>>(v1);
    }

    // decompiled from Move bytecode v6
}

