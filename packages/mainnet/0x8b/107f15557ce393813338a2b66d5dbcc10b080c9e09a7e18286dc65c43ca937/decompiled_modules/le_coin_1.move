module 0x8b107f15557ce393813338a2b66d5dbcc10b080c9e09a7e18286dc65c43ca937::le_coin_1 {
    struct LE_COIN_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LE_COIN_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LE_COIN_1>(arg0, 9, b"lc1", b"le coin 1", b"the description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/f63bc4db-3e57-465c-a2ba-028d819ae58d.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LE_COIN_1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LE_COIN_1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

