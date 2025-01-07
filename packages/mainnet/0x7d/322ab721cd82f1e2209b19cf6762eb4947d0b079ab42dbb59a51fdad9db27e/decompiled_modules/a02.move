module 0x7d322ab721cd82f1e2209b19cf6762eb4947d0b079ab42dbb59a51fdad9db27e::a02 {
    struct A02 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A02, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A02>(arg0, 6, b"A02", b"001", b"12312", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KOI_d47f820de4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A02>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A02>>(v1);
    }

    // decompiled from Move bytecode v6
}

