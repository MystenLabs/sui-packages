module 0xb2f982ebea5d17f42c7312d4a04901f996c0815ae9d7420b3a53ff61a8d20626::mcuban {
    struct MCUBAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCUBAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCUBAN>(arg0, 6, b"MCUBAN", b"Mark Cuban", x"4d61726b20437562616e206d656d6520636f696e206f6e205355490a0a526576656e7565206f662073616c6520676f657320746f205553205472656173757279200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047818_cffcc340ca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCUBAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCUBAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

