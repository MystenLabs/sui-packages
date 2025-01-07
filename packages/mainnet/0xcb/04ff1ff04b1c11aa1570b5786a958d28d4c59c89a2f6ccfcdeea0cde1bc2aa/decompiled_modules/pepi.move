module 0xcb04ff1ff04b1c11aa1570b5786a958d28d4c59c89a2f6ccfcdeea0cde1bc2aa::pepi {
    struct PEPI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPI>, arg1: 0x2::coin::Coin<PEPI>) {
        0x2::coin::burn<PEPI>(arg0, arg1);
    }

    fun init(arg0: PEPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPI>(arg0, 9, b"pepi", b"PEPI", b"PEPI cute pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HERKVcRndJSudJB2L8TaZP1akeBakoRhvhKoaArBrJ46.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPI>>(v1);
        0x2::coin::mint_and_transfer<PEPI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PEPI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

