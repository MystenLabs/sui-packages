module 0xb4205efb9fc303488a52659e5c03d79134d16adc089849853f603cc676b4c80::suisnail {
    struct SUISNAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISNAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISNAIL>(arg0, 6, b"SUISNAIL", b"Sui Snail", b"suisnail.com . Smoking Sui Snail is a relaxed, witty companion representing your inner chill on the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_14_144913_a578c10e54.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISNAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISNAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

