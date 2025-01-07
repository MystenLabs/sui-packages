module 0x1e8c63c6c4540eed2df45284a798e9fee9dc46e4c0e0ce64109c626c924142b6::onche {
    struct ONCHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONCHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONCHE>(arg0, 6, b"Onche", b"Laxozer", b"Onche onche :noel:", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/438078007_10228027948458262_643429033324803823_n_cb53f2898f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONCHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONCHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

