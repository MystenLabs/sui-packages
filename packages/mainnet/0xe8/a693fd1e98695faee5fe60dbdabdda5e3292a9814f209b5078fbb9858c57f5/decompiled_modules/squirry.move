module 0xe8a693fd1e98695faee5fe60dbdabdda5e3292a9814f209b5078fbb9858c57f5::squirry {
    struct SQUIRRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIRRY>(arg0, 6, b"SQUIRRY", b"Squirry", b"SQUIRRY - handsome squirrel on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015730_63ad7ed718.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIRRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIRRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

