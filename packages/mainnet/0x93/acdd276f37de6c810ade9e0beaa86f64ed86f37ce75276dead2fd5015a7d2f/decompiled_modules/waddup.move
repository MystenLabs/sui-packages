module 0x93acdd276f37de6c810ade9e0beaa86f64ed86f37ce75276dead2fd5015a7d2f::waddup {
    struct WADDUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WADDUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WADDUP>(arg0, 6, b"WADDUP", b"Dat Boi", x"64617420626f692069732068657265212121212121210a0a6f20736869742077616464757021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7z5d8_Je3_JH_5n_E_Nwgf_D_Yt755h_G3_NG_Unvg_Bg_T_Boka6n_F2_S_1c60a43032.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WADDUP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WADDUP>>(v1);
    }

    // decompiled from Move bytecode v6
}

