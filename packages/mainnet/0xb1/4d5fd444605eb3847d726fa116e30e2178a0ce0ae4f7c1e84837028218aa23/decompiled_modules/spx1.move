module 0xb14d5fd444605eb3847d726fa116e30e2178a0ce0ae4f7c1e84837028218aa23::spx1 {
    struct SPX1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPX1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPX1>(arg0, 6, b"SPx1", b"SuiPlay0X1", b"SuiPlay0X1 native token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1759473401741.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPX1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPX1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

