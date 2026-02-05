module 0x3b6c43d0b76b22a821fb475bd3582ed928390c8284cdb95f44ac427bb3ac3e4b::lawrence {
    struct LAWRENCE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LAWRENCE>, arg1: 0x2::coin::Coin<LAWRENCE>) {
        0x2::coin::burn<LAWRENCE>(arg0, arg1);
    }

    fun init(arg0: LAWRENCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAWRENCE>(arg0, 6, b"LAWRENCE", b"Lawrence", b"AI coding assistant specialized in ZhuQue engine development", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1765676909311283200/zNZKA4-H_400x400.png#1770274688345704000")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAWRENCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAWRENCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LAWRENCE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<LAWRENCE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

