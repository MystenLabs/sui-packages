module 0xbb57a2257a2e35703f953c07a4d339db29cc0368867b7bdcfb269f2ea6fa0891::pacman {
    struct PACMAN has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PACMAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PACMAN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: PACMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PACMAN>(arg0, 6, b"PACMAN", b"Pacman", x"5041434d414e2069732061206d656d6520746f6b656e20696e73706972656420627920456c6f6ee28099732063616d706169676e206f7267616e697a6174696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://dd.dexscreener.com/ds-data/tokens/solana/8ExunNtjVV8xWTkYRBXbYznC4UWqLR62BMEbf2EDpump.png?size=lg&key=d31d44"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PACMAN>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PACMAN>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<PACMAN>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PACMAN>>(v3, @0x0);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PACMAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PACMAN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

