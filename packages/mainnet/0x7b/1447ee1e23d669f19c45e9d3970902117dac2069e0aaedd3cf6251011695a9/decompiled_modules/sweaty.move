module 0x7b1447ee1e23d669f19c45e9d3970902117dac2069e0aaedd3cf6251011695a9::sweaty {
    struct SWEATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEATY>(arg0, 6, b"SWEATY", b"Sui Sweaty", b"Sweaty in the sui blockchain. Bringing laughs and mischief to your feed", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000024218_944b110b37.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWEATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

