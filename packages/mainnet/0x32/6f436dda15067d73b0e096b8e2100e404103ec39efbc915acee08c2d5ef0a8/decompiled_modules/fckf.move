module 0x326f436dda15067d73b0e096b8e2100e404103ec39efbc915acee08c2d5ef0a8::fckf {
    struct FCKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCKF>(arg0, 6, b"FCKF", b"F*CK FUN", b"Introducing F*CK FUN  the real response to empty promises. While others talk big and fail to deliver, we act. No gimmicks, no delays, just a straightforward token that says what everyones thinking. Time to take back control. Say it loud: F*CK FUN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/FCKFN_af7731f3b6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

