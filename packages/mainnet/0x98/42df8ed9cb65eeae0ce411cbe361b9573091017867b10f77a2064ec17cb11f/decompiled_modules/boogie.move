module 0x9842df8ed9cb65eeae0ce411cbe361b9573091017867b10f77a2064ec17cb11f::boogie {
    struct BOOGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOGIE>(arg0, 9, b"BOOGIE", b"Boogie", b"Boogie is coming to eat all the coins, join him or get eaten by the movement.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRqy7keJexPS2iAS4A7TqpMRRJsKE79mJ9FhRS6woWYxr")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BOOGIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOGIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOGIE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

