module 0xf93d2478787c247979adca21e0bce74cdb37de0efc87f1ea12a6bc01a84f5491::blackout {
    struct BLACKOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKOUT>(arg0, 6, b"BLACKOUT", b"Europe Blackout", b"Fck electricity, we have $blackout", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiclrjem2ehygicqw4t4g2ab56d2w7gvpmajsoe4pjfsudh2ro6yxm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLACKOUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

