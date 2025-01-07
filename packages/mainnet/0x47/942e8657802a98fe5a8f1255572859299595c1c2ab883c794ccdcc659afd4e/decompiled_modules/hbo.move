module 0x47942e8657802a98fe5a8f1255572859299595c1c2ab883c794ccdcc659afd4e::hbo {
    struct HBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBO>(arg0, 6, b"HBO", b"Hidden Bitcoin Owner", b"Who's the real Satoshi?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_ZU_5aft_Uq_D3i5bs32e82n_NKP_4w_Zqjva_BM_9h_X_Uap_AL_92xa_64e5dd3d23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

