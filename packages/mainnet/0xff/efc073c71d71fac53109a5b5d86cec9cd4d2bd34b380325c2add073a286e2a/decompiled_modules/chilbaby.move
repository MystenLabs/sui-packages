module 0xffefc073c71d71fac53109a5b5d86cec9cd4d2bd34b380325c2add073a286e2a::chilbaby {
    struct CHILBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILBABY>(arg0, 6, b"CHILBABY", b"Chillbaby", b"Welcome to the enigmatic realm of ChillBaby, where the power of 'ChillBaby' transcends the ordinary. Delve into a world where ChillBaby unveils its true essence, offering a captivating blend of mystery and utility. Embrace the hidden depths that lie beneath its surface, where holders discover a realm of possibilities beyond the mere concept of a coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048541_91a3fb8898.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

