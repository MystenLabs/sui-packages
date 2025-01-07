module 0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::vault {
    struct Treasury has key {
        id: 0x2::object::UID,
        latest_timestamp: u64,
        total_minted: u64,
        stakedCoinsTreasury: 0x2::balance::Balance<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>,
        balanceOf: 0x2::vec_map::VecMap<address, u64>,
    }

    struct Staked has copy, drop {
        user: address,
        amount: u64,
    }

    struct Minted has copy, drop {
        user: address,
        amount: u64,
    }

    struct UpdateTimestamp has copy, drop {
        timestamp: u64,
    }

    public entry fun mint(arg0: &mut Treasury, arg1: &mut 0x2::coin::TreasuryCap<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 1000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>>(0x2::coin::mint<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>(arg1, v0, arg2), 0x2::tx_context::sender(arg2));
        arg0.total_minted = arg0.total_minted + v0;
        let v1 = Minted{
            user   : 0x2::tx_context::sender(arg2),
            amount : v0,
        };
        0x2::event::emit<Minted>(v1);
    }

    public entry fun transfer(arg0: &mut Treasury, arg1: 0x2::coin::Coin<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::balance::value<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>(&arg0.stakedCoinsTreasury);
        let v1 = 0x2::coin::value<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>(&arg1);
        if (!0x2::vec_map::contains<address, u64>(&arg0.balanceOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg0.balanceOf, v0, 0);
        };
        let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg0.balanceOf, &v0);
        *v2 = *v2 + v1;
        0x2::balance::join<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>(&mut arg0.stakedCoinsTreasury, 0x2::coin::into_balance<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>(arg1));
        let v3 = Staked{
            user   : 0x2::tx_context::sender(arg2),
            amount : v1,
        };
        0x2::event::emit<Staked>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                  : 0x2::object::new(arg0),
            latest_timestamp    : 0,
            total_minted        : 0,
            stakedCoinsTreasury : 0x2::balance::zero<0x28bd851e40fb8583837c7920876516f242128650120ff2af5c68aff0b898ae00::farm::FARM>(),
            balanceOf           : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public entry fun update_latest_timestamp(arg0: &mut Treasury, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.latest_timestamp = v0;
        let v1 = UpdateTimestamp{timestamp: v0};
        0x2::event::emit<UpdateTimestamp>(v1);
    }

    // decompiled from Move bytecode v6
}

