module 0x8136a091ab68f907f6e910862efbc537cf96f213319fdfcadfe7350dda5adc80::suipine {
    struct SUIPINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPINE>(arg0, 6, b"SUIPINE", b"Suipine - the Gym area of Sui", b"At the Gym and on Sui, which is the best place to get a PUMP?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_633d716dfe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

