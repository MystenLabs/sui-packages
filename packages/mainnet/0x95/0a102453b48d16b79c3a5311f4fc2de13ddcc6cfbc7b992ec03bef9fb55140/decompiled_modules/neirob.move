module 0x950a102453b48d16b79c3a5311f4fc2de13ddcc6cfbc7b992ec03bef9fb55140::neirob {
    struct NEIROB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIROB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIROB>(arg0, 6, b"NEIROB", b"Baby Neiro", b"Neiro hype", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_07_30_17_37_21_2_98e08dd991.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIROB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIROB>>(v1);
    }

    // decompiled from Move bytecode v6
}

