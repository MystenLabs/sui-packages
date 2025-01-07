module 0x1c4f65bf63243ac1d00d30f2c2f738620e9f01750aae08a4c65f94f37d7482c7::again {
    struct AGAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AGAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGAIN>(arg0, 6, b"AGAIN", b"GREAT AGAIN...", b"Grate Again...Grate Again...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/453047781_1057535252397541_8262375076596823044_n_9aa0c4121a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGAIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AGAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

