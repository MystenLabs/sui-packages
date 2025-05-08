module 0x337dbef2bfda171dce61269a9c92043bb938b6d011e2fc24e9fb4e2291884bf9::bwartortle {
    struct BWARTORTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWARTORTLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWARTORTLE>(arg0, 6, b"BWARTORTLE", b"Baby Wartortle Sui", b"Baby Wartortle Sui is the evolution of Baby Squirtle Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic7yzzzzkpxyxaov4ffk5qshgvv5o2jqjlvxgtpd4u52mugyqypki")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWARTORTLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BWARTORTLE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

