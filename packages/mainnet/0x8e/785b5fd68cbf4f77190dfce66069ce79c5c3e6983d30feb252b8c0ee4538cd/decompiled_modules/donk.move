module 0x8e785b5fd68cbf4f77190dfce66069ce79c5c3e6983d30feb252b8c0ee4538cd::donk {
    struct DONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONK>(arg0, 6, b"DONK", b"Donk On Sui", x"4d4545542024444f4e4b20596565686177212024444f4e4b20697320726561647920746f206b69636b20736f6d6520617373657321204d6f7665206f76657220646f67732c2066726f67732c20616e642063617473206974732074696d6520666f722074686520646f6e6b65792074616b656f766572212024444f4e4b206973206865726520746f206272696e6720746865206d656d652067616d6520746f20612077686f6c65206e6577206c6576656c2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_19_28_35_1f80374b78_7667a3def7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

