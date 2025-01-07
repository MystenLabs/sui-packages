module 0x51082ef34105d133cce3e8bddd8ac5e79748c0d7eefe77c353ba4826500485bf::wos {
    struct WOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOS>(arg0, 6, b"WOS", b"Women on Sui", b"Only token for the women community on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flat_750x_075_f_pad_750x1000_f8f8f8_fbba89195e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

