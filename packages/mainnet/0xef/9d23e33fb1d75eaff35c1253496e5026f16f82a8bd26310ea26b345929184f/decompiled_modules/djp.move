module 0xef9d23e33fb1d75eaff35c1253496e5026f16f82a8bd26310ea26b345929184f::djp {
    struct DJP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJP>(arg0, 6, b"DJP", b"Donald J Pump", x"446f6e616c642050756d70204973204865726520746f2050756d7020596f204261677321206275636b6c652075702121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmb_KYE_Bb_Ex3x1t_Y5_UB_Eq_K_Ht_E_Ddox_Yw_Cd6_KJ_Ey_S_Xb_Cv3rm_Q_a1834bdf25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DJP>>(v1);
    }

    // decompiled from Move bytecode v6
}

