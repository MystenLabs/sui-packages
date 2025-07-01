module 0x248cd271f5a51eede0b0c4a78958434e83390b410fc46f3bdc53b972160d7039::a {
    struct Depository<phantom T0> has key {
        id: 0x2::object::UID,
        sui_balances: 0x2::table::Table<address, 0x2::coin::Coin<0x2::sui::SUI>>,
        other_balances: 0x2::table::Table<address, 0x2::coin::Coin<T0>>,
    }

    public entry fun create_depository<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Depository<T0>{
            id             : 0x2::object::new(arg0),
            sui_balances   : 0x2::table::new<address, 0x2::coin::Coin<0x2::sui::SUI>>(arg0),
            other_balances : 0x2::table::new<address, 0x2::coin::Coin<T0>>(arg0),
        };
        0x2::transfer::share_object<Depository<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Depository<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.sui_balances, v0)) {
            let v1 = 0x2::table::remove<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.sui_balances, v0);
            0x2::coin::join<0x2::sui::SUI>(&mut v1, arg1);
            0x2::table::add<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.sui_balances, v0, v1);
        } else {
            0x2::table::add<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.sui_balances, v0, arg1);
        };
    }

    public entry fun deposit_other<T0>(arg0: &mut Depository<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, 0x2::coin::Coin<T0>>(&arg0.other_balances, v0)) {
            let v1 = 0x2::table::remove<address, 0x2::coin::Coin<T0>>(&mut arg0.other_balances, v0);
            0x2::coin::join<T0>(&mut v1, arg1);
            0x2::table::add<address, 0x2::coin::Coin<T0>>(&mut arg0.other_balances, v0, v1);
        } else {
            0x2::table::add<address, 0x2::coin::Coin<T0>>(&mut arg0.other_balances, v0, arg1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Depository<0x2::sui::SUI>{
            id             : 0x2::object::new(arg0),
            sui_balances   : 0x2::table::new<address, 0x2::coin::Coin<0x2::sui::SUI>>(arg0),
            other_balances : 0x2::table::new<address, 0x2::coin::Coin<0x2::sui::SUI>>(arg0),
        };
        0x2::transfer::share_object<Depository<0x2::sui::SUI>>(v0);
    }

    public entry fun withdraw<T0>(arg0: &mut Depository<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::hash::sha2_256(0x2::address::to_bytes(v0)) == arg1, 1);
        let v1 = 0x2::table::contains<address, 0x2::coin::Coin<0x2::sui::SUI>>(&arg0.sui_balances, v0);
        let v2 = 0x2::table::contains<address, 0x2::coin::Coin<T0>>(&arg0.other_balances, v0);
        assert!(v1 || v2, 2);
        if (v1) {
            let v3 = 0x2::table::remove<address, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.sui_balances, v0);
            if (0x2::coin::value<0x2::sui::SUI>(&v3) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v0);
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v3);
            };
        };
        if (v2) {
            let v4 = 0x2::table::remove<address, 0x2::coin::Coin<T0>>(&mut arg0.other_balances, v0);
            if (0x2::coin::value<T0>(&v4) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
            } else {
                0x2::coin::destroy_zero<T0>(v4);
            };
        };
    }

    // decompiled from Move bytecode v6
}

