module 0x7246e22401c4d12f857b3033fe3910ecc94bda4901a93071f2666c46ce7b6cb4::dope {
    struct DOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE>(arg0, 6, b"Dope", b"DOPE", b"https://x.com/elonmusk/status/1901013162754740239", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gm_HBY_56bc_AI_Pmj_E_fe4bd22adf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

