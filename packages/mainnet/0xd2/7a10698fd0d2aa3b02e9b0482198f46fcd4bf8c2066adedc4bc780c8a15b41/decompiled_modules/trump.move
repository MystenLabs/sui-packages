module 0xd27a10698fd0d2aa3b02e9b0482198f46fcd4bf8c2066adedc4bc780c8a15b41::trump {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 6, b"TRUMP", b"Donald J. Trump", x"446f6e616c64204a205472756d702e0a3437746820507265736964656e74206f662074686520556e69746564205374617465732c206669676874696e6720666f7220416d6572696361", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x95a2728bedb8798c4a06eb67865912f837a8c95907396de662a3d4dc6aab514a_trump_trump_4842ea4b3c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

