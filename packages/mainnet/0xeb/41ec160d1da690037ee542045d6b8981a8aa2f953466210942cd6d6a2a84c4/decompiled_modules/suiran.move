module 0xeb41ec160d1da690037ee542045d6b8981a8aa2f953466210942cd6d6a2a84c4::suiran {
    struct SUIRAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRAN>(arg0, 6, b"Suiran", b"Iran on Sui", b"Gogogo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/835_AB_9_DB_5_AF_0_42_D7_BBD_4_485_FBC_698202_5e2cdc94c8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

