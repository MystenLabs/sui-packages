module 0xeebe9aa0ca37f95830f1e4b3b1e1e931d6cf880daaf8504b7eac3aaf62e98a8a::rbw {
    struct RBW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBW>(arg0, 9, b"RBW", b"Rainbow", b"wanna support, here is the way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e1da3ff6-ed3f-40c2-9655-3c5619104afc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBW>>(v1);
    }

    // decompiled from Move bytecode v6
}

