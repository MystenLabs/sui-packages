module 0x6a23de6adf2f9fac2862ede93b376d8521df72ccb0ee3a71df25d38babcd682a::fear {
    struct FEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEAR>(arg0, 6, b"FEAR", b"Fear POGS", x"46656172206361757365732068657369746174696f6e2c2068657369746174696f6e2063617573657320796f757220776f72737420666561727320746f20636f6e6520747275652e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1760949754258.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

