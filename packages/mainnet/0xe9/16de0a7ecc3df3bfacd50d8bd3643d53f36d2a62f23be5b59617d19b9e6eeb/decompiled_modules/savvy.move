module 0xe916de0a7ecc3df3bfacd50d8bd3643d53f36d2a62f23be5b59617d19b9e6eeb::savvy {
    struct SAVVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVVY>(arg0, 6, b"Savvy", b"Savvy  Sloth", b" The most techy sloth on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_28_01_16_24_f5e2e10e1f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

