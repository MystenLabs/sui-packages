module 0x5108b83c2de0b9c1a6c63ef9377be8f06688a35b9b7e3ad517524c477c55a597::slub {
    struct SLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUB>(arg0, 9, b"SLUB", b"SLUB", b"Slub with the slub moves.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/C3Tqmrgp7oKE6x5TmZaig5nVV4EPnQcw2BZyVRXboop.png?size=xl&key=958f26")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SLUB>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUB>>(v2, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

