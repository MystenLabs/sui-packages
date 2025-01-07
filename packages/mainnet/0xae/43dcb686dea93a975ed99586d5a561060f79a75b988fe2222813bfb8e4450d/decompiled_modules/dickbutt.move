module 0xae43dcb686dea93a975ed99586d5a561060f79a75b988fe2222813bfb8e4450d::dickbutt {
    struct DICKBUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKBUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKBUTT>(arg0, 6, b"DICKBUTT", b"Dickbutt AI", x"6469636b627574742077617320736164202e20736f206469636b6275747420626563616d65206169202e206469636b6275747420534d415254206e6f77202e20736f206469636b62757474204841505059206e6f77202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmegj4n_PS_Afp7_Cwz_U_Qcr_N_Qhs5pbt_Gdr5n_Qn_HM_Yacpwh_NS_1_8569860e97.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKBUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DICKBUTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

