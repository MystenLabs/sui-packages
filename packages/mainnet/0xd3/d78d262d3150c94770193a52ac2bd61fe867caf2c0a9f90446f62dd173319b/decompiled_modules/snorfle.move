module 0xd3d78d262d3150c94770193a52ac2bd61fe867caf2c0a9f90446f62dd173319b::snorfle {
    struct SNORFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNORFLE>(arg0, 6, b"SNORFLE", b"SuiSnorfle", b"Snorfle your way to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_050847724_33b098be0e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNORFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNORFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

