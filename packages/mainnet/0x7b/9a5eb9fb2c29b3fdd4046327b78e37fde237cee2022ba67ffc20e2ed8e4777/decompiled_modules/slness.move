module 0x7b9a5eb9fb2c29b3fdd4046327b78e37fde237cee2022ba67ffc20e2ed8e4777::slness {
    struct SLNESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLNESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLNESS>(arg0, 6, b"SLNESS", b"suilionness", b"SUI lionness", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/download_6452f9c2f8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLNESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLNESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

