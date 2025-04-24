module 0x1c12794943e0761df910ede29aa4ab2d4764e9ee2c33cc3b855f43dcbec83d94::fuckedlive {
    struct FUCKEDLIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKEDLIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKEDLIVE>(arg0, 6, b"FuckedLive", b"Anal live", b"https://twitchs.cam/AnalSex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiafnlq3pbstixwhrpp2jimnrjmenslwrqj3nhrs74wygcgjk7lkzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKEDLIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKEDLIVE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

