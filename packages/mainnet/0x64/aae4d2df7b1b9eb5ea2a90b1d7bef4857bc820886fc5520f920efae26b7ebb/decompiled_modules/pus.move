module 0x64aae4d2df7b1b9eb5ea2a90b1d7bef4857bc820886fc5520f920efae26b7ebb::pus {
    struct PUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUS>(arg0, 6, b"PUS", b"PIUS", b"FIRST ICEY LAD.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_22_32_22_153579e2fa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

