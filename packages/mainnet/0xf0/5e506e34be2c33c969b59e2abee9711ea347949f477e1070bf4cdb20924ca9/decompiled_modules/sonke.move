module 0xf05e506e34be2c33c969b59e2abee9711ea347949f477e1070bf4cdb20924ca9::sonke {
    struct SONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SONKE>(arg0, 6, b"SONKE", b"BLUE PONKE", b"The blue monkey on the blue chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_29_9dd39f9db8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

