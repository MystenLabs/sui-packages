module 0xfa71fbd9ff871b82df2054ce0f167f612388ef7bfa8431392b0d0dfe5704f4e4::WAHLE {
    struct Token has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        total_supply: u64,
        admin: address,
    }

    struct Stake has drop, store {
        amount: u64,
        reward_rate: u64,
        start_time: u64,
    }

    struct Balance has drop, store {
        owner: address,
        amount: u64,
    }

    struct AccountBalance has store, key {
        id: 0x2::object::UID,
        balances: vector<Balance>,
    }

    public fun transfer(arg0: &mut AccountBalance, arg1: address, arg2: address, arg3: u64, arg4: address) {
        assert!(arg4 == arg1, 101);
        let v0 = get_balance(arg0, arg1);
        assert!(v0 >= arg3, 102);
        let v1 = get_balance(arg0, arg2);
        update_balance(arg0, arg1, v0 - arg3);
        update_balance(arg0, arg2, v1 + arg3);
    }

    public fun airdrop(arg0: &mut Token, arg1: &mut AccountBalance, arg2: vector<address>, arg3: u64, arg4: address) {
        assert!(arg4 == arg0.admin, 1);
        let v0 = 0x1::vector::length<address>(&arg2) * arg3;
        assert!(arg0.total_supply >= v0, 2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            let v2 = *0x1::vector::borrow<address>(&arg2, v1);
            let v3 = get_balance(arg1, v2) + arg3;
            update_balance(arg1, v2, v3);
            v1 = v1 + 1;
        };
        arg0.total_supply = arg0.total_supply - v0;
    }

    public fun burn(arg0: &mut Token, arg1: u64, arg2: address) {
        assert!(arg2 == arg0.admin, 2);
        assert!(arg0.total_supply >= arg1, 3);
        arg0.total_supply = arg0.total_supply - arg1;
    }

    public fun claim_reward(arg0: &Stake, arg1: u64) : u64 {
        assert!(arg1 > arg0.start_time, 4);
        arg0.amount * (arg1 - arg0.start_time) * arg0.reward_rate / 31536000 / 100
    }

    public fun create_token(arg0: vector<u8>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Token{
            id           : 0x2::object::new(arg3),
            name         : arg0,
            total_supply : arg1,
            admin        : arg2,
        };
        0x2::transfer::public_transfer<Token>(v0, arg2);
    }

    public fun get_balance(arg0: &AccountBalance, arg1: address) : u64 {
        get_balance_rec(arg0, arg1, 0)
    }

    public fun get_balance_rec(arg0: &AccountBalance, arg1: address, arg2: u64) : u64 {
        if (arg2 >= 0x1::vector::length<Balance>(&arg0.balances)) {
            return 0
        };
        let v0 = 0x1::vector::borrow<Balance>(&arg0.balances, arg2);
        if (v0.owner == arg1) {
            return v0.amount
        };
        get_balance_rec(arg0, arg1, arg2 + 1)
    }

    public fun get_name(arg0: &Token) : &vector<u8> {
        &arg0.name
    }

    public fun get_total_supply(arg0: &Token) : u64 {
        arg0.total_supply
    }

    public fun init_balance(arg0: &Token, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<Balance>();
        let v1 = Balance{
            owner  : arg1,
            amount : arg0.total_supply,
        };
        0x1::vector::push_back<Balance>(&mut v0, v1);
        let v2 = AccountBalance{
            id       : 0x2::object::new(arg2),
            balances : v0,
        };
        0x2::transfer::public_transfer<AccountBalance>(v2, arg1);
    }

    public fun mint(arg0: &mut Token, arg1: u64, arg2: address) {
        assert!(arg2 == arg0.admin, 1);
        arg0.total_supply = arg0.total_supply + arg1;
    }

    public fun stake(arg0: u64, arg1: u64, arg2: u64) : Stake {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0 && arg1 <= 100, 2);
        Stake{
            amount      : arg0,
            reward_rate : arg1,
            start_time  : arg2,
        }
    }

    public fun unstake(arg0: &mut AccountBalance, arg1: Stake, arg2: address, arg3: u64, arg4: address) {
        assert!(arg4 == arg2, 201);
        assert!(arg3 > arg1.start_time, 202);
        let v0 = get_balance(arg0, arg2) + arg1.amount + arg1.amount * (arg3 - arg1.start_time) * arg1.reward_rate / 31536000 / 100;
        update_balance(arg0, arg2, v0);
    }

    public fun update_balance(arg0: &mut AccountBalance, arg1: address, arg2: u64) {
        update_balance_rec(arg0, arg1, arg2, 0);
    }

    public fun update_balance_rec(arg0: &mut AccountBalance, arg1: address, arg2: u64, arg3: u64) {
        if (arg3 >= 0x1::vector::length<Balance>(&arg0.balances)) {
            let v0 = Balance{
                owner  : arg1,
                amount : arg2,
            };
            0x1::vector::push_back<Balance>(&mut arg0.balances, v0);
            return
        };
        let v1 = 0x1::vector::borrow_mut<Balance>(&mut arg0.balances, arg3);
        if (v1.owner == arg1) {
            v1.amount = arg2;
            return
        };
        update_balance_rec(arg0, arg1, arg2, arg3 + 1);
    }

    // decompiled from Move bytecode v6
}

