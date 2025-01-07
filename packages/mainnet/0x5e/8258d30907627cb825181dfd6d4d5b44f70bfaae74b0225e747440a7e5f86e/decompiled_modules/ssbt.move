module 0x5e8258d30907627cb825181dfd6d4d5b44f70bfaae74b0225e747440a7e5f86e::ssbt {
    struct SSBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSBT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSBT>(arg0, 9, b"SSBT", b"SSBT", b"SSBT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cloudflare-ipfs.com/ipfs/QmQ8yZBRFwwe2bk1BXmnizujKKGDqDevWoFb1zjXpX3VqC")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSBT>>(v1);
        0x2::coin::mint_and_transfer<SSBT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SSBT>>(v2);
    }

    // decompiled from Move bytecode v6
}

