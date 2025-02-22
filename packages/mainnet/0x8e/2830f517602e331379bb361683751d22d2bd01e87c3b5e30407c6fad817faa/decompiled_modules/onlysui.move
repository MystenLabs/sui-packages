module 0x8e2830f517602e331379bb361683751d22d2bd01e87c3b5e30407c6fad817faa::onlysui {
    struct ONLYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONLYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONLYSUI>(arg0, 6, b"ONLYSUI", b"Onlysui", b"Welcome to OnlySui  your ultimate destination for all things related to the Sui Network ecosystem!  Whether you're a seasoned blockchain enthusiast or just starting your journey, our platform provides you with the latest news, in-depth articles, and comprehensive knowledge to help you navigate the ever-evolving world of Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000067055_ad88ad862d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONLYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONLYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

