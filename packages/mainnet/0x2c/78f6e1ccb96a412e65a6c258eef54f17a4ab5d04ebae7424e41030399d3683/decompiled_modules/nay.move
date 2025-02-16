module 0x2c78f6e1ccb96a412e65a6c258eef54f17a4ab5d04ebae7424e41030399d3683::nay {
    struct NAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAY>(arg0, 9, b"NAY", b"Naya testn", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2ea73edb-43d8-4369-933e-4da281c4ebcc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

