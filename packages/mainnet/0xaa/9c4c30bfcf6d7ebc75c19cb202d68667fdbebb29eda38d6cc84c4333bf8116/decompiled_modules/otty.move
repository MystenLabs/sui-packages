module 0xaa9c4c30bfcf6d7ebc75c19cb202d68667fdbebb29eda38d6cc84c4333bf8116::otty {
    struct OTTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTY>(arg0, 6, b"OTTY", b"Otty", b" A chill and fun memecoin featuring the cutest otter in crypto! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20f1ba29741a5c46be5412b007539c9f_4d21fae53b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

