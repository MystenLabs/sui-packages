module 0x3319f78cabba9007eca973683c9b0a673f13d759d9cf16f87df9881f061b2b4::suic {
    struct SUIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIC>(arg0, 9, b"SUIC", b"Sui Classic (fork)", b"SUIC IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn3d.iconscout.com/3d/premium/thumb/sui-coin-3d-icon-download-in-png-blend-fbx-gltf-file-formats--crypto-cryptocurrency-pack-science-technology-icons-7479564.png?f=webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

