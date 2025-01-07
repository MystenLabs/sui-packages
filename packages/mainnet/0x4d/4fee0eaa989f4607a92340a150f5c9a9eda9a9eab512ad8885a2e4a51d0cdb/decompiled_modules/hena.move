module 0x4d4fee0eaa989f4607a92340a150f5c9a9eda9a9eab512ad8885a2e4a51d0cdb::hena {
    struct HENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HENA>(arg0, 6, b"HENA", b"Hena on Sui", b"$HENA husband from #EVANCHENG the meme coin on network sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000121227_319d0b3a4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

