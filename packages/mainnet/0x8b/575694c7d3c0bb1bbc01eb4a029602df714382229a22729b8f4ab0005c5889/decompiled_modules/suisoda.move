module 0x8b575694c7d3c0bb1bbc01eb4a029602df714382229a22729b8f4ab0005c5889::suisoda {
    struct SUISODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISODA>(arg0, 6, b"SUISODA", b"Sui Soda", b"Only for the truly thirsty!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_38afe6dd2c.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

