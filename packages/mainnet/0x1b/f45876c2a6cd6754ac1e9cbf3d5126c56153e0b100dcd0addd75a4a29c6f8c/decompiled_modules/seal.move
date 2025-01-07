module 0x1bf45876c2a6cd6754ac1e9cbf3d5126c56153e0b100dcd0addd75a4a29c6f8c::seal {
    struct SEAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEAL>(arg0, 6, b"SEAL", b"Sealonsui", x"5765207365616c7920706c617973207570206f7572205365616c20436f696e206964656e746974792c2072657070696e67206f7572206d6173636f7420776974682070726964652e204974e280997320616c6c2061626f75742074686174207365616c206c6966652c206f776e696e6720626f74682074686520636f696e20616e642074686520637265617475726520766962652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731238214225.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

