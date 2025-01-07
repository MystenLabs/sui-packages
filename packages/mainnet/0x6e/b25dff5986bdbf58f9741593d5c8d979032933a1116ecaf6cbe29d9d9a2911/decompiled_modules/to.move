module 0x6eb25dff5986bdbf58f9741593d5c8d979032933a1116ecaf6cbe29d9d9a2911::to {
    struct TO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TO>(arg0, 9, b"TO", b"Tokyo", b"Tokyo Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TO>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TO>>(v1);
    }

    // decompiled from Move bytecode v6
}

