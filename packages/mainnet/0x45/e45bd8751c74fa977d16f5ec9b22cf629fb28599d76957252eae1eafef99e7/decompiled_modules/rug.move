module 0x45e45bd8751c74fa977d16f5ec9b22cf629fb28599d76957252eae1eafef99e7::rug {
    struct RUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUG>(arg0, 6, b"RUG", b"Ruggy ", b"Will rug the lp when it hits 3 million mc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730445330593.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

