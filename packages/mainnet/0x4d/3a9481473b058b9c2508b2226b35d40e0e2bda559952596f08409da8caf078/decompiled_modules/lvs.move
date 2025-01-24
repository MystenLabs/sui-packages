module 0x4d3a9481473b058b9c2508b2226b35d40e0e2bda559952596f08409da8caf078::lvs {
    struct LVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LVS>(arg0, 6, b"LVS", b"LarvaOnSui", b"Larva is feeling super energized today! Are you guys ready to go all out with Larva?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8812a03f8fee8289c948287f1571ffbc_0076bad93f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LVS>>(v1);
    }

    // decompiled from Move bytecode v6
}

