module 0xd3f505b883f077cc69704d73d838ef2c199b2c277d5099ee22b05e7750033f63::vemint {
    struct VEMINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEMINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEMINT>(arg0, 6, b"VEMINT", b"VEMINT VENTURE", b"Decentralized Cloud Governance principles. Using Finances decentralization-first governance model. Integrated with SUI Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_26_20_15_12_726bcf332e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEMINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VEMINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

