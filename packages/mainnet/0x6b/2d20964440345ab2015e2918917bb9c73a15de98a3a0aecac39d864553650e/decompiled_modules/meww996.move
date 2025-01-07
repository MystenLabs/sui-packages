module 0x6b2d20964440345ab2015e2918917bb9c73a15de98a3a0aecac39d864553650e::meww996 {
    struct MEWW996 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEWW996, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEWW996>(arg0, 9, b"MEWW996", b"meww", b"mewwwwwwwwwwwww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91f87835-b161-4ba4-94d2-b2f0629b7593.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEWW996>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEWW996>>(v1);
    }

    // decompiled from Move bytecode v6
}

