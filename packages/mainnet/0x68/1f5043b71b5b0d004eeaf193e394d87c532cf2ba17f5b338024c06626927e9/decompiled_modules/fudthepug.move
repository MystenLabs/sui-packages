module 0x681f5043b71b5b0d004eeaf193e394d87c532cf2ba17f5b338024c06626927e9::fudthepug {
    struct FUDTHEPUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUDTHEPUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUDTHEPUG>(arg0, 6, b"FUDTHEPUG", b"FUDTHEPUG ", x"466972737420465544505547206f6e20405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967270600.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUDTHEPUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUDTHEPUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

