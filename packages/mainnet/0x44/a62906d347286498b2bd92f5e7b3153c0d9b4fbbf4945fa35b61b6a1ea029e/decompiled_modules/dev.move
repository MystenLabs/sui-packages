module 0x44a62906d347286498b2bd92f5e7b3153c0d9b4fbbf4945fa35b61b6a1ea029e::dev {
    struct DEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEV>(arg0, 9, b"DeV", b"DeVitalik", b"This is the official token of DeVitalik_bot on Twitter! Powered by ZerePy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVHaMvzVxfhXVsBicXsMzQpGs49a7K4yZBZkeeeAc4ca2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEV>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEV>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

