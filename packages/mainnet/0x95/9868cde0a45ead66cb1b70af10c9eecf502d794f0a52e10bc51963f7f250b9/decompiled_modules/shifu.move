module 0x959868cde0a45ead66cb1b70af10c9eecf502d794f0a52e10bc51963f7f250b9::shifu {
    struct SHIFU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIFU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIFU>(arg0, 9, b"SHIFU", b"Shifu in SUI", x"2453484946552e2041206d656d65636f696e20627920536869626120496e7520616e6420496d6167696e617279204f6e65732e0a0a546865206d656d65636f696e20776f726c6420686173206c6f737420697473207761792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x2cc7a972ebc1865b346085655f929abfa74cd4dc.png?size=xl&key=95e1ba")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIFU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIFU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIFU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

