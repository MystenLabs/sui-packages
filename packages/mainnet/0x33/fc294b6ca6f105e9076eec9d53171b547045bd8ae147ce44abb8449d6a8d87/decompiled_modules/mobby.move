module 0x33fc294b6ca6f105e9076eec9d53171b547045bd8ae147ce44abb8449d6a8d87::mobby {
    struct MOBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBBY>(arg0, 9, b"MOBBY", b"Moby", b"Chill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x51b75da3da2e413ea1b8ed3eb078dc712304761c.png?size=xl&key=cd5476")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOBBY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBBY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

