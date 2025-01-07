module 0x85d4fb5eba2635b9b00036f380994c2397a0c1ab3e609bbb524b900c240a2a3a::mexe {
    struct MEXE has drop {
        dummy_field: bool,
    }

    public fun change_v0(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEXE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MEXE>(arg0, arg1, arg2, arg3);
    }

    public fun change_v1(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MEXE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MEXE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: MEXE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MEXE>(arg0, 6, b"MEXE", b"meow exe", b"meow exe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pump.mypinata.cloud/ipfs/QmZSpEVWXxd5tBYjpJJQh78DQoj34A2LjGtKKdJnsTo7HY?img-width=256&img-dpr=2&img-onerror=redirect"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEXE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEXE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MEXE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

