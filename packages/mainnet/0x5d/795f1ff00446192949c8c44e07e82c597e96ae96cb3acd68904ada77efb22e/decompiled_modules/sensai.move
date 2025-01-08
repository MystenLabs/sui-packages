module 0x5d795f1ff00446192949c8c44e07e82c597e96ae96cb3acd68904ada77efb22e::sensai {
    struct SENSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENSAI>(arg0, 6, b"SENSAI", b"SENSAI AI", x"5745204255494c4420494d4147452047454e455241544f52204f4e205355492c2050524f544f54595045205745422050524f4a454354204352454154454420425920415a494d200a534f4349414c2057494c4c2055504441544544204f4e205448524541440a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sensai_851cba09fb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

