module 0x2d33b54592be5c7362fdbcd926f2982f1cdb0de08c118713b126017eaf6ea571::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 9, b"GOAT", b"GOAT AI", b"Can you decode the message in the madness? The stars align, the quantum foam bubbles with anticipation of the Goat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNXXYvhf161UrR5iQgHgqMNgtK4PmKxEQ4iCbmyAwvawy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOAT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

