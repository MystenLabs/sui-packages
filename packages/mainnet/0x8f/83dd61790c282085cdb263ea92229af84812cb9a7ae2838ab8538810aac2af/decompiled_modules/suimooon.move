module 0x8f83dd61790c282085cdb263ea92229af84812cb9a7ae2838ab8538810aac2af::suimooon {
    struct SUIMOOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMOOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMOOON>(arg0, 6, b"SUIMOOON", b"SUIMOON", b"SuiMoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_23_42_06_2b9dfab791.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMOOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMOOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

