module 0x4f1d169562f88e56711e99d6ec29b8766b4eee5f1fd0c97749c6fc1cf4d5205b::insui {
    struct INSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INSUI>(arg0, 6, b"InSui", b"InfinitySui", b"aiming to achieve high throughput, low latency, and scalability while maintaining security and decentralization", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736439859136.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

