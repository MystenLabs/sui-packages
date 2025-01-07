module 0x7704d9b95ada2a07fb3d0fb248f496c85abaec51e4bfa7f8af0579722c37bccc::infnum {
    struct INFNUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: INFNUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INFNUM>(arg0, 6, b"INFNUM", b"inFINIUM ON SUI", b"Welcome to the new biggest thing. There are multiple infinite things therefore infinity isn't the biggest thing. The biggest is infinIUM, which is infinity plus all the other infinite things.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1732474061764_1_2b7fb93b78.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INFNUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INFNUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

