module 0x3d80c7ce8bb9a0fc7b09ea05e4486954a3dac11de87556c7be4979f79b47e79::suilemon {
    struct SUILEMON has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUILEMON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUILEMON>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUILEMON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUILEMON>(arg0, 9, b"SuiLemon", b"Sui Lemon", b"Sui Lemon Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUILEMON>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILEMON>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEMON>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUILEMON>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUILEMON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUILEMON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

