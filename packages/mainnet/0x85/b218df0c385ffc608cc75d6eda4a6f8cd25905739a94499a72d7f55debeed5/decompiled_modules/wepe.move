module 0x85b218df0c385ffc608cc75d6eda4a6f8cd25905739a94499a72d7f55debeed5::wepe {
    struct WEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEPE>(arg0, 9, b"WEPE", b"Wewe pepe", b"Pepe on wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01cf49c8-c772-485d-990b-df167ecc79ff.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

