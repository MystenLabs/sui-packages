module 0x8d36376cefddf45a93c269c30d4a5f3d1a55bd54eaf0863e57ccab9ecf7e7498::rk {
    struct RK has drop {
        dummy_field: bool,
    }

    fun init(arg0: RK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RK>(arg0, 9, b"RK", b"Rajiv", b"My personal meme coin for fun purposes.  I will never sell and keep pump . Sky is the limit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c52bb84-a7a1-405c-91d8-cea68a669873.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RK>>(v1);
    }

    // decompiled from Move bytecode v6
}

