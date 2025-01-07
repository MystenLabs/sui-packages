module 0xbf07ac4bdaf2e909fd9ece3acb01f9000dfee5e35966c0ee0463198fe56a9504::ball {
    struct BALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALL>(arg0, 6, b"BALL", b"Ball Up Top", b"Ball up top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/baa_2ac55882ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

