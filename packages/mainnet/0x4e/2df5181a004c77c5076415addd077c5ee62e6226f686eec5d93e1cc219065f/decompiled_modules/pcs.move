module 0x4e2df5181a004c77c5076415addd077c5ee62e6226f686eec5d93e1cc219065f::pcs {
    struct PCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCS>(arg0, 6, b"PCS", b"PeacockSUI", b"Flow like water up up up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8af1c396_a7c0_45ad_acdb_e57ec6d7a872_aa17d4d18c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

