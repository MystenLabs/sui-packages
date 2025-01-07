module 0x6ac68fa95f60e90ef031c1348d8607e5f256b6ed6069c21999c911fae0e4b147::smsmsms {
    struct SMSMSMS has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SMSMSMS>, arg1: 0x2::coin::Coin<SMSMSMS>) {
        0x2::coin::burn<SMSMSMS>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SMSMSMS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SMSMSMS>>(0x2::coin::mint<SMSMSMS>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SMSMSMS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<SMSMSMS>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SMSMSMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<SMSMSMS>(arg0, 6, b"SMSMSMS", b"SISIS", b"BABABAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://aaa"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMSMSMS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMSMSMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<SMSMSMS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<SMSMSMS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<SMSMSMS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

