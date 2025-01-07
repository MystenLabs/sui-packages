module 0x2a17a31dffab47cfe8f526d34c578f9ba6f5e58217bd17ea0abfad938653603a::batman {
    struct BATMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATMAN>(arg0, 6, b"BATMAN", b"BATMAN COIN ON SUI", b"$BATMAN is the next big thing on SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2023_11_02_19_58_08_1_880a7b0f75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BATMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

