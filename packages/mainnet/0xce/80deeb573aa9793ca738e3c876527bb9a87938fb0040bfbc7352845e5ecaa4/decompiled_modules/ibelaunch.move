module 0xce80deeb573aa9793ca738e3c876527bb9a87938fb0040bfbc7352845e5ecaa4::ibelaunch {
    struct IBELAUNCH has drop {
        dummy_field: bool,
    }

    struct IBLATCONTROLLER<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public(friend) fun burn(arg0: &mut IBLATCONTROLLER<IBELAUNCH>, arg1: 0x2::coin::Coin<IBELAUNCH>) {
        0x2::coin::burn<IBELAUNCH>(&mut arg0.treasury_cap, arg1);
    }

    fun init(arg0: IBELAUNCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IBELAUNCH>(arg0, 7, b"iBLAT", b"IBELAUNCH", b"IBELAUNCH Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = IBLATCONTROLLER<IBELAUNCH>{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<IBLATCONTROLLER<IBELAUNCH>>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IBELAUNCH>>(v1);
    }

    public(friend) fun mint(arg0: &mut IBLATCONTROLLER<IBELAUNCH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<IBELAUNCH>(&mut arg0.treasury_cap, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

