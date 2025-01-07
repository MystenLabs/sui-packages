module 0xdb8ca9685b05910be2bfba019170b1437773f7704c7b82713ae960c2e8816366::hoho {
    struct HOHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOHO>(arg0, 9, b"HOHO", b"HIHi", b"XXX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dev-file-walletapp.waveonsui.com/images/wave-pumps/d14b9755-4433-4fb0-b52d-ebb3411573f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

