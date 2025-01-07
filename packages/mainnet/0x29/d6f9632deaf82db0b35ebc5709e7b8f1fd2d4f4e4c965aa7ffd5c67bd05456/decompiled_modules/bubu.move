module 0x29d6f9632deaf82db0b35ebc5709e7b8f1fd2d4f4e4c965aa7ffd5c67bd05456::bubu {
    struct BUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBU>(arg0, 6, b"BUBU", b"BUBU SUI", x"42756275206973207375690a6672656e20666f72207375692070656f706c65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l_WVU_Deyc_400x400_758c28f2ee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

