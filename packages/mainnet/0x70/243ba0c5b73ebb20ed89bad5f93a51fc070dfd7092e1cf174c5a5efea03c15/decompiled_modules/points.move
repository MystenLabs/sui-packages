module 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::points {
    struct FutrPoint has key {
        id: 0x2::object::UID,
        balance: u64,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : FutrPoint {
        FutrPoint{
            id      : 0x2::object::new(arg0),
            balance : 0,
        }
    }

    public(friend) fun transfer(arg0: FutrPoint, arg1: address) {
        0x2::transfer::transfer<FutrPoint>(arg0, arg1);
    }

    public(friend) fun add_points(arg0: &mut FutrPoint, arg1: u64) {
        arg0.balance = arg0.balance + arg1;
    }

    public fun balance(arg0: &FutrPoint) : u64 {
        arg0.balance
    }

    public fun merge(arg0: &mut FutrPoint, arg1: vector<FutrPoint>) {
        let v0 = 0;
        0x1::vector::reverse<FutrPoint>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<FutrPoint>(&arg1)) {
            let v2 = 0x1::vector::pop_back<FutrPoint>(&mut arg1);
            v0 = v0 + v2.balance;
            let FutrPoint {
                id      : v3,
                balance : _,
            } = v2;
            0x2::object::delete(v3);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<FutrPoint>(arg1);
        arg0.balance = arg0.balance + v0;
    }

    public fun new_with_transfer(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::transfer<FutrPoint>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun purchase_reward(arg0: 0x1::string::String) : u64 {
        if (arg0 == 0x1::string::utf8(b"Legendary")) {
            500
        } else if (arg0 == 0x1::string::utf8(b"Rare")) {
            75
        } else if (arg0 == 0x1::string::utf8(b"Exclusive")) {
            150
        } else if (arg0 == 0x1::string::utf8(b"Ultra")) {
            300
        } else {
            30
        }
    }

    public(friend) fun remove_points(arg0: &mut FutrPoint, arg1: u64) {
        let v0 = arg0.balance;
        assert!(v0 >= arg1, 0);
        arg0.balance = v0 - arg1;
    }

    public fun stake_reward(arg0: 0x1::string::String, arg1: u64) : u64 {
        let v0 = 1;
        if (arg0 == 0x1::string::utf8(b"Legendary")) {
            v0 = 10;
        } else if (arg0 == 0x1::string::utf8(b"Rare")) {
            v0 = 2;
        } else if (arg0 == 0x1::string::utf8(b"Exclusive")) {
            v0 = 3;
        } else if (arg0 == 0x1::string::utf8(b"Ultra")) {
            v0 = 5;
        };
        v0 * arg1 / 86400000
    }

    // decompiled from Move bytecode v7
}

