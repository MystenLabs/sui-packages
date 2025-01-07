module 0xe24fde402221bb1b2bd429c6ecfd6cb49d4d9628e38e7366aab929a4feca1cbc::suite {
    struct SUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITE>(arg0, 6, b"SUITE", b"SUI-TE", x"4973206974206120686f74656c2073756974653f204f72206973206974206120637570206f6620746561207375693f0a203130302520766f6c6174696c6974792e0a20302066616b652070726f6d697365732028697473206c69746572616c6c7920612073686974636f696e292e0a205065726665637420666f7220746861742073776565742c20737765657420464f4d4f2e0a204265636175736520776861742069663f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_13_03_55_b8739944f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

