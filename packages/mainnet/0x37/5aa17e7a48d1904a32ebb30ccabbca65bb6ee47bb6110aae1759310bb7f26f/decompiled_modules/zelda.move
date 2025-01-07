module 0x375aa17e7a48d1904a32ebb30ccabbca65bb6ee47bb6110aae1759310bb7f26f::zelda {
    struct ZELDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZELDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZELDA>(arg0, 6, b"ZELDA", b"ZELDA CAT ON SUI", b" ZELDA, an orange cat with deep, expressive eyes, lived between alleyways, well-known and admired by the local residents.Dexscreener Paid.Check here: https://zeldaonsui.pro/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_10_2_96d71ca082.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZELDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZELDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

