module 0x96ccf122c92f4160ecfe4dd1655ed4ba86162136bae8ea8e73b216a8bc848c8e::bao {
    struct BAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAO>(arg0, 6, b"BAO", b"BaoMemeSui", b"In the lush bamboo forest of the sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000367_56ccaf8407.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

