module 0xebbf537bc3686be32fe22b498b42715641bbb209267be72236a352e0444cc5df::sui_pepe {
    struct SUI_PEPE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUI_PEPE>, arg1: 0x2::coin::Coin<SUI_PEPE>) {
        0x2::coin::burn<SUI_PEPE>(arg0, arg1);
    }

    fun init(arg0: SUI_PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_PEPE>(arg0, 6, b"SPEPE", b"SUI PEPE", b"The biggest memecoin on SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui-pepe.xyz/_next/static/media/logo.6e0d8f53.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_PEPE>>(v1);
        let v3 = &mut v2;
        mint(v3, 10000000000000000000, @0xe86f6f33784307d2878559b48b6ce15562853662db078cbcbf01b403c0c56f28, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUI_PEPE>>(v2);
    }

    fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI_PEPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI_PEPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

