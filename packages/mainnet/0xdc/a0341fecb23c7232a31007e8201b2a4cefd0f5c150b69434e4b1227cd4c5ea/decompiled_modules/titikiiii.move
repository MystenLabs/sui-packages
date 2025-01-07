module 0xdca0341fecb23c7232a31007e8201b2a4cefd0f5c150b69434e4b1227cd4c5ea::titikiiii {
    struct TITIKIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITIKIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITIKIIII>(arg0, 9, b"TITIKIIII", b"TiTiKii", b"that what i do you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e743caa-6c47-41bf-ac5a-268bd172c622.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITIKIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITIKIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

