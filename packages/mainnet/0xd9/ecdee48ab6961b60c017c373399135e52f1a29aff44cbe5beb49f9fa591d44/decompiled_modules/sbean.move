module 0xd9ecdee48ab6961b60c017c373399135e52f1a29aff44cbe5beb49f9fa591d44::sbean {
    struct SBEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBEAN>(arg0, 6, b"SBEAN", b"Sui Beans", b"https://telegra.ph/SUI-BEAN-10-05https://telegra.ph/SUI-BEAN-10-05", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000059748_98a3ebea0c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

