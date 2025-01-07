module 0x2f4dd821f40de30fb32abb7197af7eb4f0563edd4f7a614987a293583473d23e::catbks {
    struct CATBKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATBKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATBKS>(arg0, 6, b"CATBKS", b"CatBook", b"CatBook is a fun pixelated artwork, which is building a strong community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CATBOOK_fa92a3934f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATBKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATBKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

