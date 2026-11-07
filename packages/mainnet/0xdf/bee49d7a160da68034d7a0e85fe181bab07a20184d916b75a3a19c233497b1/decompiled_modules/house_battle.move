module 0xdfbee49d7a160da68034d7a0e85fe181bab07a20184d916b75a3a19c233497b1::house_battle {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct NftWithdrawn has copy, drop {
        miner_id: 0x2::object::ID,
        recipient: address,
    }

    public fun deposit_nft(arg0: &mut Treasury, arg1: 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner) {
        0x2::dynamic_object_field::add<0x2::object::ID, 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.id, 0x2::object::id<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&arg1), arg1);
    }

    public fun fund_treasury(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun holds_miner(arg0: &Treasury, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_object_field::exists<0x2::object::ID>(&arg0.id, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public(friend) fun payout(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2)
    }

    public(friend) fun take_miner(arg0: &mut Treasury, arg1: 0x2::object::ID) : 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner {
        0x2::dynamic_object_field::remove<0x2::object::ID, 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg0.id, arg1)
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg4), arg3);
        let v0 = TreasuryWithdrawn{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<TreasuryWithdrawn>(v0);
    }

    public fun withdraw_nft(arg0: &AdminCap, arg1: &mut Treasury, arg2: 0x2::object::ID, arg3: address) {
        0x2::transfer::public_transfer<0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(0x2::dynamic_object_field::remove<0x2::object::ID, 0xc5bee5493cc8e161aa4f6d37b2ac650c7120f568a56b9e9fac59ce61ddb22f6::sui_miner::SuiMiner>(&mut arg1.id, arg2), arg3);
        let v0 = NftWithdrawn{
            miner_id  : arg2,
            recipient : arg3,
        };
        0x2::event::emit<NftWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

