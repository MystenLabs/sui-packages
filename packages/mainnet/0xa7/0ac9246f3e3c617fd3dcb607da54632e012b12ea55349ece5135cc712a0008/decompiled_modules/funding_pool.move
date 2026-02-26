module 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::funding_pool {
    struct FundingPool has key {
        id: 0x2::object::UID,
        campaign_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ContributorRecord has copy, drop, store {
        address: address,
        amount: u64,
    }

    struct ContributorTable has key {
        id: 0x2::object::UID,
        contributors: vector<ContributorRecord>,
    }

    public(friend) fun borrow_contributor_mut(arg0: &mut ContributorTable, arg1: u64) : &mut ContributorRecord {
        0x1::vector::borrow_mut<ContributorRecord>(&mut arg0.contributors, arg1)
    }

    public fun campaign_id(arg0: &FundingPool) : 0x2::object::ID {
        arg0.campaign_id
    }

    public fun contribute(arg0: &mut FundingPool, arg1: &mut 0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::Campaign, arg2: &mut ContributorTable, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        assert!(v0 > 0, 20);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::campaign::add_contribution(arg1, v0);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = ContributorRecord{
            address : v1,
            amount  : v0,
        };
        0x1::vector::push_back<ContributorRecord>(&mut arg2.contributors, v2);
        0xa70ac9246f3e3c617fd3dcb607da54632e012b12ea55349ece5135cc712a0008::events::emit_contribution_made(arg0.campaign_id, v1, v0);
    }

    public entry fun create_and_transfer_pool(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = create_funding_pool(arg0, arg1);
        0x2::transfer::transfer<FundingPool>(v1, v0);
        0x2::transfer::transfer<ContributorTable>(v2, v0);
    }

    public fun create_funding_pool(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : (FundingPool, ContributorTable) {
        let v0 = FundingPool{
            id          : 0x2::object::new(arg1),
            campaign_id : arg0,
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v1 = ContributorTable{
            id           : 0x2::object::new(arg1),
            contributors : 0x1::vector::empty<ContributorRecord>(),
        };
        (v0, v1)
    }

    public fun extract_all_funds(arg0: &mut FundingPool, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 22);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, v0), arg1)
    }

    public fun extract_funds(arg0: &mut FundingPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 21);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg2)
    }

    public fun get_balance(arg0: &FundingPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_contributor(arg0: &ContributorTable, arg1: u64) : (address, u64) {
        let v0 = 0x1::vector::borrow<ContributorRecord>(&arg0.contributors, arg1);
        (v0.address, v0.amount)
    }

    public(friend) fun get_contributor_address(arg0: &ContributorRecord) : address {
        arg0.address
    }

    public(friend) fun get_contributor_amount(arg0: &ContributorRecord) : u64 {
        arg0.amount
    }

    public fun get_contributor_count(arg0: &ContributorTable) : u64 {
        0x1::vector::length<ContributorRecord>(&arg0.contributors)
    }

    public fun lock_funds(arg0: &FundingPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public(friend) fun set_contributor_amount(arg0: &mut ContributorRecord, arg1: u64) {
        arg0.amount = arg1;
    }

    public fun transfer_pool(arg0: FundingPool, arg1: address) {
        0x2::transfer::transfer<FundingPool>(arg0, arg1);
    }

    public fun transfer_table(arg0: ContributorTable, arg1: address) {
        0x2::transfer::transfer<ContributorTable>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

