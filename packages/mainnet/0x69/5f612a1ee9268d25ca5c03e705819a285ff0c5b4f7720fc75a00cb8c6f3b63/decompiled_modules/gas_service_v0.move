module 0x695f612a1ee9268d25ca5c03e705819a285ff0c5b4f7720fc75a00cb8c6f3b63::gas_service_v0 {
    struct GasService_v0 has store {
        balances: 0x2::bag::Bag,
        version_control: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl,
    }

    public(friend) fun new(arg0: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl, arg1: &mut 0x2::tx_context::TxContext) : GasService_v0 {
        GasService_v0{
            balances        : 0x2::bag::new(arg1),
            version_control : arg0,
        }
    }

    public(friend) fun balance<T0>(arg0: &GasService_v0) : &0x2::balance::Balance<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.balances, 0x1::type_name::get<T0>())
    }

    fun put<T0>(arg0: &mut GasService_v0, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(balance_mut<T0>(arg0), arg1);
    }

    fun take<T0>(arg0: &mut GasService_v0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(balance_mut<T0>(arg0), arg1, arg2)
    }

    public(friend) fun version_control(arg0: &GasService_v0) : &0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl {
        &arg0.version_control
    }

    public(friend) fun allow_function(arg0: &mut GasService_v0, arg1: u64, arg2: 0x1::ascii::String) {
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::allow_function(&mut arg0.version_control, arg1, arg2);
    }

    public(friend) fun disallow_function(arg0: &mut GasService_v0, arg1: u64, arg2: 0x1::ascii::String) {
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::disallow_function(&mut arg0.version_control, arg1, arg2);
    }

    public(friend) fun add_gas<T0>(arg0: &mut GasService_v0, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String, arg3: address, arg4: vector<u8>) {
        put<T0>(arg0, arg1);
        0x695f612a1ee9268d25ca5c03e705819a285ff0c5b4f7720fc75a00cb8c6f3b63::events::gas_added<T0>(arg2, 0x2::coin::value<T0>(&arg1), arg3, arg4);
    }

    fun balance_mut<T0>(arg0: &mut GasService_v0) : &mut 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.balances, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0, 0x2::balance::zero<T0>());
        };
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.balances, v0)
    }

    public(friend) fun collect_gas<T0>(arg0: &mut GasService_v0, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take<T0>(arg0, arg2, arg3), arg1);
        0x695f612a1ee9268d25ca5c03e705819a285ff0c5b4f7720fc75a00cb8c6f3b63::events::gas_collected<T0>(arg1, arg2);
    }

    public(friend) fun pay_gas<T0>(arg0: &mut GasService_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: vector<u8>) {
        put<T0>(arg0, arg2);
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::payload(arg1);
        0x695f612a1ee9268d25ca5c03e705819a285ff0c5b4f7720fc75a00cb8c6f3b63::events::gas_paid<T0>(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::source_id(arg1), 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::destination_chain(arg1), 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::destination_address(arg1), 0x2::address::from_bytes(0x2::hash::keccak256(&v0)), 0x2::coin::value<T0>(&arg2), arg3, arg4);
    }

    public(friend) fun refund<T0>(arg0: &mut GasService_v0, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(take<T0>(arg0, arg3, arg4), arg2);
        0x695f612a1ee9268d25ca5c03e705819a285ff0c5b4f7720fc75a00cb8c6f3b63::events::refunded<T0>(arg1, arg3, arg2);
    }

    // decompiled from Move bytecode v6
}

