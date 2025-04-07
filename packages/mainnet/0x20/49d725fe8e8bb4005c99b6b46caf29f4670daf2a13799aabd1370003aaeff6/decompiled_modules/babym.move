module 0x2049d725fe8e8bb4005c99b6b46caf29f4670daf2a13799aabd1370003aaeff6::babym {
    struct BABYM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYM>(arg0, 6, b"BABYM", b"Baby Movepump", b"Movepump but baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012723_0665798f55.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYM>>(v1);
    }

    // decompiled from Move bytecode v6
}

