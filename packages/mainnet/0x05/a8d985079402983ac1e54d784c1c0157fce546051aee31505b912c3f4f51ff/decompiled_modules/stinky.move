module 0x5a8d985079402983ac1e54d784c1c0157fce546051aee31505b912c3f4f51ff::stinky {
    struct STINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: STINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STINKY>(arg0, 9, b"STINKY", b"STINKY", b"STINKYSTINKYSTINKY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BwfSJ8Hi4VP9oNFKK5LhqCPAXaZPWb8AHwVE3k9Epump.png?size=xl&key=071d08")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STINKY>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STINKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

