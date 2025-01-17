module 0x4b0bdaced6861f78a19f10e2facfc53de62f840f87cc0e5fd92e89e331d90934::wmn {
    struct WMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMN>(arg0, 6, b"WMN", b"WOMEN", b"SuiWOMEN on his whay save Crypto world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198291_83c4971418.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

