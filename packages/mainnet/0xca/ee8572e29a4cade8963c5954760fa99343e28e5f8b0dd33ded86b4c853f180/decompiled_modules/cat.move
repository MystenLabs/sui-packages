module 0xcaee8572e29a4cade8963c5954760fa99343e28e5f8b0dd33ded86b4c853f180::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<CAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<CAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<CAT>(arg0, 6, b"CAT", b"CAT Token", b"You are good!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gabe_the_Dog_f6aa0a42f7.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<CAT>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<CAT>(&mut v3, 90000000000000000, @0xcb212ae2406d6f11a63ba5abe6a57a44ac53a021db1fa528365208e93d3ac145, arg1);
        0x2::coin::mint_and_transfer<CAT>(&mut v3, 10000000000000000, @0x212dd93cfbbcc7cd4cb274e95268db5fb7115bb62b1453b6ab40676b5ae9abf3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v3, 0x2::tx_context::sender(arg1));
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<CAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<CAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

