module 0x8f2739f7d99ec85bf21f5de77605b9d6d174e7da6af931e1746d325b527f10a4::rus {
    struct RUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUS>(arg0, 6, b"RUS", b"RUS Vine Founder Coin", b"The one and only coin of Vine founder Rus Yusupov", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250124_022006_673_09b2b21636.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

