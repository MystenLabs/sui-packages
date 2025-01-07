module 0x51fb4d772202fb4053f086c2a6246dc55e6c0ca914dc57b58e6f7bb2e8fcd639::chillxmas {
    struct CHILLXMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLXMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLXMAS>(arg0, 6, b"CHILLXMAS", b"CHILLXMAS On Sui", b"Just chilling on Sui all season!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_03_03_00_47_a30677608a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLXMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLXMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

