module 0xf4b8a86044035b9d3e5c5d6be05cb7b19a762f679cd280d3d2840c2e282b57b4::donation_system {
    struct DonationBox has store, key {
        id: 0x2::object::UID,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        admin: address,
    }

    public entry fun create_donation_box(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DonationBox{
            id    : 0x2::object::new(arg0),
            funds : 0x2::balance::zero<0x2::sui::SUI>(),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<DonationBox>(v0);
    }

    public entry fun donate(arg0: &mut DonationBox, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.funds, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun get_total_donated(arg0: &DonationBox) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.funds)
    }

    public entry fun withdraw_funds(arg0: &mut DonationBox, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin == v0, 0);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.funds);
        assert!(v1 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, v1), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

