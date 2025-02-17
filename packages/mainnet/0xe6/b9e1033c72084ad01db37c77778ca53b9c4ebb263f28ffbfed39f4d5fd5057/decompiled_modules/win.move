module 0xe6b9e1033c72084ad01db37c77778ca53b9c4ebb263f28ffbfed39f4d5fd5057::win {
    struct WIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WIN>(arg0, 9, b"WIN", b"Win", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://winx.io/WIN.svg")), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

