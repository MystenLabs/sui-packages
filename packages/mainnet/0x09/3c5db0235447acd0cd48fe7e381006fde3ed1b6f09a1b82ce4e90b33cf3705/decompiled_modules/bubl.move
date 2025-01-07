module 0x93c5db0235447acd0cd48fe7e381006fde3ed1b6f09a1b82ce4e90b33cf3705::bubl {
    struct BUBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector_v3::new<BUBL>(arg0, 5581331741639261749, b"BUBL", b"BUBL", b"Bubbling on Su iNetwork to make frens.", b"https://images.hop.ag/ipfs/Qmbf752EhgUbtLCph7R9XuGYiWQZKdyCaA8Bo5afpwuNiY", 0x1::string::utf8(b"https://x.com/bublsui"), 0x1::string::utf8(b"https://bublsui.com"), 0x1::string::utf8(b"https://t.me/bublsui"), arg1);
    }

    // decompiled from Move bytecode v6
}

