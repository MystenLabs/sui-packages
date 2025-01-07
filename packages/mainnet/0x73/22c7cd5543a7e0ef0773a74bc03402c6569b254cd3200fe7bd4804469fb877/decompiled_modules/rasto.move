module 0x7322c7cd5543a7e0ef0773a74bc03402c6569b254cd3200fe7bd4804469fb877::rasto {
    struct RASTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RASTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RASTO>(arg0, 6, b"RASTO", b"RASTOPYRY", b"$RASTO is an innovative memecoin based on Ethereum creator Vitalik Buterin's toy dog that was given to him by his parents when he was a child.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ev_Lt1v_MK_400x400_8c11eb752a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RASTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RASTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

