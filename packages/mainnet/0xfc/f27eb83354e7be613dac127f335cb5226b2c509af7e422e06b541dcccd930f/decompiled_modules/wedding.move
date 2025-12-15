module 0xfcf27eb83354e7be613dac127f335cb5226b2c509af7e422e06b541dcccd930f::wedding {
    struct MarriageNFT has key {
        id: 0x2::object::UID,
        spouse1: address,
        spouse2: address,
        active: bool,
    }

    struct MarriageVault has key {
        id: 0x2::object::UID,
        spouse1: address,
        spouse2: address,
        joint_wallet: 0x1::option::Option<address>,
        active: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    entry fun create_marriage(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 != arg0, 0);
        let v1 = MarriageNFT{
            id      : 0x2::object::new(arg1),
            spouse1 : v0,
            spouse2 : arg0,
            active  : true,
        };
        let v2 = MarriageVault{
            id           : 0x2::object::new(arg1),
            spouse1      : v0,
            spouse2      : arg0,
            joint_wallet : 0x1::option::none<address>(),
            active       : true,
            balance      : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MarriageNFT>(v1);
        0x2::transfer::share_object<MarriageVault>(v2);
    }

    entry fun deposit(arg0: &mut MarriageVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    entry fun divorce(arg0: &mut MarriageNFT, arg1: &mut MarriageVault, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.spouse1 || v0 == arg0.spouse2, 5);
        arg0.active = false;
        arg1.active = false;
    }

    entry fun set_joint_wallet(arg0: &mut MarriageVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.spouse1 || v0 == arg0.spouse2, 4);
        arg0.joint_wallet = 0x1::option::some<address>(arg1);
    }

    entry fun withdraw(arg0: &mut MarriageVault, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.active, 1);
        assert!(arg1 > 0, 5);
        assert!(v0 == arg0.spouse1 || v0 == arg0.spouse2, 2);
        let v1 = if (arg2 == arg0.spouse1) {
            true
        } else if (arg2 == arg0.spouse2) {
            true
        } else {
            0x1::option::is_some<address>(&arg0.joint_wallet) && 0x1::option::borrow<address>(&arg0.joint_wallet) == &arg2
        };
        assert!(v1, 3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg1, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

