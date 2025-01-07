module 0x365c7c2b1e17c947b1766ef9ea939762c9cd400bc8dbf170239da7106d024b83::xiansui {
    struct XIANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIANSUI>(arg0, 6, b"XIANSUI", b"XIAN SUI", x"58696e2073750a0a78756520687561207069616f207069616f206265692066656e67207869616f207869616f0a0a2453756920646f65736e7420686176652061207374726f6e67206d656d65207965743f204e6f7420666f72206c6f6e672e2e2e20245849414e535549206973206865726520746f2074616b65206f76657220616e64206265636f6d6520746865206e6174697665206d656d65206b696e6721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/XINXUI_42aaec8d40.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XIANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

