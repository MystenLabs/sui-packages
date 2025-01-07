module 0x6b3ed7d41a90b0a71daebebfcd96c66f8bf72ee2dec89cd1492a9fa56fda629f::tk {
    struct TK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TK>(arg0, 6, b"TK", b"thanks broo", b"thanks broothanks broo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_03_22_6307a62dc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TK>>(v1);
    }

    // decompiled from Move bytecode v6
}

