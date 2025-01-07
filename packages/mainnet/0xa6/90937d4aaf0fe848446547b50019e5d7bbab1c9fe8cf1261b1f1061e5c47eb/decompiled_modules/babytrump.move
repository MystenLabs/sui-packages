module 0xa690937d4aaf0fe848446547b50019e5d7bbab1c9fe8cf1261b1f1061e5c47eb::babytrump {
    struct BABYTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYTRUMP>(arg0, 6, b"BABYTRUMP", b"Babyttumpwin", b"Win! Win! Win! Get ready to shake things up with $BABYTRUMP, the meme coin that's bursting with presidential charm and playful style!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044272_4fcf782a24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

