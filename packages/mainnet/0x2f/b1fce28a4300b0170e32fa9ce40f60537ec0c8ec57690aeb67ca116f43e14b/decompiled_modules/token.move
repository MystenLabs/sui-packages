module 0x2fb1fce28a4300b0170e32fa9ce40f60537ec0c8ec57690aeb67ca116f43e14b::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 696 || 0x2::tx_context::epoch(arg1) == 697, 1);
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 6, b"$BTC2.0", b"BITCOIN2.0", b"Here are some of the technologies currently being researched, and in some cases, being turned into real products and services. The most interesting uses of Bitcoin are probably still to be discovered.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreiet72ziaamnktfcfcaltysqphhxtofm364eizg7hkeclzg3nraafe.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 21000000000000, @0x4c0b72b95e7ef4d4a2c3c0a47629b3629f7e2d80bdfaf78bf7d2dd91c854590, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, @0x4c0b72b95e7ef4d4a2c3c0a47629b3629f7e2d80bdfaf78bf7d2dd91c854590);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

