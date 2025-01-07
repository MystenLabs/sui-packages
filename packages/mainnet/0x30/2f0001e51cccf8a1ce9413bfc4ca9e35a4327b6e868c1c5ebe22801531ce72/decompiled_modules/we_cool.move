module 0x302f0001e51cccf8a1ce9413bfc4ca9e35a4327b6e868c1c5ebe22801531ce72::we_cool {
    struct WE_COOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: WE_COOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WE_COOL>(arg0, 9, b"WE_COOL", b"weco", b"I was inspired on youtube", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5527348b-1002-4d52-b4f3-8a3ba481a46e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WE_COOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WE_COOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

