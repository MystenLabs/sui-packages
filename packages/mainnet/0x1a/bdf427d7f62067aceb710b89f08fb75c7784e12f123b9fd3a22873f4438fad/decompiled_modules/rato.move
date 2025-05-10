module 0x1abdf427d7f62067aceb710b89f08fb75c7784e12f123b9fd3a22873f4438fad::rato {
    struct RATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATO>(arg0, 9, b"RATO", b"Rato The Rat", b"The newest Matt Furie character.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xf816507e690f5aa4e29d164885eb5fa7a5627860.png?size=xl&key=4a5296")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<RATO>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATO>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

