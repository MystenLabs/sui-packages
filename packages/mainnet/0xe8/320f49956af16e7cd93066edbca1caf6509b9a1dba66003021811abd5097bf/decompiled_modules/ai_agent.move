module 0xe8320f49956af16e7cd93066edbca1caf6509b9a1dba66003021811abd5097bf::ai_agent {
    struct Container has store, key {
        id: 0x2::object::UID,
    }

    struct Agent<phantom T0> has store, key {
        id: 0x2::object::UID,
        inner: 0x2::object::ID,
        price: u64,
        name: 0x1::string::String,
        encrypt_url: 0x1::string::String,
        method_type: 0x1::string::String,
        params: 0x1::string::String,
        description: 0x1::string::String,
        receive_address: address,
        type_name: 0x1::type_name::TypeName,
        nonce: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CreateAIAgentMessage has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        name: 0x1::string::String,
        encrypt_url: 0x1::string::String,
        method_type: 0x1::string::String,
        params: 0x1::string::String,
        description: 0x1::string::String,
        receive_address: address,
        type_name: 0x1::type_name::TypeName,
    }

    struct DeleteAIAgentMessage has copy, drop {
        id: 0x2::object::ID,
    }

    struct CallAIMessage has copy, drop {
        id: 0x2::object::ID,
        params: 0x1::string::String,
        nonce: u64,
        caller: address,
    }

    struct UpdateNameMessage has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        new_name: 0x1::string::String,
    }

    struct UpdateEncryptUrlMessage has copy, drop {
        id: 0x2::object::ID,
        encrypt_url: 0x1::string::String,
        new_encrypt_url: 0x1::string::String,
    }

    struct UpdateDescriptionMessage has copy, drop {
        id: 0x2::object::ID,
        description: 0x1::string::String,
        new_description: 0x1::string::String,
    }

    struct UpdateReceiveAddressMessage has copy, drop {
        id: 0x2::object::ID,
        receive_address: address,
        new_receive_address: address,
    }

    struct UpdatePriceMessage has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        new_price: u64,
    }

    struct Item has copy, drop, store {
        id: 0x2::object::ID,
    }

    public fun call_ai_agent<T0>(arg0: &mut Container, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: arg1};
        let v1 = 0x2::dynamic_object_field::borrow_mut<Item, Agent<T0>>(&mut arg0.id, v0);
        assert!(0x1::type_name::get<T0>() == v1.type_name, 3);
        assert!(0x2::coin::value<T0>(&arg3) == v1.price, 4);
        0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(arg3));
        v1.nonce = v1.nonce + 1;
        let v2 = CallAIMessage{
            id     : 0x2::object::uid_to_inner(&v1.id),
            params : arg2,
            nonce  : v1.nonce,
            caller : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<CallAIMessage>(v2);
    }

    public fun claim<T0>(arg0: &mut Container, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: arg1};
        let v1 = 0x2::dynamic_object_field::borrow_mut<Item, Agent<T0>>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg2) == v1.receive_address, 6);
        let v2 = 0x2::balance::value<T0>(&v1.balance);
        assert!(v2 > 0, 7);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1.balance, v2), arg2), v1.receive_address);
        };
    }

    public fun create_ai_agent<T0>(arg0: &mut Container, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) > 0, 0);
        assert!(0x1::string::length(&arg2) > 0, 1);
        assert!(0x1::string::length(&arg5) > 0, 2);
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::new(arg7);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x1::type_name::get<T0>();
        let v4 = Agent<T0>{
            id              : v1,
            inner           : v2,
            price           : arg6,
            name            : arg1,
            encrypt_url     : arg2,
            method_type     : arg3,
            params          : arg4,
            description     : arg5,
            receive_address : v0,
            type_name       : v3,
            nonce           : 0,
            balance         : 0x2::balance::zero<T0>(),
        };
        let v5 = Item{id: v2};
        0x2::dynamic_object_field::add<Item, Agent<T0>>(&mut arg0.id, v5, v4);
        let v6 = CreateAIAgentMessage{
            id              : v2,
            price           : arg6,
            name            : arg1,
            encrypt_url     : arg2,
            method_type     : arg3,
            params          : arg4,
            description     : arg5,
            receive_address : v0,
            type_name       : v3,
        };
        0x2::event::emit<CreateAIAgentMessage>(v6);
    }

    public fun delete_ai_agent<T0>(arg0: &mut Container, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: arg1};
        let Agent {
            id              : v1,
            inner           : v2,
            price           : _,
            name            : _,
            encrypt_url     : _,
            method_type     : _,
            params          : _,
            description     : _,
            receive_address : v9,
            type_name       : _,
            nonce           : _,
            balance         : v12,
        } = 0x2::dynamic_object_field::remove<Item, Agent<T0>>(&mut arg0.id, v0);
        let v13 = v12;
        if (0x2::balance::value<T0>(&v13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v13, arg2), v9);
        } else {
            0x2::balance::destroy_zero<T0>(v13);
        };
        0x2::object::delete(v1);
        let v14 = DeleteAIAgentMessage{id: v2};
        0x2::event::emit<DeleteAIAgentMessage>(v14);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Container{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<Container>(v0);
    }

    public fun update_description<T0>(arg0: &mut Container, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: arg1};
        let v1 = 0x2::dynamic_object_field::borrow_mut<Item, Agent<T0>>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg3) == v1.receive_address, 6);
        assert!(0x1::string::length(&arg2) > 0, 2);
        if (v1.description != arg2) {
            let v2 = UpdateDescriptionMessage{
                id              : 0x2::object::uid_to_inner(&v1.id),
                description     : v1.description,
                new_description : arg2,
            };
            0x2::event::emit<UpdateDescriptionMessage>(v2);
            v1.description = arg2;
        };
    }

    public fun update_encrypt_url<T0>(arg0: &mut Container, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: arg1};
        let v1 = 0x2::dynamic_object_field::borrow_mut<Item, Agent<T0>>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg3) == v1.receive_address, 6);
        assert!(0x1::string::length(&arg2) > 0, 1);
        if (v1.encrypt_url != arg2) {
            let v2 = UpdateEncryptUrlMessage{
                id              : 0x2::object::uid_to_inner(&v1.id),
                encrypt_url     : v1.encrypt_url,
                new_encrypt_url : arg2,
            };
            0x2::event::emit<UpdateEncryptUrlMessage>(v2);
            v1.encrypt_url = arg2;
        };
    }

    public fun update_name<T0>(arg0: &mut Container, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: arg1};
        let v1 = 0x2::dynamic_object_field::borrow_mut<Item, Agent<T0>>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg3) == v1.receive_address, 6);
        assert!(0x1::string::length(&arg2) > 0, 0);
        if (v1.name != arg2) {
            let v2 = UpdateNameMessage{
                id       : 0x2::object::uid_to_inner(&v1.id),
                name     : v1.name,
                new_name : arg2,
            };
            0x2::event::emit<UpdateNameMessage>(v2);
            v1.name = arg2;
        };
    }

    public fun update_price<T0>(arg0: &mut Container, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: arg1};
        let v1 = 0x2::dynamic_object_field::borrow_mut<Item, Agent<T0>>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg3) == v1.receive_address, 6);
        if (v1.price != arg2) {
            let v2 = UpdatePriceMessage{
                id        : 0x2::object::uid_to_inner(&v1.id),
                price     : v1.price,
                new_price : arg2,
            };
            0x2::event::emit<UpdatePriceMessage>(v2);
            v1.price = arg2;
        };
    }

    public fun update_receive_address<T0>(arg0: &mut Container, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Item{id: arg1};
        let v1 = 0x2::dynamic_object_field::borrow_mut<Item, Agent<T0>>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg3) == v1.receive_address, 6);
        if (v1.receive_address != arg2) {
            let v2 = UpdateReceiveAddressMessage{
                id                  : 0x2::object::uid_to_inner(&v1.id),
                receive_address     : v1.receive_address,
                new_receive_address : arg2,
            };
            0x2::event::emit<UpdateReceiveAddressMessage>(v2);
            v1.receive_address = arg2;
        };
    }

    // decompiled from Move bytecode v6
}

