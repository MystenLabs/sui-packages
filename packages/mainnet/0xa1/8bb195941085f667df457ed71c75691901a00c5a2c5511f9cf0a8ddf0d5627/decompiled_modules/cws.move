module 0xa18bb195941085f667df457ed71c75691901a00c5a2c5511f9cf0a8ddf0d5627::cws {
    struct CWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWS>(arg0, 6, b"CWS", b"Cat wif Sunglasses", x"436174206c6f766572200a4f776e6572206f6620436174207769662073756e676c61737365730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Yl9_Ylt_d_400x400_2d8fee938f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

