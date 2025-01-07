module 0x81faa2b9d827caf9f8757009580148ce7afdf1404421840bfae383a0ad340587::pegram {
    struct PEGRAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEGRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEGRAM>(arg0, 6, b"PEGRAM", b"PEGRAM on SUI", x"5468652050657065204169206469616772616d20636f6e6e656374696f6e206f6e205355490a0a2070657065202b20474e4f4e203d2070656772616d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5_Ewfylk_W_400x400_4e8afdb322.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEGRAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEGRAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

