module 0xaaab400c8f037230c2c898a3ae818afc33341f4200e73e4159d951331c1259db::bgs {
    struct BGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGS>(arg0, 6, b"Bgs", b"The bnb guy on sui", b"On sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000879132_2352e3f292.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

