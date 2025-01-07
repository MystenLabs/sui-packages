module 0xbcd4e7f827b01c2c3200dfbf446c5da358d43a623214613394131b2e10c6b9b::mingmang {
    struct MINGMANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINGMANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINGMANG>(arg0, 6, b"MINGMANG", b"MingMang", b"First Ying-Yang Cult Coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/01cfbe74b2352826a7a6cb64e5d8e1010977c6_1933768312.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINGMANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINGMANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

