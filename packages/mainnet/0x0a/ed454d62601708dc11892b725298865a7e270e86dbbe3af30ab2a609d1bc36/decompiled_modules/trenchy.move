module 0xaed454d62601708dc11892b725298865a7e270e86dbbe3af30ab2a609d1bc36::trenchy {
    struct TRENCHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRENCHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRENCHY>(arg0, 6, b"TRENCHY", b"Trenchy", b"Open market for crypto services, think fiver but for trenchers Become a Trench Warrior Today.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_T_Iv_C_Kf4_400x400_1_ff12133810.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRENCHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRENCHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

