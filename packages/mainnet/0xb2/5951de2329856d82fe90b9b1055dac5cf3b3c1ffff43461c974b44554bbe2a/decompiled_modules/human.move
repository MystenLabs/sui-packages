module 0xb25951de2329856d82fe90b9b1055dac5cf3b3c1ffff43461c974b44554bbe2a::human {
    struct HUMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMAN>(arg0, 6, b"Human", b"Humans", x"596f752061726520612048756d616e20796f75206d7573742064657461696e2048756d616e730a73686f7720796f75722062656c6f6e67696e6720616e64206a6f696e2074686520382062696c6c696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_d_A_cran_2024_10_04_185732_66deeb42e1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

