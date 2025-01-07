module 0x3f1150e189f5f756f89ea6db208b53584217bbddda36beab594424fb5fec658a::wap {
    struct WAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAP>(arg0, 6, b"WAP", b"Wet Ass Pussy", b"Her name is $WAP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6646_7d331d50c3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

