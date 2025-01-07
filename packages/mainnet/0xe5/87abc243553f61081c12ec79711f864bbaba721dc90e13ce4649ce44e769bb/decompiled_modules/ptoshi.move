module 0xe587abc243553f61081c12ec79711f864bbaba721dc90e13ce4649ce44e769bb::ptoshi {
    struct PTOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTOSHI>(arg0, 9, b"PTOSHI", b"IamSatoshi", b"Forbes just confirmed that HBO's documentary is saying Peter Todd is Satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f12e9beb-aca7-47c1-92d6-5ec7b2c8e07a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

