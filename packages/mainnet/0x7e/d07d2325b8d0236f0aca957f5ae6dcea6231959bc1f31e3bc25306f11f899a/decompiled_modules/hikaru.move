module 0x7ed07d2325b8d0236f0aca957f5ae6dcea6231959bc1f31e3bc25306f11f899a::hikaru {
    struct HIKARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIKARU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HIKARU>(arg0, 6, b"HIKARU", b"Hikaru_a16z by SuiAI", b"Creating new experiences", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2190_da0cdcda79.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIKARU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIKARU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

