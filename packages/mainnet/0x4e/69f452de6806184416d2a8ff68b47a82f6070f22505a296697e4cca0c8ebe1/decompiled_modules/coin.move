module 0x4e69f452de6806184416d2a8ff68b47a82f6070f22505a296697e4cca0c8ebe1::coin {
    struct COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<COIN>(arg0, 6, b"BCHD", b"BOKACHODA", b"BE CARE FULL ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suipump.meme/uploads/Screenshot_2024_08_29_025311_91f8cb02a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

