module 0x59f263c11cce983fd8239fd74482fe713923abbaf5f8ffbe564e77df91dd6a29::capysui {
    struct CAPYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYSUI>(arg0, 6, b"CAPYSUI", b"Capybara on Sui", b"Im literally just a capybara. Flying to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/capy_712f079742.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

