module 0xb2de9c0ebaa8d8045c66678549d12baecf4a73b51ff301f31a24cc7a584d009d::dts {
    struct DTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTS>(arg0, 6, b"DTS", b"Donald Trump Sui", b"Donald Trump (1946-), American business magnate", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_17_45_35_efd9cc65e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

