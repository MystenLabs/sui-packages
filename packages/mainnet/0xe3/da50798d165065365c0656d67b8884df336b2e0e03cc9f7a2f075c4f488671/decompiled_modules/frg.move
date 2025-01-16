module 0xe3da50798d165065365c0656d67b8884df336b2e0e03cc9f7a2f075c4f488671::frg {
    struct FRG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRG>(arg0, 6, b"Frg", b"FRG SUI", b"frg shall never kill frg.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250116_225840_673_1917719c45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRG>>(v1);
    }

    // decompiled from Move bytecode v6
}

