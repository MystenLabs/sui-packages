module 0x3a0ef6ea616304707df8cb9bcaccbd8a021064ca2da2d7079543ade7a69c07ce::ting {
    struct TING has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TING>, arg1: 0x2::coin::Coin<TING>) {
        0x2::coin::burn<TING>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TING>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TING>>(0x2::coin::mint<TING>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<TING>) : u64 {
        0x2::coin::total_supply<TING>(arg0)
    }

    fun init(arg0: TING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TING>(arg0, 9, b"TING", b"TING", b"AI collaboration token for creative economies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mixmi.io/ting-icon.png")), arg1);
        let v2 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<MintCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TING>>(v1);
    }

    public fun mint_to_coin(arg0: &mut 0x2::coin::TreasuryCap<TING>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TING> {
        0x2::coin::mint<TING>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

