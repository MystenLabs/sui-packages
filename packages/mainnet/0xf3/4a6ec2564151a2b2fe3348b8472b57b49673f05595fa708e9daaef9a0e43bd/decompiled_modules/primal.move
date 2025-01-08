module 0xf34a6ec2564151a2b2fe3348b8472b57b49673f05595fa708e9daaef9a0e43bd::primal {
    struct PRIMAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIMAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMAL>(arg0, 6, b"PRIMAL", b"Primal the gorilla", b"Primal the Gorilla left his family and the jungle behind to become a crypto degen. Join the his tribe and help him conquer the sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wi_j_Vh_Xk_400x400_removebg_preview_f7120731a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIMAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIMAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

