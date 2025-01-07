module 0x316d54ca283561c477983ae03c1a51a17f1ac8e6add582e4b0aefc06459e5ae0::jeffry {
    struct JEFFRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JEFFRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JEFFRY>(arg0, 6, b"JEFFRY", b"JEFFRY SUI", b"Hi, we're Jeffry - Officially", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x073a3b3e890a3aaeb061e50e92fffdd31197870b_675e1147e9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JEFFRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JEFFRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

