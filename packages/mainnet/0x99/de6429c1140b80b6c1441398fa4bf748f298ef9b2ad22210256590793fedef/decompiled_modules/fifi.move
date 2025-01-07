module 0x99de6429c1140b80b6c1441398fa4bf748f298ef9b2ad22210256590793fedef::fifi {
    struct FIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIFI>(arg0, 6, b"FiFi", b"FunFi", x"46756e46693a2049676e6974696e6720746865206d656d6520636f696e207265766f6c7574696f6e2e20496e7374616e74206372656174696f6e2c206c696d69746c6573732066756e206f6e20537569204e6574776f726b2e220a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1001575000_5a4a8168f1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

