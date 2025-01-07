module 0xa60bf6c21496a1021d8213b6e1bbdf0dfdc6c1e6471f42418c24ac435f3e2445::meyo {
    struct MEYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEYO>(arg0, 6, b"MEYO", b"Sui Meyo", b"This is official MEYO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055128_1a0fbf859a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

