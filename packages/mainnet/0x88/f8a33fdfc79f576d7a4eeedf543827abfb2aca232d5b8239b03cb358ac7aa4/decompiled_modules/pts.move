module 0x88f8a33fdfc79f576d7a4eeedf543827abfb2aca232d5b8239b03cb358ac7aa4::pts {
    struct PTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTS>(arg0, 6, b"PTS", b"PopTrumpSUI", b"Trump is Popping on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmc_Kt_Mk2v_RL_Vh1o_C4vrene_Df6_Bacx_Ch8g4fk_H9h_H_Jh_L9ox_72d67d100d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

