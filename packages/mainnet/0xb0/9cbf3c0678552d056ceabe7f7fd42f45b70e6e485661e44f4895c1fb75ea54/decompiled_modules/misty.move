module 0xb09cbf3c0678552d056ceabe7f7fd42f45b70e6e485661e44f4895c1fb75ea54::misty {
    struct MISTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MISTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MISTY>(arg0, 6, b"MISTY", b"MISTY ON SUI", b"$MISTY is introducing a new and exciting element to the $SUI ecosystem, enhancing its value and appeal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/misty_portal_1a685b4653.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MISTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MISTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

