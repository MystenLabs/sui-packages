module 0x6d3ba624a3a41486debefe1f38d1df3ef83bca001a6497b43c629b677c5070af::ewe {
    struct EWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EWE>(arg0, 6, b"EWE", b"ew", b"EWE SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pp_D19zg6_b221a7fb0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

