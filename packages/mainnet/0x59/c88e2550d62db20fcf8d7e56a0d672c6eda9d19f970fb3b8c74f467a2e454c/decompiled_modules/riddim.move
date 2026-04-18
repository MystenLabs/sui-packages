module 0x59c88e2550d62db20fcf8d7e56a0d672c6eda9d19f970fb3b8c74f467a2e454c::riddim {
    struct RIDDIM has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<RIDDIM>, arg1: 0x2::coin::Coin<RIDDIM>) {
        0x2::coin::burn<RIDDIM>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIDDIM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RIDDIM>>(0x2::coin::mint<RIDDIM>(arg0, arg1, arg3), arg2);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<RIDDIM>) : u64 {
        0x2::coin::total_supply<RIDDIM>(arg0)
    }

    fun init(arg0: RIDDIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIDDIM>(arg0, 9, b"RIDDIM", b"RIDDIM", b"Human collaboration token for creative economies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mixmi.io/riddim-icon.png")), arg1);
        let v2 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIDDIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<MintCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIDDIM>>(v1);
    }

    public fun mint_to_coin(arg0: &mut 0x2::coin::TreasuryCap<RIDDIM>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RIDDIM> {
        0x2::coin::mint<RIDDIM>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

