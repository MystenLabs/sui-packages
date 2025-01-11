module 0xe2ec4f4a96666846b5f2e1437dbe09be92edd7959c27352169e92a3813d32d35::xxl {
    struct XXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XXL>(arg0, 6, b"XXL", x"4167656e74e299a458584c206279205375694149", b"AI Agent XXL is a digital asset that uses encryption to provide personalized solutions and services. With a strong technological foundation, it offers innovations in areas such as automation, data analysis, and process optimization, delivering benefits for businesses and users...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000022496_988bb211e6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XXL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

