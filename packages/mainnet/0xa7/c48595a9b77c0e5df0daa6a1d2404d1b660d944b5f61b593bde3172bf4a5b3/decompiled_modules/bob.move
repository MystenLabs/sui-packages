module 0xa7c48595a9b77c0e5df0daa6a1d2404d1b660d944b5f61b593bde3172bf4a5b3::bob {
    struct BOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOB>(arg0, 6, b"BOB", b"SUI BOB", b"Fish SUI BOB memecoin rebels on the Sui ocean !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959419263.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

