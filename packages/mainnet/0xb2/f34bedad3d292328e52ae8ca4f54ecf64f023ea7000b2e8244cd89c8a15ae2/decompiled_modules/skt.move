module 0xb2f34bedad3d292328e52ae8ca4f54ecf64f023ea7000b2e8244cd89c8a15ae2::skt {
    struct SKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKT>(arg0, 9, b"SKT", b"Skate", b"Skatathon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd361889-cb0c-478e-8c07-e5b9a14edf48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

