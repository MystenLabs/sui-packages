module 0x30474b6cf3c95b93673ee53b8efd0f3f3bcc7bb6d6d2d18134630e112f025210::epik {
    struct EPIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EPIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EPIK>(arg0, 6, b"EPIK", b"SUIEPIKDUCK", b"TECH $EPIK DUCK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Thia_t_ka_ch_AE_a_c_A_t_A_n_42_b47718b784.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EPIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EPIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

