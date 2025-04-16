module 0x167306095a50747c2ea873899e2c4c84451594e057f10e439e4f15eec6970030::yowie {
    struct YOWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOWIE>(arg0, 6, b"YOWIE", b"Yowie", b"Icy but hot, its Yowie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pump_IMG_c5aa6e317b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOWIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOWIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

