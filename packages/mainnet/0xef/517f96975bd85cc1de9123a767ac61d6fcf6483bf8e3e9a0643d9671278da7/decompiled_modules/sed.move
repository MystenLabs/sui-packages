module 0xef517f96975bd85cc1de9123a767ac61d6fcf6483bf8e3e9a0643d9671278da7::sed {
    struct SED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SED>(arg0, 6, b"SED", b"Side Eye Dog", b"Just a dog giving you side eye.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ekran_g_A_r_A_nt_A_s_A_2024_10_24_125932_33eb851423.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SED>>(v1);
    }

    // decompiled from Move bytecode v6
}

