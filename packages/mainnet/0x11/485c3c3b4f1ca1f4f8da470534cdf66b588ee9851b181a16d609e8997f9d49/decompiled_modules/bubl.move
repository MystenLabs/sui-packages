module 0x11485c3c3b4f1ca1f4f8da470534cdf66b588ee9851b181a16d609e8997f9d49::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v2::new<BUBL>(arg0, 7396309640371303017, b"Bubl", b"BUBL", b"HAVE FUN WITH BUBBLE SOAR WITH BUBBLE BUBBLE IT!", b"https://images.hop.ag/ipfs/Qmbf752EhgUbtLCph7R9XuGYiWQZKdyCaA8Bo5afpwuNiY", 0x1::string::utf8(b"https://x.com/bublsui"), 0x1::string::utf8(b"https://bublsui.com"), 0x1::string::utf8(b"https://t.me/bublsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

