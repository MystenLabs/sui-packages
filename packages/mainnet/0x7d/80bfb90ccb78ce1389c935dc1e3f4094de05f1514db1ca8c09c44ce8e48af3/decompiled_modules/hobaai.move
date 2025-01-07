module 0x7d80bfb90ccb78ce1389c935dc1e3f4094de05f1514db1ca8c09c44ce8e48af3::hobaai {
    struct HOBAAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOBAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOBAAI>(arg0, 6, b"HOBAAI", b"HobaAI", b"The greatest honey badger themed AI of all time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_18_14_09_30_64f8ad2a51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOBAAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOBAAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

