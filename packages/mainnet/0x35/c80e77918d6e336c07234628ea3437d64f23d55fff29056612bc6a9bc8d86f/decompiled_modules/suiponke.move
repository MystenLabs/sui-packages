module 0x35c80e77918d6e336c07234628ea3437d64f23d55fff29056612bc6a9bc8d86f::suiponke {
    struct SUIPONKE has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIPONKE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIPONKE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIPONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIPONKE>(arg0, 9, b"SuiPonke", b"SuiPonke", b"SuiPonke Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIPONKE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPONKE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPONKE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIPONKE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIPONKE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIPONKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

