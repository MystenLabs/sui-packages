module 0x4b643d8014950e568647b6dff25c7a9f964ed20ddd18b7374f50afa9f40e2702::pwog {
    struct PWOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWOG>(arg0, 9, b"PWOG", b"PWOG ON SUI", b"$PWOG $PWOG $PWOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeMuqrV615UuddYtMzG5WK6U64UeE58YNNYGoToqa4mQg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PWOG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PWOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWOG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

