module 0x5c8e27494cfc9001610ef0966ed0ecd678828aabbb22b9bdfe45b22a6de60398::nyp {
    struct NYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: NYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NYP>(arg0, 9, b"NYP", b"Nippy", x"c3a86162666173666173", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/cc0ee340-3075-11f0-852e-3585a1f35c1e")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NYP>>(v1);
        0x2::coin::mint_and_transfer<NYP>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NYP>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

