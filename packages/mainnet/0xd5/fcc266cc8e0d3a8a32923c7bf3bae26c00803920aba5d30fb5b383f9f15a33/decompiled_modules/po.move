module 0xd5fcc266cc8e0d3a8a32923c7bf3bae26c00803920aba5d30fb5b383f9f15a33::po {
    struct PO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PO>(arg0, 9, b"PO", b"Po The Panda", b"HOLD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/2EGk2dSnAx4HquschBtvqtXyYn7deuUtqjrmLa8gpump.png?size=lg&key=e93f6e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PO>>(v1);
    }

    // decompiled from Move bytecode v6
}

