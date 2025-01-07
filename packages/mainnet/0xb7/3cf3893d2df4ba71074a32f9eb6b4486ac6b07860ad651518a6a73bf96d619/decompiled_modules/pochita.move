module 0xb73cf3893d2df4ba71074a32f9eb6b4486ac6b07860ad651518a6a73bf96d619::pochita {
    struct POCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: POCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POCHITA>(arg0, 9, b"POCHITA", b"Pochita", b"Pochita on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x4e6221c07dae8d3460a46fa01779cf17fdd72ad8.png?size=lg&key=e2ceac")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POCHITA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POCHITA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

