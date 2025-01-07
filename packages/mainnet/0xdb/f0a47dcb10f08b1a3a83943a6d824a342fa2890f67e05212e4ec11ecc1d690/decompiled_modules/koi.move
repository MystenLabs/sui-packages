module 0xdbf0a47dcb10f08b1a3a83943a6d824a342fa2890f67e05212e4ec11ecc1d690::koi {
    struct KOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOI>(arg0, 6, b"KOI", b"KOISUI", b"Koi On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0072_190a060c49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

