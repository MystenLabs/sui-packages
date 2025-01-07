module 0x82be668bffa9819a7cf688242ee8a85712eb8d16da97c0322e2cf0d50ec6d868::antichill {
    struct ANTICHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTICHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANTICHILL>(arg0, 6, b"ANTICHILL", b"Anti Chill Guy", x"416e7469206368696c6c2069732074686520233120656e656d79206f66206368696c6c206775792e2e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042845_330d94db90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTICHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANTICHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

