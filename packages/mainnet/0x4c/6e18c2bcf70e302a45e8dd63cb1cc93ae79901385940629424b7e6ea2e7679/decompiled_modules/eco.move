module 0x4c6e18c2bcf70e302a45e8dd63cb1cc93ae79901385940629424b7e6ea2e7679::eco {
    struct ECO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ECO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ECO>(arg0, 6, b"ECO", b"EcoToken", b"A sustainable cryptocurrency that supports environmental initiatives and reduces carbon footprint", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/046b5d03_6281_11ee_95f4_318d05e0a674_3089ac2409.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ECO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ECO>>(v1);
    }

    // decompiled from Move bytecode v6
}

