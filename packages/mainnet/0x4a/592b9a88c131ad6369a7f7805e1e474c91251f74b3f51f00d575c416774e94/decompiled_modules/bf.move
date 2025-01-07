module 0x4a592b9a88c131ad6369a7f7805e1e474c91251f74b3f51f00d575c416774e94::bf {
    struct BF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BF>(arg0, 6, b"BF", b"BLACK FOOT", x"57454c4c434f4d4520544f20424c41434b20464f4f54202446420a596f757220666f6f74206f6e20746865207765616b6573742064617921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733429278609.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

