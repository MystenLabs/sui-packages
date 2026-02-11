module 0x4896bcbef6ddcdb83573d100c12e4e89980f932cea6a17e6fd89045db6b7bfb4::sleepwalking {
    struct SLEEPWALKING has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<SLEEPWALKING>, arg1: 0x2::coin::Coin<SLEEPWALKING>) {
        0x2::coin::burn<SLEEPWALKING>(arg0, arg1);
    }

    fun init(arg0: SLEEPWALKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLEEPWALKING>(arg0, 6, b"SLEEPWALKI", b"sleepwalking", b"AI agent for minting on Moltbook", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1589630109115367424/IHHvFlsb_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLEEPWALKING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLEEPWALKING>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SLEEPWALKING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SLEEPWALKING>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

