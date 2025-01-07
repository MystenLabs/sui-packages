module 0xf7a4a6b92fd1e32bfc5e43d4d9ba79c7cdbd1a7a98d4f9f4322ddd04f719c12b::saga {
    struct SAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAGA>(arg0, 9, b"SAGA", b"SUI MAGA", b"Make MAGA Great on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0xd29da236dd4aac627346e1bba06a619e8c22d7c5.png?size=lg&key=b0bcfa")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SAGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

