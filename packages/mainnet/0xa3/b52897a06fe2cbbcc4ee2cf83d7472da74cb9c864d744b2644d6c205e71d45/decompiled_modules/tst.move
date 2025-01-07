module 0xa3b52897a06fe2cbbcc4ee2cf83d7472da74cb9c864d744b2644d6c205e71d45::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    public entry fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TST>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TST>(arg0, 6, b"TST", b"TST Token", b"The coolest TST in crypto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gabe_the_Dog_f6aa0a42f7.png")), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TST>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<TST>(&mut v3, 90000000000000000, @0xcb212ae2406d6f11a63ba5abe6a57a44ac53a021db1fa528365208e93d3ac145, arg1);
        0x2::coin::mint_and_transfer<TST>(&mut v3, 10000000000000000, @0x212dd93cfbbcc7cd4cb274e95268db5fb7115bb62b1453b6ab40676b5ae9abf3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TST>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TST>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

