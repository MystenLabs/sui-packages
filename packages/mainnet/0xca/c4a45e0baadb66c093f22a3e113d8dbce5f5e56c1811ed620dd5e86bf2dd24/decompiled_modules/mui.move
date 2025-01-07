module 0xcac4a45e0baadb66c093f22a3e113d8dbce5f5e56c1811ed620dd5e86bf2dd24::mui {
    struct MUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUI>(arg0, 6, b"Mui", b"MUI", b"Hodl $Mui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ris4_L_Vd_R_400x400_11d935a4c6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

