module 0x20dba53805b9bfe1e5351eceb4b360c3d7a8f2cf20e79431d570208befd2fd97::public_sale {
    struct EventDepositSui has copy, drop {
        user: address,
        amount: u64,
        to: address,
        timestamp: u64,
    }

    public entry fun deposit_sui(arg0: &mut 0x20dba53805b9bfe1e5351eceb4b360c3d7a8f2cf20e79431d570208befd2fd97::recsui::GlobalStorage, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, @0xaf6b4ee9ccf7aa203f7df0983e3e1fbe98741acf17822ff2a28de91e0a1dc59b);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x20dba53805b9bfe1e5351eceb4b360c3d7a8f2cf20e79431d570208befd2fd97::recsui::RECSUI>>(0x2::coin::from_balance<0x20dba53805b9bfe1e5351eceb4b360c3d7a8f2cf20e79431d570208befd2fd97::recsui::RECSUI>(0x2::balance::increase_supply<0x20dba53805b9bfe1e5351eceb4b360c3d7a8f2cf20e79431d570208befd2fd97::recsui::RECSUI>(0x20dba53805b9bfe1e5351eceb4b360c3d7a8f2cf20e79431d570208befd2fd97::recsui::borrow_mut_supply(arg0), v0), arg3), 0x2::tx_context::sender(arg3));
        let v1 = EventDepositSui{
            user      : 0x2::tx_context::sender(arg3),
            amount    : v0,
            to        : @0xaf6b4ee9ccf7aa203f7df0983e3e1fbe98741acf17822ff2a28de91e0a1dc59b,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<EventDepositSui>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

