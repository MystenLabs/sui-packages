module 0xfb028443e3126344c16fc6dfdc354a0db20e3f088bc9921870775d0266ed5fff::SRT {
    struct SRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRT>(arg0, 9, b"SRT", b"suirwd.io - Sui Reward Token", b"You're rewarded $10,000 for empowering the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dovgmcejr/image/upload/v1716472327/suiRewardToken/sui_w3tjn9.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SRT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRT>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SRT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SRT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

