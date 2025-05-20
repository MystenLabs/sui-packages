module 0xc02f255fe2b15f14b255a5f0a91622908ca41cc5180dd4281d45419e36fc2044::hiphop {
    struct HIPHOP has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HIPHOP>, arg1: 0x2::coin::Coin<HIPHOP>) {
        0x2::coin::burn<HIPHOP>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HIPHOP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HIPHOP>>(0x2::coin::mint<HIPHOP>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<HIPHOP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<HIPHOP>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: HIPHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<HIPHOP>(arg0, 6, b"HIPHOP", b"HipHop", x"53554920436f6d6d756e6974792c2048656164732055702120536f6d657468696e67204855474520697320436f6d696e672120f09fa4ab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upanh.tv/image/photo-2025-04-28-02-01-08.wqeEE"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPHOP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<HIPHOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<HIPHOP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<HIPHOP>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

