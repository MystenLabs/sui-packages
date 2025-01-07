module 0xb31d66567e2a6e6d746a5378729dd89d2535b8cfa7b8227e58ef1d9c6a2c1d71::zucwifbutt {
    struct ZUCWIFBUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZUCWIFBUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZUCWIFBUTT>(arg0, 6, b"ZucWifButt", b"Zuc Wif Butt", b"Welcome to $ZucWifButt, the most cheeky token on the SUI network! Here, we embrace the power of Mark Zuckerberg like you've never seen before bigger, bolder, and with a butt that breaks the internet. This token is a celebration of curves and innovation, combining the genius of tech with a sense of humor that's impossible to ignore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_52_05e22c08b4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZUCWIFBUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZUCWIFBUTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

