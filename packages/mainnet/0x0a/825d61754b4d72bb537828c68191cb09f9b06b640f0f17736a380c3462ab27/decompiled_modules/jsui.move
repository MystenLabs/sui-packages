module 0xa825d61754b4d72bb537828c68191cb09f9b06b640f0f17736a380c3462ab27::jsui {
    struct JSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JSUI>(arg0, 6, b"JSUI", b"JEJE ON SUI", x"4649525354204a454a45204f4e205355492e68747470733a2f2f6a656a65636f696e7375692e7669700a68747470733a2f2f782e636f6d2f4a656a65436f696e5f5375690a68747470733a2f2f742e6d652f4a656a65436f696e537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_2_304b385125.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

