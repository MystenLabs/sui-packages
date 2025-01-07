module 0xb50dbc0b4926ac03c238a45a8488b304d9a577fdaf936455dad4d46dec290d5::suiapt {
    struct SUIAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAPT>(arg0, 9, b"SuiApt", b"Sui vs Apt", b"Legendary battle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn3d.iconscout.com/3d/premium/thumb/aptos-3d-icon-download-in-png-blend-fbx-gltf-file-formats--bitcoin-logo-apt-banking-crypto-currency-pack-business-icons-9833529.png?f=webp")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIAPT>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAPT>>(v2, @0x3e5a78284e4680cb2230cc8de33b29ce19b79ec47c36cf28c8b1b2e3ec44e178);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIAPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

