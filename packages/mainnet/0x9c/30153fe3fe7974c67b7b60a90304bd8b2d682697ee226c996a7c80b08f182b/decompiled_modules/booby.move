module 0x9c30153fe3fe7974c67b7b60a90304bd8b2d682697ee226c996a7c80b08f182b::booby {
    struct BOOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBY>(arg0, 6, b"BOOBY", b"BOOBY SUI", b"$Booby, Brett's Wingman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_09_33_24_3e075028a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

