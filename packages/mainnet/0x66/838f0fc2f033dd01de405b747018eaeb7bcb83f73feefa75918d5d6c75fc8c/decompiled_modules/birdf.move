module 0x66838f0fc2f033dd01de405b747018eaeb7bcb83f73feefa75918d5d6c75fc8c::birdf {
    struct BIRDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRDF>(arg0, 9, b"BIRDF", b"BIRD FLY", b"Talk about birds flying in the sky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8179887c-b1d3-4747-9d7c-c668eb4922e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

