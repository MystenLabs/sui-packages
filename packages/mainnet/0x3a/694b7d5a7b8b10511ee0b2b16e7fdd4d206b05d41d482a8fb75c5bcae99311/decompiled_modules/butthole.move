module 0x3a694b7d5a7b8b10511ee0b2b16e7fdd4d206b05d41d482a8fb75c5bcae99311::butthole {
    struct BUTTHOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUTTHOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUTTHOLE>(arg0, 6, b"BUTTHOLE", b"Butthole Coin", b"A fart cannot exist without a butthole ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gf29_Cv_B_Xk_AA_0_FJM_ec532a6e74.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUTTHOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUTTHOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

