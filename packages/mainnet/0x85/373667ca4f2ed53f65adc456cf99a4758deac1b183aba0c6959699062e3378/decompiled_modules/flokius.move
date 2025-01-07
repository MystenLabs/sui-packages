module 0x85373667ca4f2ed53f65adc456cf99a4758deac1b183aba0c6959699062e3378::flokius {
    struct FLOKIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOKIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOKIUS>(arg0, 9, b"FLOKIUS", b"Flokius Maximus", b"Flokius Maximus - Elon's Loved Corgi, Maximus Style", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x218d9c9950f13301d5591e32f138464112cdacda.png?size=xl&key=7b2b77")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FLOKIUS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOKIUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOKIUS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

