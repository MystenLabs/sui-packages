module 0x301a9e45f0fb4147055aebf7f9e7f49292591edf5495e7555df921c7f89f816e::asu {
    struct ASU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASU>(arg0, 6, b"ASU", b"ASU SUI", x"415355205355492c20626c69737366756c6c79206c6f756e67696e67206f6e20610a6d6f756e7461696e206f66206361736821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730968586300.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

