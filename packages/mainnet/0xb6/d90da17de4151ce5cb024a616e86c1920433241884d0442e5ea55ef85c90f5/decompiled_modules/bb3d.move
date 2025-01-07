module 0xb6d90da17de4151ce5cb024a616e86c1920433241884d0442e5ea55ef85c90f5::bb3d {
    struct BB3D has drop {
        dummy_field: bool,
    }

    fun init(arg0: BB3D, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BB3D>(arg0, 9, b"BB3D", b"BullBird ", b"A clear combination of the features of Bull and Bird. Two animals with their unique features, aiming to breed new born in the crypto space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/15e64b1d-8bd4-4445-b5a5-7b1df9b1e8f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BB3D>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BB3D>>(v1);
    }

    // decompiled from Move bytecode v6
}

