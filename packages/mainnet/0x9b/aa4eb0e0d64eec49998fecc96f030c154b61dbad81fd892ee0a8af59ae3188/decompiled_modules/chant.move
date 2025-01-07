module 0x9baa4eb0e0d64eec49998fecc96f030c154b61dbad81fd892ee0a8af59ae3188::chant {
    struct CHANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHANT>(arg0, 6, b"CHANT", b"Bloodline Chanting My Name", x"596f757220626c6f6f646c696e65206973206368616e74696e6720796f7572206e616d650a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gi_Ugtv3_Ni_Ute_ADLB_Ug2_Sc8_Y2c3d3do_Y_Lpn_Zkag_Zqpump_7a445e3a04.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

