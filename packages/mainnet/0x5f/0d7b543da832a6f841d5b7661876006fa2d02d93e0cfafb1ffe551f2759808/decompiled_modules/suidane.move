module 0x5f0d7b543da832a6f841d5b7661876006fa2d02d93e0cfafb1ffe551f2759808::suidane {
    struct SUIDANE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDANE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDANE>(arg0, 6, b"Suidane", b"Suinedine", b"Like Zidane's iconic headbutt to Materazzi, Suidane will hit the jeets hard! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidane_c68ad376cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDANE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDANE>>(v1);
    }

    // decompiled from Move bytecode v6
}

