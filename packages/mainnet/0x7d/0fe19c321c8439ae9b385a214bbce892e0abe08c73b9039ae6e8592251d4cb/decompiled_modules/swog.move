module 0x7d0fe19c321c8439ae9b385a214bbce892e0abe08c73b9039ae6e8592251d4cb::swog {
    struct SWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOG>(arg0, 6, b"SWOG", b"SuiFWOG", x"496e20746865206173686573206120636f6d6d756e69747920656d65726765642c2061206e657720666c6f672c2061206d6f726520626173656420666c6f672c20612046574f472e0a0a46574f4720686173206e6f206465762e2049742069732074686520636f6d6d756e6974792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000092085_668ac05f5a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

