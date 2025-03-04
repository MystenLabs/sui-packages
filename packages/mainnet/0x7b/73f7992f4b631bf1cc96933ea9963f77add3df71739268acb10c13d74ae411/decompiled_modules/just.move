module 0x7b73f7992f4b631bf1cc96933ea9963f77add3df71739268acb10c13d74ae411::just {
    struct JUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUST>(arg0, 6, b"JUST", b"Just Testing", b"Dont buy this  --- this is a test.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screen_Shot_2025_03_04_at_7_55_49_PM_b89366f0ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

