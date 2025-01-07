module 0x135c0a8e1912b412208edd2ef8556ddb7a65ed2259cacd8329b148c55916ff74::donk {
    struct DONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONK>(arg0, 6, b"DONK", b"Donk SUI", x"4d4545542024444f4e4b20596565686177212024444f4e4b20697320726561647920746f206b69636b20736f6d6520617373657321204d6f7665206f76657220646f67732c2066726f67732c20616e64206361747320206974732074696d6520666f722074686520646f6e6b65792074616b656f766572212024444f4e4b206973206865726520746f206272696e6720746865206d656d652067616d6520746f20612077686f6c65206e6577206c6576656c2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_19_28_35_a57069bb25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

