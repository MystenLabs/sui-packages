module 0x45224cc1ea708c9d22f1b5a99c3b3fe3ef36330b7e983d0560a55334ec7607cc::dugg {
    struct DUGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUGG>(arg0, 9, b"DUGG", b"Doge's Retarded Brother", b"Dugg is the forgotten, retarded brother of Dogeclumsy, misunderstood, but secretly on a genius-level mission. Once left in the shadows, hes now rallying an unstoppable community to conquer Solana.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfG3a2YXPY9LFdpJedjmFypAVNfEZtYbg22ZbWXDAboV8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUGG>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUGG>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

