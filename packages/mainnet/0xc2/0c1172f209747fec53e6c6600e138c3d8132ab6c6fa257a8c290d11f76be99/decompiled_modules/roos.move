module 0xc20c1172f209747fec53e6c6600e138c3d8132ab6c6fa257a8c290d11f76be99::roos {
    struct ROOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROOS>(arg0, 6, b"ROOS", b"Roos ulbricht", b"Roos Ulbritch iz da creater ov Durk Nut, da bigg online markit dat wuz on da dark web frum 2011 til hiz arest in 2013.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241229_010605_624_f6d85e07a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

