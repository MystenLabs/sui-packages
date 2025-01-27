module 0x12d20efd6e4a5d91c142dfea6729c7aa3ec98d0c87215b06230dabf4f5c1236f::kali_linux {
    struct KALI_LINUX has drop {
        dummy_field: bool,
    }

    public entry fun add_to_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KALI_LINUX>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<KALI_LINUX>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: KALI_LINUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KALI_LINUX>(arg0, 9, b"KALI", b"Kali Linux", x"4b616c69204c696e757820e28093204861636b6572732050617261646973652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://media0.giphy.com/media/v1.Y2lkPTc5MGI3NjExcWphOGZta291YWRidG9qYnV3OWp0MTk2ZHVibnZldzd4bnMzdHU1bCZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/RFIfubTMf06wH1LuUo/giphy.gif")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<KALI_LINUX>>(0x2::coin::mint<KALI_LINUX>(&mut v3, 1000000000000000, arg1), @0x7fe5441b5420f3e78f4a3722187dee02013a29cd9b4367cfef85c3fc40c457c7);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KALI_LINUX>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KALI_LINUX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KALI_LINUX>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KALI_LINUX>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<KALI_LINUX>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

