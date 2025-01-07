module 0x7a4e7afa879414a02278cdd9f937ba4a1801c578f576bcfe07f3b74cdc66f6f6::wcd {
    struct WCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCD>(arg0, 6, b"WCD", b"World Childrens Day", b"Listen To The Future | 2024 | UNICEF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/WCD_3a56e17292.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

