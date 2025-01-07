module 0x655e7f1bf57937c8dbaf661c5db12afa1fb92abf76cf29baef13ec54418af7b0::gou {
    struct GOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOU>(arg0, 6, b"GOU", b"GOU ON SUI", b"GOU BABYNEIRO ON SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030670_6dcff73a1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

