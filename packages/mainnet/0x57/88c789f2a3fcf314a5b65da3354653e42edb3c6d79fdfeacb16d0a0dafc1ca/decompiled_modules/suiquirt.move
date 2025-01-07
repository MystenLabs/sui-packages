module 0x5788c789f2a3fcf314a5b65da3354653e42edb3c6d79fdfeacb16d0a0dafc1ca::suiquirt {
    struct SUIQUIRT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIQUIRT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIQUIRT>(arg0, 6, b"SUIQUIRT", b"SuiQUIRT", b"We promise to suiquirt to investors!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pfp_99a9ac7646.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIQUIRT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIQUIRT>>(v1);
    }

    // decompiled from Move bytecode v6
}

