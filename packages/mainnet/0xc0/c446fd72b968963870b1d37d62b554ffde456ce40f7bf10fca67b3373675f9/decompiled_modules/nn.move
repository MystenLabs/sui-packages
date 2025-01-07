module 0xc0c446fd72b968963870b1d37d62b554ffde456ce40f7bf10fca67b3373675f9::nn {
    struct NN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NN>(arg0, 6, b"NN", b"Nar Nya", x"4e6172204e796121202043617420726964696e67206e61727768616c2120536f20637574652c207965733f20204c696b652063727970746f2c20676f2075702c2075702c206d6179626520746f20746865206d6f6f6e21202042657374206d656d652c20796f752073686172652c206d616b652065766572796f6e6520736d696c652120484f444c20666f7220676f6f64206c75636b212020566572792066756e2c206d616b65206865617274207761726d21200a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000859_c6adc4f49b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NN>>(v1);
    }

    // decompiled from Move bytecode v6
}

