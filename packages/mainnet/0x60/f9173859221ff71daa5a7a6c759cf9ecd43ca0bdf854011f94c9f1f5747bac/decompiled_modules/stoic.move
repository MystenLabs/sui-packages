module 0x60f9173859221ff71daa5a7a6c759cf9ecd43ca0bdf854011f94c9f1f5747bac::stoic {
    struct STOIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOIC>(arg0, 6, b"STOIC", b"Stoicium", x"2453544f49432c20466f722074686f73652077686f207761746368207468652063727970746f206d61726b65742063726173682c2073697020746865697220636f666665652c20616e64200a7361792c20e280985468697320746f6f207368616c6c20706173732ee2809920484f444c20776974682063616c6d2c20626563617573652077686f206e6565647320737472657373207768656e20796f75e28099766520676f742053746f696320766962657320616e64206469616d6f6e642068616e64733f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731005572679.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STOIC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOIC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

