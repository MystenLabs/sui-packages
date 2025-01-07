module 0x22f206be93b629961e27f6fbd485b6825ba8755dcc85642ef46d3527ef7ebb89::vemint {
    struct VEMINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEMINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEMINT>(arg0, 6, b"VEMINT", b"VEMINT DAO", b"Decentralized Cloud Governance principles. Using Finances decentralization-first governance model. Integrated with SUI Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_26_20_15_12_27d34c8ace.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEMINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VEMINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

