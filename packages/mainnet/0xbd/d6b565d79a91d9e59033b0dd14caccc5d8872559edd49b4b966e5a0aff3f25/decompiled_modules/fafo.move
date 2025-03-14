module 0xbdd6b565d79a91d9e59033b0dd14caccc5d8872559edd49b4b966e5a0aff3f25::fafo {
    struct FAFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAFO>(arg0, 6, b"FAFO", b"Fed Agency for Fin Oversight", b"Fed Agency for Fin Oversight.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/ZkMEpzJkMNMq6TsRAc8XfavHEbPEZwXWLZeJoxqpump.png?size=lg&key=ecadf8")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FAFO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAFO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

