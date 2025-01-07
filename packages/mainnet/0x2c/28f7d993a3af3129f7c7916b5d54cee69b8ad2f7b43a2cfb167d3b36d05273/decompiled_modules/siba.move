module 0x2c28f7d993a3af3129f7c7916b5d54cee69b8ad2f7b43a2cfb167d3b36d05273::siba {
    struct SIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIBA>(arg0, 9, b"SIBA", b"Siba", b"100x token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8b3629d-34b3-429e-a2b8-c58e8bd59fc0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

