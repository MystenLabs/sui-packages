module 0x1ab237125fc9b6bb61902ffb02d318454e8a0599a5659bff1f234fd2bf983f71::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    struct FixedSupply has key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<TOKEN>,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 9, b"USAD", b"USAD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/v69wXs5gA-zerxEoYO4ySCtry0PO2wMntPdYz7C04L8")), arg1);
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

