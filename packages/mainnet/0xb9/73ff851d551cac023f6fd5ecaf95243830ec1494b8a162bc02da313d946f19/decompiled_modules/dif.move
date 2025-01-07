module 0xb973ff851d551cac023f6fd5ecaf95243830ec1494b8a162bc02da313d946f19::dif {
    struct DIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIF>(arg0, 6, b"DIF", b"DEV IS FISH", b"NO DEV, DEV IS FISH DEV SUPPLY BURNT ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DEV_IS_FISH_0126435935.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

