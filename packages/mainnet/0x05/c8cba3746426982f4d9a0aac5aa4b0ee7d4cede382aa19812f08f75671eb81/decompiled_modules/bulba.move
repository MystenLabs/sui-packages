module 0x5c8cba3746426982f4d9a0aac5aa4b0ee7d4cede382aa19812f08f75671eb81::bulba {
    struct BULBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULBA>(arg0, 6, b"BULBA", b"Bulbasui", b"Born to bloom on-chain  where water meets Web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihfolyaxjsw3psisn6v2sdprbkipld7ba2ums5oefn7t7gan3ws3a")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULBA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

