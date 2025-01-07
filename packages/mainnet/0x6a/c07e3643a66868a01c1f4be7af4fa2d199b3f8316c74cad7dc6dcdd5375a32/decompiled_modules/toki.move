module 0x6ac07e3643a66868a01c1f4be7af4fa2d199b3f8316c74cad7dc6dcdd5375a32::toki {
    struct TOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKI>(arg0, 9, b"TOKI", b"Toki on SUI", b"$TOKI, the Dragon featured in The Night Riders book by Matt Furie.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x65086e9928d297ebae6a7d24d8c3aea6f8f6b5d7.png?size=xl&key=ee258b")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOKI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

