module 0xb150f7d40b4ed94f9338d15444e37d1cdc55b986b87996d2292f47c9d2ffe58a::jumbodog {
    struct JUMBODOG has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JUMBODOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<JUMBODOG>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: JUMBODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<JUMBODOG>(arg0, 9, b"JumboDog", b"Jumbo Dog", b"Jumbo Dog Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<JUMBODOG>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUMBODOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUMBODOG>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JUMBODOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JUMBODOG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<JUMBODOG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

