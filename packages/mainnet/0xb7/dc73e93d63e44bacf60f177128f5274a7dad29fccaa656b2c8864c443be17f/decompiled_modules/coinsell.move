module 0xb7dc73e93d63e44bacf60f177128f5274a7dad29fccaa656b2c8864c443be17f::coinsell {
    struct COINSELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COINSELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COINSELL>(arg0, 9, b"sell", b"coinsell", b"sell coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/736a6592-f5a0-4f15-957e-d06feebb47f2.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COINSELL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COINSELL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

