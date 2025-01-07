module 0x391c1cc4aaf8b7ec877c37fc770545e591591f6749e968dbc7c2a183d3f5fa2b::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    entry fun block_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<CAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_add<CAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<CAT>(arg0, 6, b"MAT", b"MAT Token", b"You are good!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gabe_the_Dog_f6aa0a42f7.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCap<CAT>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<CAT>(&mut v3, 10000000000000000, @0xcb212ae2406d6f11a63ba5abe6a57a44ac53a021db1fa528365208e93d3ac145, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v3, @0x0);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == @0xcb212ae2406d6f11a63ba5abe6a57a44ac53a021db1fa528365208e93d3ac145, 9223372200063533055);
        0x2::coin::mint_and_transfer<CAT>(arg0, arg1, arg2, arg3);
    }

    entry fun unblock_account(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCap<CAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_remove<CAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

