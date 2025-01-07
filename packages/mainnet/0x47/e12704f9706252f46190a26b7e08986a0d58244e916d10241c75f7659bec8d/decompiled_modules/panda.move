module 0x47e12704f9706252f46190a26b7e08986a0d58244e916d10241c75f7659bec8d::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDA>(arg0, 6, b"PANDA", b"PANDASUI", x"4e6f20736f6369616c732028796574290a4a75737420616e206f7264696e6172792070616e646120746861742077616e747320746f206d6f6f6e2e200a496620776520626f6e6420736f6369616c732077696c6c2062652075706461746564206f6e20646578", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730997178846.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PANDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

