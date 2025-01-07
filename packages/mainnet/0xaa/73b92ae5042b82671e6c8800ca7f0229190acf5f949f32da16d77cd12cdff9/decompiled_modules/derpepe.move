module 0xaa73b92ae5042b82671e6c8800ca7f0229190acf5f949f32da16d77cd12cdff9::derpepe {
    struct DERPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERPEPE>(arg0, 6, b"DERPEPE", b"DerPepe", b"Derp + Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002175_dab60023c3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

