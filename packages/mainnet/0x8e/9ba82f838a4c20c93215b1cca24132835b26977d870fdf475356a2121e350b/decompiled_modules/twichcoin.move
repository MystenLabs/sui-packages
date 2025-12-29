module 0x8e9ba82f838a4c20c93215b1cca24132835b26977d870fdf475356a2121e350b::twichcoin {
    struct TWICHCOIN has drop {
        dummy_field: bool,
    }

    struct VestingPool has store, key {
        id: 0x2::object::UID,
        admin: address,
        beneficiary: address,
        unlock_year1_ms: u64,
        unlock_year2_ms: u64,
        claimed_year1: bool,
        started: bool,
        balance_twits: 0x2::balance::Balance<TWICHCOIN>,
    }

    public fun claim_year1(arg0: &mut VestingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.beneficiary != @0x0, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 5);
        assert!(arg0.started, 4);
        assert!(!arg0.claimed_year1, 7);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_year1_ms, 6);
        assert!(0x2::balance::value<TWICHCOIN>(&arg0.balance_twits) >= 50000000000000000, 8);
        arg0.claimed_year1 = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<TWICHCOIN>>(0x2::coin::from_balance<TWICHCOIN>(0x2::balance::split<TWICHCOIN>(&mut arg0.balance_twits, 50000000000000000), arg2), arg0.beneficiary);
    }

    public fun claim_year2(arg0: VestingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.beneficiary != @0x0, 2);
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 5);
        assert!(arg0.started, 4);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.unlock_year2_ms, 6);
        let VestingPool {
            id              : v0,
            admin           : _,
            beneficiary     : _,
            unlock_year1_ms : _,
            unlock_year2_ms : _,
            claimed_year1   : _,
            started         : _,
            balance_twits   : v7,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<TWICHCOIN>>(0x2::coin::from_balance<TWICHCOIN>(v7, arg2), arg0.beneficiary);
    }

    public fun get_remaining_twiches(arg0: &VestingPool) : u64 {
        0x2::balance::value<TWICHCOIN>(&arg0.balance_twits) / 1000000000
    }

    public fun get_remaining_twits(arg0: &VestingPool) : u64 {
        0x2::balance::value<TWICHCOIN>(&arg0.balance_twits)
    }

    public fun get_vesting_info(arg0: &VestingPool) : (address, address, u64, u64, bool, bool, u64) {
        (arg0.admin, arg0.beneficiary, arg0.unlock_year1_ms, arg0.unlock_year2_ms, arg0.claimed_year1, arg0.started, 0x2::balance::value<TWICHCOIN>(&arg0.balance_twits))
    }

    fun init(arg0: TWICHCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TWICHCOIN>(arg0, 9, 0x1::string::utf8(b"TWICH"), 0x1::string::utf8(b"TwichCoin"), 0x1::string::utf8(b"TwichCoin: fixed supply 1,000,000,000 twiches (9 decimals; twits). 10% vesting: 5% after 1 year, 5% after 2 years. The unofficial coin for stream watchers, chatters, and digital campfire enthusiasts. Not affiliated with any streaming platform. (C) TwichTwit, Dec 2025"), 0x1::string::utf8(b"https://blue-select-opossum-370.mypinata.cloud/ipfs/bafybeie5mg2z37k6ssdbyxxnakdj6imgys7p5u77yx5poalbaqyxhwwwlm"), arg1);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = 0x2::coin::mint<TWICHCOIN>(&mut v2, 1000000000000000000, arg1);
        let v6 = VestingPool{
            id              : 0x2::object::new(arg1),
            admin           : v4,
            beneficiary     : @0x0,
            unlock_year1_ms : 0,
            unlock_year2_ms : 0,
            claimed_year1   : false,
            started         : false,
            balance_twits   : 0x2::coin::into_balance<TWICHCOIN>(0x2::coin::split<TWICHCOIN>(&mut v5, 100000000000000000, arg1)),
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<TWICHCOIN>>(v5, v4);
        0x2::coin_registry::make_supply_fixed_init<TWICHCOIN>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<TWICHCOIN>(v3, arg1);
        0x2::transfer::public_transfer<VestingPool>(v6, v4);
    }

    public fun set_beneficiary(arg0: &mut VestingPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(arg0.beneficiary == @0x0, 1);
        arg0.beneficiary = arg1;
    }

    public fun start_vesting(arg0: &mut VestingPool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        assert!(!arg0.started, 3);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.unlock_year1_ms = v0 + 31536000000;
        arg0.unlock_year2_ms = v0 + 63072000000;
        arg0.started = true;
    }

    // decompiled from Move bytecode v6
}

