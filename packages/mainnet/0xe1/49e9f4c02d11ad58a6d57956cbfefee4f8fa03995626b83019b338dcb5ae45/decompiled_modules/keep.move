module 0xe149e9f4c02d11ad58a6d57956cbfefee4f8fa03995626b83019b338dcb5ae45::keep {
    struct KEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEEP>(arg0, 9, b"KEEP", b"Suikeeper", b"Suikeep staking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KEEP>(&mut v2, 280000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEEP>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

