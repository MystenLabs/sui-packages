module 0x6e8f00e9327f2b7de6892c0b02d8d09e37b13bd9b30aff19594984b803f7306d::boop {
    struct BOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOP>(arg0, 9, b"BOOP", b"BOOP ON SUI", b"BOOP is the native utility token of the boop.fun platform. by staking BOOP, users unlock airdrop rewards and trading fees from tokens launched on the platform ()", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://boop.fun/boop/icon.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOP>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOP>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

