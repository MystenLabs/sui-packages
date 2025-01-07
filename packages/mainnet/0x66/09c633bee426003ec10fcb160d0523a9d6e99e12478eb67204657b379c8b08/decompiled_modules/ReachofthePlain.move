module 0x6609c633bee426003ec10fcb160d0523a9d6e99e12478eb67204657b379c8b08::ReachofthePlain {
    struct REACHOFTHEPLAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REACHOFTHEPLAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REACHOFTHEPLAIN>(arg0, 0, b"COS", b"Reach of the Plain", b"Conjure yourself... reclaim the  ungone...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Head_Reach_of_the_Plain.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REACHOFTHEPLAIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REACHOFTHEPLAIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

