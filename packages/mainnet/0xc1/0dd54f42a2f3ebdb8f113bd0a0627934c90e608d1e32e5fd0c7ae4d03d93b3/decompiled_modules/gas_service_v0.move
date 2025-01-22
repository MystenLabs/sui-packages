module 0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0 {
    struct GasService_v0 has store {
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        version_control: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl,
    }

    fun put(arg0: &mut GasService_v0, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    fun take(arg0: &mut GasService_v0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg1, arg2)
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

    public(friend) fun add_gas(arg0: &mut GasService_v0, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::ascii::String, arg3: address, arg4: vector<u8>) {
        put(arg0, arg1);
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::events::gas_added<0x2::sui::SUI>(arg2, 0x2::coin::value<0x2::sui::SUI>(&arg1), arg3, arg4);
    }

    public(friend) fun collect_gas(arg0: &mut GasService_v0, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(take(arg0, arg2, arg3), arg1);
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::events::gas_collected<0x2::sui::SUI>(arg1, arg2);
    }

    public(friend) fun new(arg0: 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl) : GasService_v0 {
        GasService_v0{
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            version_control : arg0,
        }
    }

    public(friend) fun pay_gas(arg0: &mut GasService_v0, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: vector<u8>) {
        put(arg0, arg2);
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::payload(arg1);
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::events::gas_paid<0x2::sui::SUI>(0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::source_id(arg1), 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::destination_chain(arg1), 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::destination_address(arg1), 0x2::address::from_bytes(0x2::hash::keccak256(&v0)), 0x2::coin::value<0x2::sui::SUI>(&arg2), arg3, arg4);
    }

    public(friend) fun refund(arg0: &mut GasService_v0, arg1: 0x1::ascii::String, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(take(arg0, arg3, arg4), arg2);
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::events::refunded<0x2::sui::SUI>(arg1, arg3, arg2);
    }

    // decompiled from Move bytecode v6
}

