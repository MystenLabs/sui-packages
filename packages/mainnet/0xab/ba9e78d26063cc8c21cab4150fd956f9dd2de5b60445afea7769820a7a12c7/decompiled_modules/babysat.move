module 0xabba9e78d26063cc8c21cab4150fd956f9dd2de5b60445afea7769820a7a12c7::babysat {
    struct BABYSAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSAT>(arg0, 6, b"BABYSAT", b"BabySealCat", b"Cat + Seal = BabySealCat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7264_9174db588f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

