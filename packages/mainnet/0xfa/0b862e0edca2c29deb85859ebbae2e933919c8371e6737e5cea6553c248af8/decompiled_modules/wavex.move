module 0xfa0b862e0edca2c29deb85859ebbae2e933919c8371e6737e5cea6553c248af8::wavex {
    struct WAVEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAVEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAVEX>(arg0, 9, b"WAVEX", b"WAVEX", b"An On-chain Randomness Swim Race Game on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://wavex.gg/images/logo.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAVEX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAVEX>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAVEX>>(v2);
    }

    // decompiled from Move bytecode v6
}

