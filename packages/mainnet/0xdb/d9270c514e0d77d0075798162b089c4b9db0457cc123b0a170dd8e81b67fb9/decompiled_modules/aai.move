module 0xdbd9270c514e0d77d0075798162b089c4b9db0457cc123b0a170dd8e81b67fb9::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 6, b"AAI", b"Agent AI", b"none", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images9_0faa1ab310.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

