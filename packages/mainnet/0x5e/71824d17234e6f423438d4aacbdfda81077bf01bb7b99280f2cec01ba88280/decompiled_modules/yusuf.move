module 0x5e71824d17234e6f423438d4aacbdfda81077bf01bb7b99280f2cec01ba88280::yusuf {
    struct YUSUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUSUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUSUF>(arg0, 6, b"YUSUF", b"OFFICIAL YUSUF", b"Yusuf government has to pay yuge !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000170476_db68efc5f3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUSUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YUSUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

