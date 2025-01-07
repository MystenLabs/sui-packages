module 0xca6fe849a5861e55f22325ebb39f8c679a27f2cb0b2b26b03f73127a05335bc9::sstv {
    struct SSTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSTV>(arg0, 6, b"SSTV", b"Suisuitv", b"I am looking at you!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1481728888317_pic_63ee2671f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSTV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

