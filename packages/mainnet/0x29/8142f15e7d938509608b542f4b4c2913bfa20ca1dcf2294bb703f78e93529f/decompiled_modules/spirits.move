module 0x298142f15e7d938509608b542f4b4c2913bfa20ca1dcf2294bb703f78e93529f::spirits {
    struct SPIRITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIRITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIRITS>(arg0, 6, b"SPIRITS", b"Sui Spirits", b"The Spirits of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732097007377.GIF")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPIRITS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIRITS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

