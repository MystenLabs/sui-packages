module 0xdcd103c8d2a045946e2112b97f6d88bf0e2b40608a0cd80017e74fba2b19052::nova {
    struct NOVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOVA>(arg0, 6, b"NOVA", b"First AI President", b"First AI Presidentc00000000000000000000000000000", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Pz_Lw6beix5s_Ss81ts_NUW_Rki_Ns_M8uwhk8_Hyzk8k611rve_218a13f09a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

