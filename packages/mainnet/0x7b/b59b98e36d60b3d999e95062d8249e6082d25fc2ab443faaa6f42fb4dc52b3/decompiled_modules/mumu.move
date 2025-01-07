module 0x7bb59b98e36d60b3d999e95062d8249e6082d25fc2ab443faaa6f42fb4dc52b3::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMU>(arg0, 6, b"MUMU", b"Mumu the Bull", b"Mumu is a muuvement to unite everyone in crypto. Backed by number go up technology, the bull born from the meme we all know and love is here to lead the charge. Launched with the starting supply of the U.S. dollar, mutoshi and his delinquents are on a mission to dethrone the establishment and forge the ultimate decentralized currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Laf_Q_Ur_Vco6o7_K_Mz42eq_VEJ_9_LW_31_St_Py_Gjeeu5s_Ko_Mt_A_ca996d8f6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

