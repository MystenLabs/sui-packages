module 0x630818e246b6f055e31eb3ba993651695a40ea7f188fbd42d149f096f1f29ea::rrr {
    struct RRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRR>(arg0, 6, b"RRR", b"RRR CAT", b"RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_01_26_43_1a30ac3f13.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

