module 0xaae21bb1e797a07e2b748da197612f1425468012f5da3a2eca84280704853b42::oni {
    struct ONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONI>(arg0, 6, b"ONI", b"Oni Cat", b"Why $ONI? Iconic & lovable characters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073756_ec6aebafe8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONI>>(v1);
    }

    // decompiled from Move bytecode v6
}

