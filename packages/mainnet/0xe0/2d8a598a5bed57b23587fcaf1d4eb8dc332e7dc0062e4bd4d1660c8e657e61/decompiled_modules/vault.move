module 0xe02d8a598a5bed57b23587fcaf1d4eb8dc332e7dc0062e4bd4d1660c8e657e61::vault {
    struct DepositBox has store, key {
        id: 0x2::object::UID,
        stored: 0x2::balance::Balance<0x2::sui::SUI>,
        label: vector<u8>,
    }

    struct CollectorCard has store, key {
        id: 0x2::object::UID,
        items_collected: u64,
        total_value: u64,
    }

    public fun absorb(arg0: &mut CollectorCard, arg1: &mut DepositBox) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.stored);
        0x2::dynamic_field::add<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, arg0.items_collected, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.stored, v0));
        arg0.items_collected = arg0.items_collected + 1;
        arg0.total_value = arg0.total_value + v0;
    }

    public entry fun create_deposit_box(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositBox{
            id     : 0x2::object::new(arg1),
            stored : 0x2::balance::zero<0x2::sui::SUI>(),
            label  : arg0,
        };
        0x2::transfer::public_transfer<DepositBox>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun harvest(arg0: &mut CollectorCard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::remove<u64, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.id, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v0, arg2), 0x2::tx_context::sender(arg2));
        arg0.total_value = arg0.total_value - 0x2::balance::value<0x2::sui::SUI>(&v0);
    }

    public entry fun mint_collector_card(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectorCard{
            id              : 0x2::object::new(arg1),
            items_collected : 0,
            total_value     : 0,
        };
        0x2::transfer::public_transfer<CollectorCard>(v0, arg0);
    }

    public fun stash_into_box(arg0: &mut DepositBox, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.stored, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    // decompiled from Move bytecode v7
}

