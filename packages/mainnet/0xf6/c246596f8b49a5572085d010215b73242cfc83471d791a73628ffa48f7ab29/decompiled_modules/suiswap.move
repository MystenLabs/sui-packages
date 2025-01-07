module 0xf6c246596f8b49a5572085d010215b73242cfc83471d791a73628ffa48f7ab29::suiswap {
    struct IDO has key {
        id: 0x2::object::UID,
        suibalance: 0x2::balance::Balance<0x2::sui::SUI>,
        idosswpebalance: 0x2::balance::Balance<0xf6c246596f8b49a5572085d010215b73242cfc83471d791a73628ffa48f7ab29::sswp::SSWP>,
        sswap_price: u64,
        admin: address,
    }

    public entry fun buy_sswp(arg0: &mut IDO, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.suibalance, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xf6c246596f8b49a5572085d010215b73242cfc83471d791a73628ffa48f7ab29::sswp::SSWP>>(0x2::coin::take<0xf6c246596f8b49a5572085d010215b73242cfc83471d791a73628ffa48f7ab29::sswp::SSWP>(&mut arg0.idosswpebalance, 0x2::coin::value<0x2::sui::SUI>(&arg1) / arg0.sswap_price * 1000000000, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun depositIDOSSWP(arg0: &mut IDO, arg1: 0x2::coin::Coin<0xf6c246596f8b49a5572085d010215b73242cfc83471d791a73628ffa48f7ab29::sswp::SSWP>) {
        0x2::coin::put<0xf6c246596f8b49a5572085d010215b73242cfc83471d791a73628ffa48f7ab29::sswp::SSWP>(&mut arg0.idosswpebalance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = IDO{
            id              : 0x2::object::new(arg0),
            suibalance      : 0x2::balance::zero<0x2::sui::SUI>(),
            idosswpebalance : 0x2::balance::zero<0xf6c246596f8b49a5572085d010215b73242cfc83471d791a73628ffa48f7ab29::sswp::SSWP>(),
            sswap_price     : 21750000,
            admin           : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<IDO>(v0);
    }

    public entry fun owner(arg0: &mut IDO, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    public entry fun price(arg0: &mut IDO, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.sswap_price = arg1;
    }

    public entry fun withdraw(arg0: &mut IDO, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suibalance, 0x2::balance::value<0x2::sui::SUI>(&arg0.suibalance), arg1), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

