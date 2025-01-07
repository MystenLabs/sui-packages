module 0xc6bb5a28a709e3eab55155ee8b678227fd5a7a37cfe437705aa6bf53504564b0::arenaa {
    struct ARENAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARENAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARENAA>(arg0, 9, b"ARENAA", b"Arena", b"Arena on wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90c92f18-2d02-4362-a6b3-598e7acdfc93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARENAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARENAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

