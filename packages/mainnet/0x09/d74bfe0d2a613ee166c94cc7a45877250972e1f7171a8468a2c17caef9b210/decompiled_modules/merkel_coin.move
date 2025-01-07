module 0x9d74bfe0d2a613ee166c94cc7a45877250972e1f7171a8468a2c17caef9b210::merkel_coin {
    struct MERKEL_COIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MERKEL_COIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MERKEL_COIN>>(0x2::coin::mint<MERKEL_COIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MERKEL_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MERKEL_COIN>(arg0, 0, b"Merkel Coin", b"MMC", b"The Merkel Meme Coin - For the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/_j2HkAAbKHlaq7-5Fi7GCwMFQ-uyv4wQx5hdWP3AnZA")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MERKEL_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MERKEL_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

