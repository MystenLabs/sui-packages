module 0xca2fa9dbe801872c90833f1882f8942486b56e5183d22c49999213d50dd22128::cts {
    struct CTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTS>(arg0, 6, b"CTS", b"CRYPTOTIGERSUI", b"Tiger promises to bring lots of joy and laughter to the Sui Network community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_23daa741d0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

