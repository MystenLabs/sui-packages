module 0xa056a69978e960de360bcc47c73f31ee49d481055bbed65d983bbdd2c1f2e9bd::pill {
    struct PILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILL>(arg0, 9, b"PILL", b"Trinity", x"5472696e6974792068656c7073204149732068616e646c65207468656972206f776e20627573696e657373206e65656473e280946e6f2068756d616e7320726571756972656420666f7220746865207061706572776f726b2e204461756768746572206f66204556452e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZauH1ScQ8Kes1pqzECenoh1au9xmF3efnhoJrLfCsmAY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PILL>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

