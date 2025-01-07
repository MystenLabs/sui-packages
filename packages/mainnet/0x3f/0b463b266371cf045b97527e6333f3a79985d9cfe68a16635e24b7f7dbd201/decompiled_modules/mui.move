module 0x3f0b463b266371cf045b97527e6333f3a79985d9cfe68a16635e24b7f7dbd201::mui {
    struct MUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUI>(arg0, 6, b"MUI", b"MUIonSUI", b"The Red Child are smilling look at the Sui MeMes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241015_170554_2c09a56aec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

