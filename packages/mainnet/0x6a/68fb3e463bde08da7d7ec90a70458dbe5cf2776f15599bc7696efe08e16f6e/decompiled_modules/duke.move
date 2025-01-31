module 0x6a68fb3e463bde08da7d7ec90a70458dbe5cf2776f15599bc7696efe08e16f6e::duke {
    struct DUKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUKE>(arg0, 9, b"DUKE", b"DUKE COIN", b"Meet the new memecoin on Solana with our charming mascot, brought to life by the talented Matt Furie, like $PEPE, $BRETT and $ANDY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPRyoXPcpNUzshFMkra7oqvX8wrtjDm9rXk5uizcLJNGL")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUKE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUKE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

