module 0xf9a7c40bc150eb116701421282d32097609ffa85345b602d3cd000fe396f958::test3 {
    struct TEST3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST3>(arg0, 6, b"Test3", b"test 3", b"123 123 345 5", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_04_202906_c85afdf2ef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST3>>(v1);
    }

    // decompiled from Move bytecode v6
}

