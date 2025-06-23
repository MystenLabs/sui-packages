module 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::token_interface {
    public(friend) fun burn<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::Coin<T0>) : u64 {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::tlp::TLP>(), 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_token_not_existed());
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::tlp::burn<T0>(arg0, arg1)
    }

    public(friend) fun mint<T0>(arg0: &mut 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x1::type_name::get<T0>() == 0x1::type_name::get<0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::tlp::TLP>(), 0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::error::liquidity_token_not_existed());
        0x7ea60df3452d1cec0064d3380cb6f2a9309dcf7ac1b51529de71ef427688b1c3::tlp::mint<T0>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

