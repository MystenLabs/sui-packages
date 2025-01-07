module 0x6fd7718ea90a2dfa8a692d3e6d1016df190f7b82ebbba73e03a65d244bc15844::suied {
    struct SUIED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIED>(arg0, 6, b"SUIED", b"Suied", b"THE SUI FIRST CULTURE COIN ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_suiedd_bb611b0e2d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIED>>(v1);
    }

    // decompiled from Move bytecode v6
}

