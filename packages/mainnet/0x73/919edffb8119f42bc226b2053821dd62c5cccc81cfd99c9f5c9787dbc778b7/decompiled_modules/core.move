module 0x73919edffb8119f42bc226b2053821dd62c5cccc81cfd99c9f5c9787dbc778b7::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: 0x2::coin::Coin<CORE>) {
        internal_burn_coin(arg0, arg1);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CORE>>(internal_mint_coin(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CORE>(arg0, 6, b"core", b"CORE", b"Dev at work, carving carving carving......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/dkpo6c3me/image/upload/v1728913279/carv_cbwfph.jpg")), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CORE>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun internal_burn_coin(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: 0x2::coin::Coin<CORE>) : u64 {
        0x2::coin::burn<CORE>(arg0, arg1)
    }

    fun internal_mint_coin(arg0: &mut 0x2::coin::TreasuryCap<CORE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<CORE> {
        0x2::coin::mint<CORE>(arg0, arg1, arg2)
    }

    public entry fun retweet(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CORE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CORE>(arg0, arg1, arg2, arg3);
    }

    public entry fun tweet(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CORE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CORE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

