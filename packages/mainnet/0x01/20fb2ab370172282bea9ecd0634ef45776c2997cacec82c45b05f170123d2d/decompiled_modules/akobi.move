module 0x120fb2ab370172282bea9ecd0634ef45776c2997cacec82c45b05f170123d2d::akobi {
    struct AKOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKOBI>(arg0, 6, b"AKOBI", b"AKOBI on SUI", b"Cute hyppo coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screen_Shot_2024_11_04_at_16_51_30_acdf758920.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AKOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

