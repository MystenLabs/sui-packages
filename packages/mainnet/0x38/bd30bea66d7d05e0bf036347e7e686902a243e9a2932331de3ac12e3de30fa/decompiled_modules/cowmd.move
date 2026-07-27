module 0x38bd30bea66d7d05e0bf036347e7e686902a243e9a2932331de3ac12e3de30fa::cowmd {
    struct COWMD has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWMD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWMD>(arg0, 9, b"COWMD", b"Cow Flow", b"Cow Flow is a signal-boosted meme token channeling ape hype for Reddit threads, tipping, and quick raids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmXhF3aXvja3WnWDDMZYagX4ikgkrzkJ3mDKkRjbut9BMm")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<COWMD>>(0x2::coin::mint<COWMD>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COWMD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWMD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

