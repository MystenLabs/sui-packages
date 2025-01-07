module 0x60fa367f05f85aca2eab8e4bedfc55e3611595f98fca84841bd62dca73103980::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 6, b"LOVE", b"love", b"Musk is LOVE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730909243612.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOVE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

