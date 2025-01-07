module 0x7c90a51e65af36bc07107dc8fab672158d8f5ca1af1464ab5e3dd47eb6d2f269::suibway {
    struct SUIBWAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBWAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBWAY>(arg0, 6, b"SUIBWAY", b"SUIbway", b"Subway now accepts Sui crypto for quick and seamless payments!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/KA_pkiv_A_g_A_s_bba5477d7b.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBWAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBWAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

