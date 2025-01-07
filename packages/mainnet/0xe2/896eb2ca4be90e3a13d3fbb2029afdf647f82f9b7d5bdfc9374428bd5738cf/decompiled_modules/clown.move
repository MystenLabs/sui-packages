module 0xe2896eb2ca4be90e3a13d3fbb2029afdf647f82f9b7d5bdfc9374428bd5738cf::clown {
    struct CLOWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOWN>(arg0, 6, b"Clown", b"clown", b"Clowns for NoTcLoWnS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731280303530.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLOWN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOWN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

