module 0x3d903e4b329b8ee57a6522ade8f0c60809236c79b74bcfbaf09707992731694f::dogwifchain {
    struct DOGWIFCHAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFCHAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFCHAIN>(arg0, 6, b"DOGWIFCHAIN", b"Dog Wif Chain", x"4d6565742024444f47574946434841494e2c203220646179732061676f2c2049206d65742074686520736361726965737420646f672e2044756465207269707065642061206d6574616c20636861696e2061706172742c206579657320626c617a696e67207265642c20616e642063616d65207374726169676874206174206d652e20492072616e206c696b652068656c6c2e204e6f772068652773206f6e205375692e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_09_at_21_02_23_1_cb2b066adc.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFCHAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIFCHAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

