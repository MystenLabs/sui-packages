module 0x6b5c4f90b48f0fbe2d5b67bcfa22986950e3a37186249cc2cb16969ba871b007::iphone {
    struct IPHONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPHONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPHONE>(arg0, 9, b"iphone", b"iphone", b"next level meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.app.goo.gl/2Q93rkL47CTnRGM96")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IPHONE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPHONE>>(v2, @0x97fd99816e254afe58905fc834de6c4dfb738839167119808b10702981bb9b70);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPHONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

