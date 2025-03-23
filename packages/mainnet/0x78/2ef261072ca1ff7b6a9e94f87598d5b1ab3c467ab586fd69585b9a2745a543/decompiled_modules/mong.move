module 0x782ef261072ca1ff7b6a9e94f87598d5b1ab3c467ab586fd69585b9a2745a543::mong {
    struct MONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONG>(arg0, 6, b"MONG", b"Mong", x"4d4f4e472069736e2774206a7573742061206d656d65636f696e3b206974206973206120776179206f66206c6966652c20612063616c6c20746f2061726d7320666f722074686f73652077686f206461726520746f206c697665206f6e2074686520656467652c0a4c69766520746865204d4f4e47206c6966652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/r5_Vlii_JH_400x400_4bd3717430.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

