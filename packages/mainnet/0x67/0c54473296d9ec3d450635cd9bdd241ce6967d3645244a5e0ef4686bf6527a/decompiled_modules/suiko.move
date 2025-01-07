module 0x670c54473296d9ec3d450635cd9bdd241ce6967d3645244a5e0ef4686bf6527a::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKO>(arg0, 6, b"SUIKO", b"SUIKOK", x"4a7573742041204368696d700a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xaecb799f64f5d8f914ad66193a2d3979f5b9386cc4217761dba17ae176d2dc47_suikoko_suikoko_5d4a6db5f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

