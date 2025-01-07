module 0x94cbd438d23c58a09e6d7b92c53a007edd01b062976d6c593a7f78ca446940ac::wuj {
    struct WUJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUJ>(arg0, 6, b"Wuj", b"Wbjn", b"Snnnnnn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CHAD_20240918_115126_0000_3c784f274c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

