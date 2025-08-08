module 0x79b01b73691782f8f40e63e858aa4c2e4d7af5d7978492f8176a23065d2a3722::primitivowine {
    struct PRIMITIVOWINE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIMITIVOWINE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIMITIVOWINE>>(0x2::coin::mint<PRIMITIVOWINE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIMITIVOWINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRIMITIVOWINE>(arg0, 6, b"PRIW", b"primitivo wine", b"The official token of Primitivo Wine", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIMITIVOWINE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIMITIVOWINE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

