module 0x38ab632a4c23b0eebc1d3ecac3243792caa8130428255e795167dfe36f656289::aaarats {
    struct AAARATS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAARATS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAARATS>(arg0, 6, b"AAARATS", b"AAAAAHRATS", b"token is at the forefront of innovation in the decentralized finance (DeFi) space, offering a unique blend of utility, community governance, and growth potential. Designed to empower users and foster collaboration", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/possum_scream_at_own_ass_aji_zaith_transparent_70314d1a45.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAARATS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAARATS>>(v1);
    }

    // decompiled from Move bytecode v6
}

