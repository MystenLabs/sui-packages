module 0x73a68a575e6e4ef628b3f30a645ad9b121d5ab3bfedb34158f001fb9ed8daba7::fake {
    struct FAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAKE>(arg0, 6, b"FAKE", b"FAKE", b"FAKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/null"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FAKE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAKE>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FAKE>>(v2);
    }

    // decompiled from Move bytecode v6
}

