module 0x14890ad960df7ed91d198fb5a66c69d786a403aa73f6f3cfb75781163f9a6cda::rico {
    struct RICO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICO>(arg0, 6, b"Rico", b"RICO", b"RICO The Rottweiler, Pepe's Dog Is Guarding The Sui Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_11_22_15_07_3d6bbbd868.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RICO>>(v1);
    }

    // decompiled from Move bytecode v6
}

