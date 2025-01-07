module 0x1e489c4353af4d13fd3e1d003a3d2ebe14a002476be7902c3781db9b57b7dca6::bepe {
    struct BEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEPE>(arg0, 6, b"BEPE", b"Bepe On Sui", b"Meme coin on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000360_719a31be8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

