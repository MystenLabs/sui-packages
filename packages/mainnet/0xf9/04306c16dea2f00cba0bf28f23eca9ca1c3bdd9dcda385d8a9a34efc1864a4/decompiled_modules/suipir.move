module 0xf904306c16dea2f00cba0bf28f23eca9ca1c3bdd9dcda385d8a9a34efc1864a4::suipir {
    struct SUIPIR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPIR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPIR>(arg0, 6, b"SuiPir", b"SuiPirou", b"SuiPirou, the charming Sui creature! Probably nothing or everything!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Pur_7f8e2f60ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPIR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPIR>>(v1);
    }

    // decompiled from Move bytecode v6
}

