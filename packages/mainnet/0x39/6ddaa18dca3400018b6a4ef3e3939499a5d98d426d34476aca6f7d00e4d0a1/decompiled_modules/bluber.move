module 0x396ddaa18dca3400018b6a4ef3e3939499a5d98d426d34476aca6f7d00e4d0a1::bluber {
    struct BLUBER has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUBER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLUBER>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLUBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUBER>(arg0, 9, b"BLUBER", b"BLUBER", b"The hype with doge is here but Bluber on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgcdn.stablediffusionweb.com/2024/10/4/12746f82-b8d7-4fa5-91da-cee9a7caabe4.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLUBER>(&mut v3, 4000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUBER>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBER>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUBER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUBER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLUBER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

