module 0x467bb5584ca0299fc39e2956f16a33fc127ad889a22472b89e7758cdd2f53d87::nepe {
    struct NEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPE>(arg0, 9, b"NEPE", b"Neiro Pepe Wif Suit", b"Neiro Pepe Inu ($NEPE) is combining strong narratives in the space and is on it's way to become a T1-Memecoin in the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x89b9d56969a930bd3b4b56dd040f218e5dc4aba6.png?size=lg&key=89834f")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

