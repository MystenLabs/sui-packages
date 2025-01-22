module 0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service {
    struct GasService has store, key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct GasCollectorCap has store, key {
        id: 0x2::object::UID,
    }

    fun version_control() : 0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::VersionControl {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = vector[b"pay_gas", b"add_gas", b"collect_gas", b"refund", b"allow_function", b"disallow_function"];
        0x1::vector::reverse<vector<u8>>(&mut v1);
        while (0x1::vector::length<vector<u8>>(&v1) != 0) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, 0x1::ascii::string(0x1::vector::pop_back<vector<u8>>(&mut v1)));
        };
        0x1::vector::destroy_empty<vector<u8>>(v1);
        let v2 = 0x1::vector::empty<vector<0x1::ascii::String>>();
        0x1::vector::push_back<vector<0x1::ascii::String>>(&mut v2, v0);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::new(v2)
    }

    public fun add_gas(arg0: &mut GasService, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::ascii::String, arg3: address, arg4: vector<u8>) {
        let v0 = 0x2::versioned::load_value_mut<0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::GasService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::version_control(v0), 0, 0x1::ascii::string(b"add_gas"));
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::add_gas(v0, arg1, arg2, arg3, arg4);
    }

    entry fun allow_function(arg0: &mut GasService, arg1: &GasCollectorCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::GasService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::version_control(v0), 0, 0x1::ascii::string(b"allow_function"));
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::allow_function(v0, arg2, arg3);
    }

    public fun collect_gas(arg0: &mut GasService, arg1: &GasCollectorCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::versioned::load_value_mut<0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::GasService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::version_control(v0), 0, 0x1::ascii::string(b"collect_gas"));
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::collect_gas(v0, arg2, arg3, arg4);
    }

    entry fun disallow_function(arg0: &mut GasService, arg1: &GasCollectorCap, arg2: u64, arg3: 0x1::ascii::String) {
        let v0 = 0x2::versioned::load_value_mut<0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::GasService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::version_control(v0), 0, 0x1::ascii::string(b"disallow_function"));
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::disallow_function(v0, arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GasService{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::GasService_v0>(0, 0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::new(version_control()), arg0),
        };
        0x2::transfer::share_object<GasService>(v0);
        let v1 = GasCollectorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<GasCollectorCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun pay_gas(arg0: &mut GasService, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: address, arg4: vector<u8>) {
        let v0 = 0x2::versioned::load_value_mut<0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::GasService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::version_control(v0), 0, 0x1::ascii::string(b"pay_gas"));
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::pay_gas(v0, arg1, arg2, arg3, arg4);
    }

    public fun refund(arg0: &mut GasService, arg1: &GasCollectorCap, arg2: 0x1::ascii::String, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::versioned::load_value_mut<0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::GasService_v0>(&mut arg0.inner);
        0x647a3b34b3a16f5f00443bdafd13d281983b2280703ab4f416cf706e6d739087::version_control::check(0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::version_control(v0), 0, 0x1::ascii::string(b"refund"));
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service_v0::refund(v0, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

