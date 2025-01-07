module 0x908f1359740046da68b098d84dafb912246c6e3d945dd5ba2e98960c3fdf14cd::suiapt {
    struct SUIAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPT>(arg0, 9, b"SUIAPT", b"Sui vs Aptos", b"SUIAPT IS OUT HERE RUNNING ON 1000% CAFFEINE AND SHEER LUNACY! WATCH YOUR PORTFOLIO WHIPLASH SO HARD YOULL THINK THE MATRIX IS GLITCHING. DOESNT CARE ABOUT YOUR SLEEP SCHEDULE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn3d.iconscout.com/3d/premium/thumb/aptos-3d-icon-download-in-png-blend-fbx-gltf-file-formats--bitcoin-logo-apt-banking-crypto-currency-pack-business-icons-9833529.png?f=webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIAPT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

