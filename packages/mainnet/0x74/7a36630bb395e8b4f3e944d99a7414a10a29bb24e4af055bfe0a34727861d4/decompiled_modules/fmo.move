module 0x747a36630bb395e8b4f3e944d99a7414a10a29bb24e4af055bfe0a34727861d4::fmo {
    struct FMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMO>(arg0, 6, b"FMO", b"FOMO", b"FOMO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000065036_6edee3131c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

