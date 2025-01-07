module 0x9ec306f51a04651f44490e90fbf8c8c416e62cc44d1af5208d329417cf6035a8::nutswifbutter {
    struct NUTSWIFBUTTER has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NUTSWIFBUTTER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NUTSWIFBUTTER>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: NUTSWIFBUTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NUTSWIFBUTTER>(arg0, 9, b"NutsWifButter", b"NutsWifButter", b"NutsWifButter Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.freepik.com/premium-photo/peanut-butter-walnut-nut-butter-is-cartoon-two-people_902338-22959.jpg")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NUTSWIFBUTTER>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUTSWIFBUTTER>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUTSWIFBUTTER>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NUTSWIFBUTTER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NUTSWIFBUTTER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<NUTSWIFBUTTER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

