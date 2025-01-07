module 0x4516588734bd0c0ae2a541da5fc464014251cc7eeeebc429347dd2dd9140eb6d::todd {
    struct TODD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TODD>(arg0, 6, b"TODD", b"PETER TODD", b"The real Satoshi nakamuto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000824499_8d833d8372.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TODD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TODD>>(v1);
    }

    // decompiled from Move bytecode v6
}

