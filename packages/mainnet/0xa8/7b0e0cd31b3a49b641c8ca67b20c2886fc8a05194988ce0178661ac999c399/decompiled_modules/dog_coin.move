module 0xa87b0e0cd31b3a49b641c8ca67b20c2886fc8a05194988ce0178661ac999c399::dog_coin {
    struct DOG_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOG_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOG_COIN>(arg0, 9, b"dog", b"dog coin", b"this is a dog coin. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/f60b00c9-b254-4046-aa42-42f698b87ce2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOG_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOG_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

