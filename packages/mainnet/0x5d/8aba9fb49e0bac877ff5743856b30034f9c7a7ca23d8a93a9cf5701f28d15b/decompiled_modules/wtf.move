module 0x5d8aba9fb49e0bac877ff5743856b30034f9c7a7ca23d8a93a9cf5701f28d15b::wtf {
    struct WTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTF>(arg0, 6, b"WTF", b"WTFCAT", b"WTF!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2961_ae640d2677.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

