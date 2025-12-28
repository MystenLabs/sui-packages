module 0xd8fd0a5157cddf9f1ea4f99b9c887ea058de3a6c7be0b7664194b8ac00bdf5bc::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDC>(arg0, 6, b"TRX", b"TRX", b"TRX is a fixed-supply token inspired by Circle's TRX on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihqlaksegoji3yjff22ntacxnktafmweks4lcw52wwfac5wunq5by")), arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::mint<USDC>(&mut v2, 30000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<USDC>>(v2);
    }

    // decompiled from Move bytecode v6
}

