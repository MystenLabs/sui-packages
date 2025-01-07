module 0xf0e193cf151b510f9ef9746e26b4cefc523a25a48053ee39b07795ef48c7b13::megs {
    struct MEGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEGS>(arg0, 6, b"MEGS", b"megs", b"we can only attempt to capture the spirit of the future; the true forms it will take are unrelatable and beyond conveyance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/222_fa245f7c35.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

