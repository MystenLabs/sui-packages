module 0x59ba65a4f4486053c5557fd92e2df7d08aa18129e1c84acd7ea16e5da5f6338a::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 6, b"FUD", b"Fud The pug", x"46554420776173206120667265652061697264726f7020746f2074686520537569204e465420636f6d6d756e69747920696e20446563656d62657220323032332e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Drip_King_679a600988.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

