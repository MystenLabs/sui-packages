module 0x4b8b45d79504909c8b5ec84a0519a3c6b2c3a816250ea88322a77b3897e0ec39::ais {
    struct AIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIS>(arg0, 6, b"Ais", b"Sui on AI", b"Sui on Ai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/834f3887bde180c0d471f00389466b9c_31aec0cf3f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

