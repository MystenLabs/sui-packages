module 0x602a4716e45f2a7ccd71c4ec69bf16e57fdff31c82d99a3e1756164c7f85c620::ugdc {
    struct UGDC has drop {
        dummy_field: bool,
    }

    struct FixedSupply<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply: 0x2::balance::Supply<T0>,
    }

    fun init(arg0: UGDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UGDC>(arg0, 9, b"UGDC", b"UGDC", b"A configurable token issued on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/v69wXs5gA-zerxEoYO4ySCtry0PO2wMntPdYz7C04L8")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UGDC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UGDC>>(0x2::coin::mint<UGDC>(&mut v2, 10000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = FixedSupply<UGDC>{
            id     : 0x2::object::new(arg1),
            supply : 0x2::coin::treasury_into_supply<UGDC>(v2),
        };
        0x2::transfer::public_freeze_object<FixedSupply<UGDC>>(v3);
    }

    // decompiled from Move bytecode v7
}

