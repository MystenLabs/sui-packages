module 0xd1e407185c64b1a162d6f824c5db18ed61ac94fc223df8100bffcf88a8ff238f::dbs {
    struct DBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBS>(arg0, 6, b"DBS", b"Donna Bella Sui", b"simps army coming... https://t.me/DonnaBellaPortal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241228_023013_802_e631382796.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

