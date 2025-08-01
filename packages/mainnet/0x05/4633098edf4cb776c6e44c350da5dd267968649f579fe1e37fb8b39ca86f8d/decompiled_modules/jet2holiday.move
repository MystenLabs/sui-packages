module 0x54633098edf4cb776c6e44c350da5dd267968649f579fe1e37fb8b39ca86f8d::jet2holiday {
    struct JET2HOLIDAY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JET2HOLIDAY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JET2HOLIDAY>>(0x2::coin::mint<JET2HOLIDAY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JET2HOLIDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JET2HOLIDAY>(arg0, 2, b"JET2HOLIDAY", b"JET2HOLIDAY COIN", b"Nothing beats it! Jet 2 Holiday and right now you can save 50 pounds per person", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.unsplash.com/photo-1679485003578-f75fa2ee76ab?q=80&w=2900&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<JET2HOLIDAY>>(0x2::coin::mint<JET2HOLIDAY>(&mut v2, 300000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JET2HOLIDAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JET2HOLIDAY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

