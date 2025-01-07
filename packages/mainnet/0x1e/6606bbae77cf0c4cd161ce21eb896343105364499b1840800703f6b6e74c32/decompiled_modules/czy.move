module 0x1e6606bbae77cf0c4cd161ce21eb896343105364499b1840800703f6b6e74c32::czy {
    struct CZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZY>(arg0, 6, b"CZY", b"CRAZY", b"The world is crazy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture_d_A_cran_2024_11_17_154408_5932616247.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

