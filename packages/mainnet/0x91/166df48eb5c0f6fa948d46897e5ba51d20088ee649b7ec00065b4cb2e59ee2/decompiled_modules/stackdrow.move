module 0x91166df48eb5c0f6fa948d46897e5ba51d20088ee649b7ec00065b4cb2e59ee2::stackdrow {
    struct STACKDROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: STACKDROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STACKDROW>(arg0, 6, b"STACKDROW", b"stackdrow Coin", b"Official stackdrow coin on sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008647_9327a4b899.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STACKDROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STACKDROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

