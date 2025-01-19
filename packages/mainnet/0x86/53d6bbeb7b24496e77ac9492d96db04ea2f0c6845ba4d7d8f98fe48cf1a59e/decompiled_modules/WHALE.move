module 0x8653d6bbeb7b24496e77ac9492d96db04ea2f0c6845ba4d7d8f98fe48cf1a59e::WHALE {
    struct WhaleCoin has drop, store {
        dummy_field: bool,
    }

    struct Stake has drop, store {
        amount: u64,
        reward_rate: u64,
        start_time: u64,
    }

    struct StakingTable has key {
        id: 0x2::object::UID,
        records: 0x2::table::Table<address, u64>,
    }

    public fun airdrop_whale(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut 0x2::coin::TreasuryCap<WhaleCoin>, arg2: vector<address>, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<WhaleCoin>>(0x2::coin::mint<WhaleCoin>(arg1, arg3, arg0), *0x1::vector::borrow<address>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public fun burn_whale(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut 0x2::coin::TreasuryCap<WhaleCoin>, arg2: 0x2::coin::Coin<WhaleCoin>) : u64 {
        0x2::coin::burn<WhaleCoin>(arg1, arg2)
    }

    public fun create_whale_coin(arg0: &mut 0x2::tx_context::TxContext, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = WhaleCoin{dummy_field: false};
        let (v1, v2) = 0x2::coin::create_currency<WhaleCoin>(v0, arg1, arg2, arg3, arg4, 0x1::option::none<0x2::url::Url>(), arg0);
        let v3 = 0x2::tx_context::sender(arg0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WhaleCoin>>(v1, v3);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WhaleCoin>>(v2, v3);
    }

    public fun destroy_staking_table(arg0: StakingTable) {
        let StakingTable {
            id      : v0,
            records : v1,
        } = arg0;
        0x2::table::destroy_empty<address, u64>(v1);
        0x2::object::delete(v0);
    }

    public fun get_staked_amount(arg0: &StakingTable, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.records, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.records, arg1)
        } else {
            0
        }
    }

    public fun get_total_supply(arg0: &0x2::coin::TreasuryCap<WhaleCoin>) : u64 {
        0x2::coin::total_supply<WhaleCoin>(arg0)
    }

    public fun mint_whale(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut 0x2::coin::TreasuryCap<WhaleCoin>, arg2: u64, arg3: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WhaleCoin>>(0x2::coin::mint<WhaleCoin>(arg1, arg2, arg0), arg3);
    }

    public fun new_staking_table(arg0: &mut 0x2::tx_context::TxContext) : StakingTable {
        StakingTable{
            id      : 0x2::object::new(arg0),
            records : 0x2::table::new<address, u64>(arg0),
        }
    }

    public fun purchase_token(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut 0x2::coin::TreasuryCap<WhaleCoin>, arg2: 0x2::coin::Coin<WhaleCoin>, arg3: u64, arg4: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WhaleCoin>>(0x2::coin::mint<WhaleCoin>(arg1, 0x2::coin::burn<WhaleCoin>(arg1, arg2) * arg3, arg0), arg4);
    }

    public fun stake(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut 0x2::coin::TreasuryCap<WhaleCoin>, arg2: &mut StakingTable, arg3: 0x2::coin::Coin<WhaleCoin>, arg4: u64, arg5: u64) : Stake {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x2::coin::burn<WhaleCoin>(arg1, arg3);
        let v2 = 0;
        if (0x2::table::contains<address, u64>(&arg2.records, v0)) {
            v2 = *0x2::table::borrow_mut<address, u64>(&mut arg2.records, v0);
        } else {
            0x2::table::add<address, u64>(&mut arg2.records, v0, 0);
        };
        *0x2::table::borrow_mut<address, u64>(&mut arg2.records, v0) = v2 + v1;
        Stake{
            amount      : v1,
            reward_rate : arg4,
            start_time  : arg5,
        }
    }

    public fun unstake(arg0: &mut 0x2::tx_context::TxContext, arg1: &mut 0x2::coin::TreasuryCap<WhaleCoin>, arg2: &mut StakingTable, arg3: Stake, arg4: u64, arg5: address) {
        let v0 = 0x2::tx_context::sender(arg0);
        assert!(arg4 > arg3.start_time, 1001);
        let v1 = 0;
        if (0x2::table::contains<address, u64>(&arg2.records, v0)) {
            v1 = *0x2::table::borrow_mut<address, u64>(&mut arg2.records, v0);
        };
        *0x2::table::borrow_mut<address, u64>(&mut arg2.records, v0) = v1 - arg3.amount;
        0x2::transfer::public_transfer<0x2::coin::Coin<WhaleCoin>>(0x2::coin::mint<WhaleCoin>(arg1, arg3.amount + arg3.amount * (arg4 - arg3.start_time) * arg3.reward_rate / 31536000 / 100, arg0), arg5);
        let Stake {
            amount      : _,
            reward_rate : _,
            start_time  : _,
        } = arg3;
    }

    // decompiled from Move bytecode v6
}

