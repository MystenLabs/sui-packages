module 0xbacc7bd452d867b1c45e675097d49bc54f43a5281ec34954673fca90ba1d32a4::Token {
    struct Token has drop, store {
        name: vector<u8>,
        total_supply: u64,
        admin: address,
    }

    struct Stake has drop, store {
        amount: u64,
        reward_rate: u64,
        start_time: u64,
    }

    public fun airdrop(arg0: &mut Token, arg1: vector<address>, arg2: u64, arg3: address) {
        assert!(arg3 == arg0.admin, 1);
        let v0 = 0x1::vector::length<address>(&arg1) * arg2;
        assert!(arg0.total_supply >= v0, 2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
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

    public fun create_token(arg0: vector<u8>, arg1: u64, arg2: address) : Token {
        Token{
            name         : arg0,
            total_supply : arg1,
            admin        : arg2,
        }
    }

    public fun get_name(arg0: &Token) : &vector<u8> {
        &arg0.name
    }

    public fun get_total_supply(arg0: &Token) : u64 {
        arg0.total_supply
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

    // decompiled from Move bytecode v6
}

