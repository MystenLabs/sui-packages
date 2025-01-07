module 0xd94502d3c1f942d0adc3b3d3a5a39fd5d788f3ab75b2a2a228b7b61269697bc1::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"Luce", b"Luce", b"The Vatican has unveiled the official mascot of the Holy Year 2025: Luce (Italian for Light). Archbishop Fisichella says the mascot was inspired by the Church's desire \"to live even within the pop culture so beloved by our youth.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmZDVFcDL7L4uHZ5iARsnAxdqew8XGas2DirU6Pc4iB9jw")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<LUCE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<LUCE>(11693035820840435548, v0, v1, 0x1::string::utf8(b"https://x.com/CatholicTV/status/1850904910180532432?s=19"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

