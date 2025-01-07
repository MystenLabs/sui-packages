module 0x5cbe9b61a80b2eb13024e25f54be54a0acacb8e62524df15f1690eef4badb137::ronda {
    struct RONDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RONDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RONDA>(arg0, 9, b"Ronda", b"Ronda On Sui", b"Ronda On Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F4_D9_C2_D8_D_ADC_8_4_C68_B961_EA_385_DE_57289_58646f8093.JPEG&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RONDA>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RONDA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RONDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

