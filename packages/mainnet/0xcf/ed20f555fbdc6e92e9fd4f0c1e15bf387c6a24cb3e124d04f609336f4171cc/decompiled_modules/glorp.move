module 0xcfed20f555fbdc6e92e9fd4f0c1e15bf387c6a24cb3e124d04f609336f4171cc::glorp {
    struct GLORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLORP>(arg0, 6, b"GLORP", b"Glorp the Elephant Seal", x"486973206e616d6520697320476c6f72702e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/glorp_7578349240.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLORP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLORP>>(v1);
    }

    // decompiled from Move bytecode v6
}

