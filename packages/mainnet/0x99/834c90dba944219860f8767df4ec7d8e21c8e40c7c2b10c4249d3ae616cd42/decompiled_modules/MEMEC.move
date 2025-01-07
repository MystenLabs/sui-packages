module 0x99834c90dba944219860f8767df4ec7d8e21c8e40c7c2b10c4249d3ae616cd42::MEMEC {
    struct MEMEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEC>(arg0, 9, b"meme/coin", b"i now identify as a memecoin on Sui", b"Due to current market conditions I now identify as a memecoin on Sui blockchain. My pronouns are now Meme/Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/EPD9qjtFaFrR3GvTPmPt8spmu4hfwUN6Dc5tHtDmpump.png?size=xl&key=e53a52")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MEMEC>>(0x2::coin::mint<MEMEC>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MEMEC>>(v2);
    }

    // decompiled from Move bytecode v6
}

