module 0x1bd349ad9a9d20d60d7679143cc74401c2e70f08656e2d1f93e00c6383319bdc::apeguy {
    struct APEGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: APEGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APEGUY>(arg0, 6, b"APEGUY", b"Ape Guy", b"ApeGuy has seen it all bull runs, bear markets, rugs, hacks, devs disappearing for one last update. But does he stress? Nah. He is been aping through it all.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigb36dgskznwyhthjcxsumbannzcxi4ryx43bmqfcr3vz3puyb6pm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APEGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<APEGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

