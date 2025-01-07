module 0x68686c7e954af2d8bfef2ab43447ae1534005d8a56b7ebd0340fe7cfda7f5d85::suiba {
    struct SUIBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBA>(arg0, 6, b"Suiba", b"Suibabot", b"Suibabot - Sui's fastest bot to trade coins, and SUIBA's official Telegram trading bot.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSwXgMoo5rydqLo5XZVXAuoRxCmBnAs5dJmWR3SscZibe")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUIBA>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUIBA>(3568380369122225805, v0, v1, 0x1::string::utf8(b"https://x.com/SuibaOnSUI"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/suibainu_bot?start=ref_5725196644"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

