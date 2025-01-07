module 0xfc95f0731fc95cacd0d443ec6c296ce91125e1df08d885bb09bf3c09e5167c6::SUILOWEEN {
    struct SUILOWEEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOWEEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILOWEEN>(arg0, 6, b"SUILOWEEN", b"SUILOWEEN", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/ClNfMPT.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILOWEEN>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOWEEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILOWEEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

