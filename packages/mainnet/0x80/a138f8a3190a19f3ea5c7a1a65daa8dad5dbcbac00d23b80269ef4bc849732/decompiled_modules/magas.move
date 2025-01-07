module 0x80a138f8a3190a19f3ea5c7a1a65daa8dad5dbcbac00d23b80269ef4bc849732::magas {
    struct MAGAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAS>(arg0, 9, b"MAGAS", b"MAGA on SUI", b"MAGA Movement on the SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x576e2bed8f7b46d34016198911cdf9886f78bea7.png?size=lg&key=d47759")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAGAS>(&mut v2, 47000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

