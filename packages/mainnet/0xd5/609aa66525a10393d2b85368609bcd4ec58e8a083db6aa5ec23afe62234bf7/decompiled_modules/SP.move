module 0xd5609aa66525a10393d2b85368609bcd4ec58e8a083db6aa5ec23afe62234bf7::SP {
    struct SP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SP>(arg0, 9, b"SP", b"SuiPearl", b"Yield Optimizer on #SuiNetwork. https://suipearl.fi/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1714852362001805312/cEaqLwim_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

