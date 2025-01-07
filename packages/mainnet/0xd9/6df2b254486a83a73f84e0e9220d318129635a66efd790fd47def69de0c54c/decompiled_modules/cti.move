module 0xd96df2b254486a83a73f84e0e9220d318129635a66efd790fd47def69de0c54c::cti {
    struct CTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTI>(arg0, 9, b"CTI", b"cati", b"Pounce on profits with CatiCoin: The feline cryptocurrency that's nimble and quick, bringing playful gains and a touch of elegance to your portfolio", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4c3ac06-7c68-4781-9306-a34931c8793e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

