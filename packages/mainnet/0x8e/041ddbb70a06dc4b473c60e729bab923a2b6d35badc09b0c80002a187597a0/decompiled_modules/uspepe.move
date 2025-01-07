module 0x8e041ddbb70a06dc4b473c60e729bab923a2b6d35badc09b0c80002a187597a0::uspepe {
    struct USPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: USPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USPEPE>(arg0, 6, b"USPEPE", b"OFFICIAL AMERICAN PEPE ON SUI", b"Dexscreener Paid: https://uspepesui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_7c011c3b1c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

