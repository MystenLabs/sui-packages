module 0x98e49011753b2ff947ba02076cbb321920ccb160e1caeacd1d4c6df920b582ec::swift {
    struct SWIFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWIFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWIFT>(arg0, 9, b"SWIFT", b"SWIFTPAW", b"Swiftpaw is the ultimate memecoin on the SUI blockchain, blending community spirit with playful adventure. Inspired by the quick and daring Swiftpaw character, this token aims to deliver fun and value to its holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F460050118_122154424112263711_7141379020474299253_n_da5b607f10.jpg&w=256&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SWIFT>(&mut v2, 2200000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWIFT>>(v2, @0x9bb6db5487f1e5b2c96d95d8212fde17560e1940b936de251f9bf0a9fd68e99c);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWIFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

