module 0x65aa7956ae9e5c7dce247bd5e613834b5adf5d50385b8d438bf1215389f77d22::BAYSWAP {
    struct BAYSWAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAYSWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAYSWAP>(arg0, 9, b"BAYSWAP", b"BaySwap.io", b"Stable & uncorrelated swap. Limit Order, Yield Farming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1661077492734787584/kvLixk9r_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BAYSWAP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYSWAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BAYSWAP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BAYSWAP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

