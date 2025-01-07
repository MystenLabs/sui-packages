module 0xa32cf602cf1efc029179b81ecbeb0ebe23215af693461b55acd5f20ada55d538::wwh {
    struct WWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: WWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WWH>(arg0, 6, b"WWH", b"Walrus Wif Hat", b"Walrus Dog Was Cold.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_21_19_08_05_5eab9b1996.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

