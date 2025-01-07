module 0xdbcd6c0b518005ed679ea52f72a361e820b5bf4263c05615032a5d217110a57d::dros {
    struct DROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DROS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DROS>(arg0, 6, b"DROS", b"Dog Rocket On Sui", b"DROS is a community-run project representing sui pet dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_26_at_14_59_21_6d824daf58.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DROS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DROS>>(v1);
    }

    // decompiled from Move bytecode v6
}

