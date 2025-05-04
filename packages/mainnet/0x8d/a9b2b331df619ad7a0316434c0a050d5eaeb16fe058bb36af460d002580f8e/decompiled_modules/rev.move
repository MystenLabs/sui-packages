module 0x8da9b2b331df619ad7a0316434c0a050d5eaeb16fe058bb36af460d002580f8e::rev {
    struct REV has drop {
        dummy_field: bool,
    }

    fun init(arg0: REV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REV>(arg0, 6, b"REV", b"REVERB", b"Welcome to our project! Join our TG and read the very important welcome information!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiahf7wk54s2yjohqenisthsgmujsmnjtrgv3soenc2h3j7eyiez5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

