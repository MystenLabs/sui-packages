module 0xeb13d3b2d68c3f0d71d85a00c3af176bbef4cb67e89fbe1490e9fafafde8288b::jackson {
    struct JACKSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: JACKSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JACKSON>(arg0, 6, b"Jackson", b"Michael Jackson", b"The King of Pop's Official Account", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/I20_I31_US_400x400_7f962d5c6f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JACKSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JACKSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

