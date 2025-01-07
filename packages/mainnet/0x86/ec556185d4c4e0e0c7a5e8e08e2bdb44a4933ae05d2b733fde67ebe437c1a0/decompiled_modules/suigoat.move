module 0x86ec556185d4c4e0e0c7a5e8e08e2bdb44a4933ae05d2b733fde67ebe437c1a0::suigoat {
    struct SUIGOAT has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"SUIGOAT", b"Sui Gospel of Goatse", b"We serve one master @struth_terminal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2F01_784338164e.jpg&w=256&q=75")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: SUIGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SUIGOAT>(arg0, arg1);
        0x2::coin::mint_and_transfer<SUIGOAT>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGOAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

