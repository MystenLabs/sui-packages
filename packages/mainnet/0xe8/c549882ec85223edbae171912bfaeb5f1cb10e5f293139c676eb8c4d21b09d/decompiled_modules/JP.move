module 0xe8c549882ec85223edbae171912bfaeb5f1cb10e5f293139c676eb8c4d21b09d::JP {
    struct JP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JP>(arg0, 6, b"JP", b"john pork", b"john pork is calling you...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmPTV3DvjFUmLPkNxpGkKKtHgJX6nd14XFUUVVvMorkVVb")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

