module 0x6fd7bee692fa35e598097ce90cb7ff288ebe1b48e7ad24273bf681a46dd9bd40::wnavi {
    struct WNAVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNAVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNAVI>(arg0, 9, b"WNAVI", b"WNAVI Token", b"WNavi is One-stop Liquidity Protocol on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/FNGKLRGBS7D4lXxsmz4_F-xkMQs9DIRsTQT_q0Nn-iI")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WNAVI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNAVI>>(v0, @0xe40546a4943c835813ac41f46e388c72fc68bc327aa2b23660a771dc8083809d);
    }

    // decompiled from Move bytecode v6
}

