module 0x487e9ddaac112f775671be41175a7b0cc0da5aa4b3f9cffa9cddefe852b7a72b::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct FixedSupply has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<TOKEN>,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"SUI-USDT", b"Tatr usd", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreiebuypmmgpesxbtlci4njvy5c4ddg3ichdrhc2twc2tjonmx6g36u")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        let v3 = FixedSupply{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<TOKEN>(v2),
        };
        0x2::transfer::freeze_object<FixedSupply>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<TOKEN>>(0x2::coin::mint<TOKEN>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

