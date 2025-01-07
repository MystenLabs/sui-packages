module 0x37fa42f96ce76c92591373d61df1245f11f0b252097c59d4cf50c11557b79aa2::iamsatoshi {
    struct IAMSATOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAMSATOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IAMSATOSHI>(arg0, 6, b"IAMSATOSHI", b"I am Satoshi", x"57696c6c20746865207265616c205361746f7368692c20706c65617365207374616e642075702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IAMSATOSHI_T_Fin_UR_Iu_Ia_F_Cqwb_V_Lh_b0c9de84a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAMSATOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAMSATOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

