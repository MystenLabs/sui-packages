module 0x96e852dd4b364468f74b3d09e816c2490d48abc483925dae73e574f0294dcda9::spinda {
    struct SPINDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPINDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPINDA>(arg0, 6, b"SPINDA", b"Spinda Drunk", b"Spinda stan  | Drunk on Sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiexffsufdoqybhhgsnszwdyd6khehg6sdz6kctzc32cd7s46mi6qy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPINDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPINDA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

