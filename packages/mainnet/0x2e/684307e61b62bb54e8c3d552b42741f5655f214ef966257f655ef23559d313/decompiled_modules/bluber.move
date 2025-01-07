module 0x2e684307e61b62bb54e8c3d552b42741f5655f214ef966257f655ef23559d313::bluber {
    struct BLUBER has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUBER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLUBER>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BLUBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUBER>(arg0, 9, b"BLUBER", b"BLUBER", x"426c756265723a20546865204e65787420426967205468696e6720696e20746865205375692045636f73797374656d2120f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-photo/blue-cartoon-natural-gas-character-generative-ai_914455-1902.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLUBER>(&mut v3, 9000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUBER>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBER>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUBER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLUBER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLUBER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

