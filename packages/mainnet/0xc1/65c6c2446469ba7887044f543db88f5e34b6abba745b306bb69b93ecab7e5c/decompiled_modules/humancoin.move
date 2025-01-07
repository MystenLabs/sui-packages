module 0xc165c6c2446469ba7887044f543db88f5e34b6abba745b306bb69b93ecab7e5c::humancoin {
    struct HUMANCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMANCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMANCOIN>(arg0, 9, b"HUMANCOIN", b"Human", x"746f2062652072696368f09f91be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c10f2e96-4eb1-4d82-986e-55e71ca9a9fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMANCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUMANCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

