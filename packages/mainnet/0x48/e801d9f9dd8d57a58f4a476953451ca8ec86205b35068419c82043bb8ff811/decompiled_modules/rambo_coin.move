module 0x48e801d9f9dd8d57a58f4a476953451ca8ec86205b35068419c82043bb8ff811::rambo_coin {
    struct RAMBO_COIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMBO_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMBO_COIN>(arg0, 9, b"RAMBO", b"rambo coin", b"rambo voimt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/5b8bba7c-5ba5-4468-9bf0-f431a9f0b43b.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAMBO_COIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMBO_COIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

