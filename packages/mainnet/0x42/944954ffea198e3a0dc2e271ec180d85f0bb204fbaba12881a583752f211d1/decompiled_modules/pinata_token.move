module 0x42944954ffea198e3a0dc2e271ec180d85f0bb204fbaba12881a583752f211d1::pinata_token {
    struct PINATA_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINATA_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINATA_TOKEN>(arg0, 6, b"PINATA TOKEN", b"PINATA TOKEN", b"PINATA TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suifrens.com/images/narwhal-about.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PINATA_TOKEN>>(0x2::coin::mint<PINATA_TOKEN>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINATA_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINATA_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

