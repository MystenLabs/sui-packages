module 0x30838772ba3cf8d5e91a15e9deddfebdd0ab910e396e01babdbaf6ab5d3995fc::pitbull {
    struct PITBULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PITBULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PITBULL>(arg0, 6, b"PITBULL", b"Pitbull Sui", b"Fully owned and driven by community! DEV TOKEN BURNED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R_Fxc_Er_Vu_400x400_0f171de452.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PITBULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PITBULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

