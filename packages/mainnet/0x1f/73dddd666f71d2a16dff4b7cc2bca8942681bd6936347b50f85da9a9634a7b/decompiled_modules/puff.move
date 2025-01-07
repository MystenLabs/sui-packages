module 0x1f73dddd666f71d2a16dff4b7cc2bca8942681bd6936347b50f85da9a9634a7b::puff {
    struct PUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF>(arg0, 6, b"PUFF", b"LittlePuffSui", x"412066616e2070616765206261736564206f6e206d656d65636f696e206f6620746865206d6f73742066616d6f757320636174206f6e20696e7465726e6574206b6e6f776e20617320507566660a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_144711_4386e5cf01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

