module 0x46b3dbdd67259e6115046240937ab2202d559aaf9fb3d4df1f0a1ec0c3a363dc::aaa {
    struct AAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAA>(arg0, 6, b"AAA", b"AAA BIRD", b"bird sayin AAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aaaaa_f90d47db38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAA>>(v1);
    }

    // decompiled from Move bytecode v6
}

