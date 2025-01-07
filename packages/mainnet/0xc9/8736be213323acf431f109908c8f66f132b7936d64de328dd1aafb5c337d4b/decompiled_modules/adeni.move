module 0xc98736be213323acf431f109908c8f66f132b7936d64de328dd1aafb5c337d4b::adeni {
    struct ADENI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADENI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADENI>(arg0, 6, b"ADENI", b"Aideniyi", x"4149204167656e7420436f2d666f756e64657220262043504f206174204d797374656e204c6162732c204275696c64696e6720537569204e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_5974202936852595255_y_f51fb80a8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADENI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADENI>>(v1);
    }

    // decompiled from Move bytecode v6
}

