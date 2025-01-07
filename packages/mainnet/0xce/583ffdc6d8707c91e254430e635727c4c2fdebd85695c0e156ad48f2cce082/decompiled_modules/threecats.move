module 0xce583ffdc6d8707c91e254430e635727c4c2fdebd85695c0e156ad48f2cce082::threecats {
    struct THREECATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: THREECATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THREECATS>(arg0, 9, b"THREECATS", b"3Cats", b"Cats Lover Forever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1c39fed-271e-47b7-a2ce-2423d2417b7a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THREECATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THREECATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

