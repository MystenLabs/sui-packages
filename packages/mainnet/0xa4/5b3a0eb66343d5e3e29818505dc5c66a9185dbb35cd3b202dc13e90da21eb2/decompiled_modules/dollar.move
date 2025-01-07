module 0xa45b3a0eb66343d5e3e29818505dc5c66a9185dbb35cd3b202dc13e90da21eb2::dollar {
    struct DOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLLAR>(arg0, 6, b"Dollar", b"$1", b"We'll get to $1 eventually, you just have to buy and hold now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OIP_C_9ccea52d88.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLLAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

