module 0xa51ce69be65494cadde89e64b0eda8c62ef4ce0bad329f7854d9228674900622::wangdabaoqq_coin {
    struct WANGDABAOQQ_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANGDABAOQQ_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANGDABAOQQ_COIN>(arg0, 8, b"WANGDABAOQQ_COIN", b"WANGDABAOQQ_COIN", b"Move coin by WANGDABAOQQ_COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/17332298")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WANGDABAOQQ_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANGDABAOQQ_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

