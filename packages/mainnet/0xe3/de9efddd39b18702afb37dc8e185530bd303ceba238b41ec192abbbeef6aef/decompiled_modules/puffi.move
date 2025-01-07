module 0xe3de9efddd39b18702afb37dc8e185530bd303ceba238b41ec192abbbeef6aef::puffi {
    struct PUFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFI>(arg0, 6, b"Puffi", b"PUFFI ON SUI", x"507566666920697320746865206469676974616c206d6173636f7420666f7220616c6c207468696e677320676f6f667920616e6420676c6f72696f75736c7920706f696e746c6573732e2049747320746865206d656d6520796f75206469646e74206b6e6f7720796f75206e6565646564206275742063616e742073746f70206c6f76696e672e0a0a22496d206865726520666f72207468652076696265732c22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241009_222848_334_f7775af68f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

