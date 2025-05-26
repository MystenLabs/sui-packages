module 0x2e70976f3a84cf29a9d97568e16cc92a1c55ad879394387db6253d0f9a4d6c9f::suik4 {
    struct SUIK4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIK4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIK4>(arg0, 6, b"SUIK4", b"$SUIK4", b"A new girl has arked on the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2_b68392a8f6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIK4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIK4>>(v1);
    }

    // decompiled from Move bytecode v6
}

