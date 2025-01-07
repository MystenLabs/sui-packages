module 0x4634c082c68a4deda0db6d97b7b3b6f663b406ef41341a0260c22ab0d58f03d5::fabo {
    struct FABO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FABO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FABO>(arg0, 9, b"FABO", b"Fake Bomb", b"Introducing the Fake Bomb token - $FABO, which is waiting to explode the world of cryptocurrencies! This unique token is created for those who are looking for something more than just an investment. $FABO is a symbiosis of opportunities and fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ef3945f-d46a-4cf1-9246-ac225466125d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FABO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FABO>>(v1);
    }

    // decompiled from Move bytecode v6
}

