module 0x8f8209117a46431b7e16a425d2a02681a4322c50818acc8aeb0a29a12a9cc673::demo_repusd {
    struct DEMO_REPUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEMO_REPUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEMO_REPUSD>(arg0, 6, b"demoREPUSD", b"Demo GiveRep USD", b"Demo token for testing repUSD liquid staking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://giverep.com/images/coins/repUSD.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEMO_REPUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEMO_REPUSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

