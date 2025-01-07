module 0x1f3c5a8d2eea0f9a9dad715096a3c61c4117b720c1f0e95272ad8f07f39fd3fe::snoot {
    struct SNOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOOT>(arg0, 6, b"SNOOT", b"Snoot Dog", b"I have no problem! That spelled D - O double G", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pgpea158g1ja1_8ac1be2afb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

