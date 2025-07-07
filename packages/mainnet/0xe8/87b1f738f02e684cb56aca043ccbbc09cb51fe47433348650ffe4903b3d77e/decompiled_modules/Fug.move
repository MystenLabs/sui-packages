module 0xe887b1f738f02e684cb56aca043ccbbc09cb51fe47433348650ffe4903b3d77e::Fug {
    struct FUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUG>(arg0, 9, b"FUG", b"Fug", b"Fugly", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/4ff875e0-9ea4-42e7-9329-712779b371fe.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

