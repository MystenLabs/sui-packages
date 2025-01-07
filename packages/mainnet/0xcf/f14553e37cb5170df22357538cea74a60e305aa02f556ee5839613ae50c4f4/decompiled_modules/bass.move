module 0xcff14553e37cb5170df22357538cea74a60e305aa02f556ee5839613ae50c4f4::bass {
    struct BASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BASS>(arg0, 6, b"BASS", b"Big ass", b"There is a beautiful ass facing you every day, are you excited?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_10_07_211430_406e73ca50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

