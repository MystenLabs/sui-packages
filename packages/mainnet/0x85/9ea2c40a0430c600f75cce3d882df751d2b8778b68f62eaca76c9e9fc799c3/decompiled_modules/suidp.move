module 0x859ea2c40a0430c600f75cce3d882df751d2b8778b68f62eaca76c9e9fc799c3::suidp {
    struct SUIDP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDP>(arg0, 6, b"SUIDP", b"SuiDonaldTrump", b"Why Trump has blue hair ? Cuz it's on fucking SUI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Donald_Trump_920ba559b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDP>>(v1);
    }

    // decompiled from Move bytecode v6
}

