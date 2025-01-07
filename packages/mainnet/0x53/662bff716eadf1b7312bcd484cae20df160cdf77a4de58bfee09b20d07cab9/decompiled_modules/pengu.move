module 0x53662bff716eadf1b7312bcd484cae20df160cdf77a4de58bfee09b20d07cab9::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"PENGU", b"Sui Pengu", b"Pengu is a penguing that loves to be treated like a king. Bring him food to his bed or hell eat you alive.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_09_T201841_423_5e7d1d03ca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

