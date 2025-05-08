module 0x516998228e1c62bca143e44b318e919b426d9ade14e72f4043b335e6fd707fb9::ghosui {
    struct GHOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOSUI>(arg0, 6, b"Ghosui", b"No website no Telegram No X ONLY FAITH AND BELIEF", b"Fuck all the telegrams and devs and hastags and kols and all, fuck em all. Ghosui for the ordinary, for the rugged, for the people who have zero edge, for people in pain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib5arg5jpc3tvqggtbfeudaoy5pq564gwnfaym2kle7fezltoifya")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GHOSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

