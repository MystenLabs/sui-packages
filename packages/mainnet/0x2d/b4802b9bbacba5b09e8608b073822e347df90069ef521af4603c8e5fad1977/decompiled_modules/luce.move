module 0x2db4802b9bbacba5b09e8608b073822e347df90069ef521af4603c8e5fad1977::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCE>(arg0, 6, b"LUCE", b"Official Mascot of the Holy Year", b"The Vatican has unveiled the official mascot of the Holy Year 2025: Luce (Italian for Light). Archbishop Fisichella says the mascot was inspired by the Church's desire \"to live even within the pop culture so beloved by our youth.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmNzBmiH4jsj8486brCKCyb5qCu1XuJAwe4z7uBPu8RgPu")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<LUCE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<LUCE>(4562593739763284760, v0, v1, 0x1::string::utf8(b"https://x.com/BelieveInLuce"), 0x1::string::utf8(b"https://www.catholicnewsagency.com/news/260129/meet-luce-the-vatican-s-cartoon-mascot-for-jubilee-2025"), 0x1::string::utf8(b"https://t.me/believeinluce"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

