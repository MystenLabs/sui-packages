module 0x362bd9d4986509e327e89837806278686714ef4e7b26b5f50be7b3e502fc62c3::pigking {
    struct PIGKING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGKING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGKING>(arg0, 6, b"PIGKING", b"pigking", b"PIGking is a high-yield frictionless farming token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000319_0457f83ba7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGKING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIGKING>>(v1);
    }

    // decompiled from Move bytecode v6
}

