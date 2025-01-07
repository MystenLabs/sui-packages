module 0x970f304adcc8e15a40572597407fe97bedd5f38e091a98319d1af8639dd669b0::rbt {
    struct RBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBT>(arg0, 9, b"RBT", b"rabbit", x"746869732069732072616262697420636f696e20f09f9087f09f908720737570657266617374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bc231a9d-e8ed-449e-9087-9d9856381ebe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RBT>>(v1);
    }

    // decompiled from Move bytecode v6
}

