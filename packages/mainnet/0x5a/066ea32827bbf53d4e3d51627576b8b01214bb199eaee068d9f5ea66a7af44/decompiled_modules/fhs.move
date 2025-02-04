module 0x5a066ea32827bbf53d4e3d51627576b8b01214bb199eaee068d9f5ea66a7af44::fhs {
    struct FHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHS>(arg0, 6, b"FHS", b"Fantasy Humanoids Coin on SUI", b"First Fantasy Coin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_aadeaad5a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

