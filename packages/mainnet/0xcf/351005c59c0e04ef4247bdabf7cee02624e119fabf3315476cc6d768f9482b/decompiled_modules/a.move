module 0xcf351005c59c0e04ef4247bdabf7cee02624e119fabf3315476cc6d768f9482b::a {
    struct A has drop {
        dummy_field: bool,
    }

    fun init(arg0: A, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<A>(arg0, 6, b"A", b"a by SuiAI", b"a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_12_18_11_26_00_c531d51c90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<A>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

