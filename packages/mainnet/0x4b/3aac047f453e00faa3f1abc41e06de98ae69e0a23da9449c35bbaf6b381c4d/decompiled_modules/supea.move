module 0x4b3aac047f453e00faa3f1abc41e06de98ae69e0a23da9449c35bbaf6b381c4d::supea {
    struct SUPEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPEA>(arg0, 6, b"SUPEA", b"Supea", b"MAKE SUI TOKENS GREAT AGAIN!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_14_16_54_24_e2ce377221.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

