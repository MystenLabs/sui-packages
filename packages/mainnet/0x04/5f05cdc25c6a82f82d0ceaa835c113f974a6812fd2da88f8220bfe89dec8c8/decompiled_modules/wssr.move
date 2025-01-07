module 0x45f05cdc25c6a82f82d0ceaa835c113f974a6812fd2da88f8220bfe89dec8c8::wssr {
    struct WSSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSSR>(arg0, 6, b"Wssr", b"Wasser", b"Community token. GO WILD ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3131_2fad553aee.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

