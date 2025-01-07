module 0x640cb697291e8ff7873ff4c83b4a5f1a7baefdf79227a85ce46216bfd0f0ac30::hrr {
    struct HRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRR>(arg0, 9, b"HRR", b"HorrorCoin", b"Horror has spread everywhere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de113712-d260-4f73-b19e-75ccb52564b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

