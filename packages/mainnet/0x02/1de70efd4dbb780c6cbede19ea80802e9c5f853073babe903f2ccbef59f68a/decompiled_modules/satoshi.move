module 0x21de70efd4dbb780c6cbede19ea80802e9c5f853073babe903f2ccbef59f68a::satoshi {
    struct SATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSHI>(arg0, 9, b"SATOSHI", b"Satoshi ", b"It's just a Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/29662089-96ec-476e-80dd-7b3d5af8f340.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

