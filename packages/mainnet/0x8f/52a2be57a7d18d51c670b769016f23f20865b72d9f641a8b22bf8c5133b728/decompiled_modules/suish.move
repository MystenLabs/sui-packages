module 0x8f52a2be57a7d18d51c670b769016f23f20865b72d9f641a8b22bf8c5133b728::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISH>(arg0, 6, b"SUISH", b"SUISH on SUI", b"Join the cult of winners: https://t.me/SUISH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qg9mso_F0_400x400_d68bed21fd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

