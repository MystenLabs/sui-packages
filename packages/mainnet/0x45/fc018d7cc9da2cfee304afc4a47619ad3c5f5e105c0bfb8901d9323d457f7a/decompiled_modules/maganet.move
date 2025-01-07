module 0x45fc018d7cc9da2cfee304afc4a47619ad3c5f5e105c0bfb8901d9323d457f7a::maganet {
    struct MAGANET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGANET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGANET>(arg0, 6, b"MAGANET", b"Ultra Maganet", b"ultra maganet the coolest magnet on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmbxi_Rjp2_X_Lh_H81z8_Ba_Xwz_BN_Mp_X_Pq8_J_Dg_TC_3_L_Ui19ejf_BK_bd81cbac4a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGANET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGANET>>(v1);
    }

    // decompiled from Move bytecode v6
}

