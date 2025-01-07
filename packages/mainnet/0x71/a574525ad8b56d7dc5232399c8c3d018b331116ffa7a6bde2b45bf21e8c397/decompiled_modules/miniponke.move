module 0x71a574525ad8b56d7dc5232399c8c3d018b331116ffa7a6bde2b45bf21e8c397::miniponke {
    struct MINIPONKE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MINIPONKE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MINIPONKE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MINIPONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MINIPONKE>(arg0, 9, b"MiniPonke", b"MiniPonke", b"MiniPonke Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MINIPONKE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MINIPONKE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIPONKE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MINIPONKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MINIPONKE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MINIPONKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

