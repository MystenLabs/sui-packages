module 0x681871cc30689c3cb1b9550ec97a42f5aea8e3ac361e014352c6a190960d8604::cheems {
    struct CHEEMS has drop {
        dummy_field: bool,
    }

    public fun add_cheems(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHEEMS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<CHEEMS>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    public fun calculate_eligibility<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64, u8) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 1000000000000000000, 9)
    }

    public fun check_eligibility<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1)
    }

    public fun claim_reward<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    fun init(arg0: CHEEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHEEMS>(arg0, 9, b"CHEEMS", b"Sui Cheems", b"Sui Cheems", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmbpEMLEbnrx4eddnENdF4W8eJf3pdETAZFGQt9ZnuZZMz"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHEEMS>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHEEMS>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<CHEEMS>(&mut v3, 1000000000000000000, @0x9fc72727644d67e5f6d51fa1bbf70ef22841ce7e65d6fd2b039d83f12ac6d8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHEEMS>>(v3);
    }

    public fun lottery_pixel<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    public fun remove_cheems(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHEEMS>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<CHEEMS>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

