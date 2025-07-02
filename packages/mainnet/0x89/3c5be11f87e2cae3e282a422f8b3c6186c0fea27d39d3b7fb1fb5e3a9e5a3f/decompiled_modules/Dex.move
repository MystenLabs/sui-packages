module 0x893c5be11f87e2cae3e282a422f8b3c6186c0fea27d39d3b7fb1fb5e3a9e5a3f::Dex {
    struct DEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEX>(arg0, 9, b"DEX", b"Dex", b"dex coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/d57a4351-6252-42fd-a9df-55aed5b20b22.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

