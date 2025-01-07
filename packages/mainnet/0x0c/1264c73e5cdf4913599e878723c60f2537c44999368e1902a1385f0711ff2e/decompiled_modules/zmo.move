module 0xc1264c73e5cdf4913599e878723c60f2537c44999368e1902a1385f0711ff2e::zmo {
    struct ZMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZMO>(arg0, 9, b"ZMO", b"Zeemo ", b"\"Zeemo Coin: Empowering Your Digital Horizon. A revolutionary cryptocurrency symbolizing freedom, innovation, and financial empowerment.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b4feff9-74b0-45fe-ac7f-9d10e6a78fd7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

