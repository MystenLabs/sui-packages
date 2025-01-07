module 0x96425d60c95c88721d7830b3c3e19f59609a61dcba37b1be1d96840b48f6180f::pepi {
    struct PEPI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPI>, arg1: 0x2::coin::Coin<PEPI>) {
        0x2::coin::burn<PEPI>(arg0, arg1);
    }

    fun init(arg0: PEPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPI>(arg0, 9, b"cute pepi", b"PEPI", b"abcd pepi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/HERKVcRndJSudJB2L8TaZP1akeBakoRhvhKoaArBrJ46.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPI>>(v1);
        0x2::coin::mint_and_transfer<PEPI>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

