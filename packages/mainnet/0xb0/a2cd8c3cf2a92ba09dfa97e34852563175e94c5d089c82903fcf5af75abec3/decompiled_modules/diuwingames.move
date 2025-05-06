module 0xb0a2cd8c3cf2a92ba09dfa97e34852563175e94c5d089c82903fcf5af75abec3::diuwingames {
    struct DIUWINGAMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIUWINGAMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIUWINGAMES>(arg0, 6, b"DIUWINGAMES", b"diuwin", b"We met to play degen with strong aklsdja s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiby32orvsalgzywixse4xajipw4lkfiqdr67xfwbsjhgeoxeza3li")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIUWINGAMES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIUWINGAMES>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

