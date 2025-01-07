module 0x39be16ff0e3e28d9eb04b9be28e406e296d69a170dcbc9ef152b1176d07977bf::makafo {
    struct MAKAFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKAFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKAFO>(arg0, 6, b"MAKAFO", b"Makafo", b"As air moves back and forth between the lungs of the frog and the vocal sac, the vocal cords cause the air to vibrate and produce the croaking sound that we hear $MAKAFO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmahtq_Wus_Se_E5to2_BW_83_C_Lny_Ho_AWX_4h3kw_Qmg6o_MGCC_6k4_32513487ab_4e0c50816b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKAFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAKAFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

