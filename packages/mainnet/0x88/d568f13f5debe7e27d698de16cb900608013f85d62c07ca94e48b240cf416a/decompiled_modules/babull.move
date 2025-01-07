module 0x88d568f13f5debe7e27d698de16cb900608013f85d62c07ca94e48b240cf416a::babull {
    struct BABULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABULL>(arg0, 6, b"BABULL", b"Baby Bull", b"Baby Bull is very easygoing but can be easily annoyed. As the mascot, Baby Bull represents the spirit and resilience of our community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008773_73cf93b5da.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

