module 0x7f6ebfdc2df97bd4b1116814c4d1920205d9219718f585c40d7e991be7da3c05::blackhat {
    struct BLACKHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKHAT>(arg0, 6, b"BLACKHAT", b"Black Hat On Sui", x"506f736974696f6e656420616e6420726561647920666f72206c61756e63682c207468652042756c6c2052756e20666c61672077696c6c20626520706c616e746564206f6e20746865204d6f6f6e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250430_020843_556_b0790617d9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

