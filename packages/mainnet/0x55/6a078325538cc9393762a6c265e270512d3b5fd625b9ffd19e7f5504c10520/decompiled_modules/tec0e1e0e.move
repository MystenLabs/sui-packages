module 0x556a078325538cc9393762a6c265e270512d3b5fd625b9ffd19e7f5504c10520::tec0e1e0e {
    struct TEC0E1E0E has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEC0E1E0E>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEC0E1E0E>>(0x2::coin::mint<TEC0E1E0E>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TEC0E1E0E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEC0E1E0E>(arg0, 9, b"", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/52kjYb4y/Screen-Shot-2026-07-27-231117-321.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEC0E1E0E>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEC0E1E0E>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

