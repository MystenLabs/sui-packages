module 0xf356eb4dbc8a119d8c62db4fb19db4e9292fb54d50e9a7bd911b0fbf42142245::sump {
    struct SUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUMP>(arg0, 6, b"Sump", b"seal trump", b"Seal trump the president seal leader off all the seals,  Trump sealed victory HU RA ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_dd_Hlx_Sp_C_1731735196277_raw_1_2197b83dac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

