module 0x32debd12f9a2713646afe7b3e72e2c773b5e905350a1157e01cfc7924206a4e::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDS>(arg0, 6, b"DDS", b"DeepDive on sui", b"Before investing, learn more about DeepDevisui, its team, roadmap, and competitors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_05_08_35_00_62ae5865de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

