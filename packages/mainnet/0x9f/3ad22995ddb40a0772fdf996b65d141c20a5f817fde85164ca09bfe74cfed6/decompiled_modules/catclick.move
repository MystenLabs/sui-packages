module 0x9f3ad22995ddb40a0772fdf996b65d141c20a5f817fde85164ca09bfe74cfed6::catclick {
    struct CATCLICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATCLICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATCLICK>(arg0, 6, b"CATCLICK", b"Clicking Cat on SUI", x"5468652063617420636c69636b730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_Jad5_N09_400x400_2088fb349d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATCLICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATCLICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

