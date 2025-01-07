module 0xd395e01ab679cead01340fea22d04dc289cc79ed2e36dab036e620927453f0c1::hmstr {
    struct HMSTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTR>(arg0, 6, b"HMSTR", b"HAMSTER KOMBAT", b"TICK-TOCK finally HMSTR is listed on SUI chain, let's take the hamster to all chains inside the block.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_a3ead314ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMSTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

