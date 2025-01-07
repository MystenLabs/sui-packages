module 0x873ff0121085f2ed3e1192ec21eb9db60633d1293768e1606f53434498c04854::collection_fee_module {
    struct FeeElement has copy, drop, store {
        collection_name: 0x1::string::String,
        creator_fee: u64,
        reciver_address: address,
    }

    struct FeeContainer has store, key {
        id: 0x2::object::UID,
        admin_address: address,
        elements: vector<0x2::object::ID>,
        default_service_fee: u64,
    }

    struct Fee has store, key {
        id: 0x2::object::UID,
        fee_elements: vector<FeeElement>,
    }

    struct AddCollectionFeeEvent has copy, drop {
        collection_names: vector<0x1::string::String>,
        creator_fees: vector<u64>,
        service_fee: u64,
    }

    struct UpdateCollectionFeeEvent has copy, drop {
        collection_name: 0x1::string::String,
        creator_fee: u64,
    }

    struct DeleteCollectionFeeEvent has copy, drop {
        collection_name: 0x1::string::String,
    }

    public fun add_collection_fee(arg0: &mut FeeContainer, arg1: vector<0x1::string::String>, arg2: vector<u64>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 1);
        assert!(v0 == 0x1::vector::length<address>(&arg3), 1);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<0x1::string::String>(&arg1, v1);
            let v3 = 0x1::vector::borrow<u64>(&arg2, v1);
            let v4 = 0x1::vector::borrow<address>(&arg3, v1);
            let v5 = existed(arg0, *v2);
            if (v5 == false) {
                let v6 = arg0.elements;
                let v7 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Fee>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v6, 0x1::vector::length<0x2::object::ID>(&v6) - 1));
                let v8 = v7.fee_elements;
                if (0x1::vector::length<FeeElement>(&v8) < 1000) {
                    let v9 = FeeElement{
                        collection_name : *v2,
                        creator_fee     : *v3,
                        reciver_address : *v4,
                    };
                    0x1::vector::push_back<FeeElement>(&mut v7.fee_elements, v9);
                } else {
                    let v10 = 0x1::vector::empty<FeeElement>();
                    let v11 = FeeElement{
                        collection_name : *v2,
                        creator_fee     : *v3,
                        reciver_address : *v4,
                    };
                    0x1::vector::push_back<FeeElement>(&mut v10, v11);
                    let v12 = Fee{
                        id           : 0x2::object::new(arg4),
                        fee_elements : v10,
                    };
                    let v13 = 0x2::object::id<Fee>(&v12);
                    0x1::vector::push_back<0x2::object::ID>(&mut arg0.elements, v13);
                    0x2::dynamic_object_field::add<0x2::object::ID, Fee>(&mut arg0.id, v13, v12);
                };
            };
            v1 = v1 + 1;
        };
        let v14 = AddCollectionFeeEvent{
            collection_names : arg1,
            creator_fees     : arg2,
            service_fee      : arg0.default_service_fee,
        };
        0x2::event::emit<AddCollectionFeeEvent>(v14);
    }

    public entry fun change_admin_address(arg0: &mut FeeContainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_address == 0x2::tx_context::sender(arg2), 0);
        arg0.admin_address = arg1;
    }

    public entry fun change_default_service_fee(arg0: &mut FeeContainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_address == 0x2::tx_context::sender(arg2), 0);
        arg0.default_service_fee = arg1;
    }

    public fun create_fee_container(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Fee{
            id           : 0x2::object::new(arg1),
            fee_elements : 0x1::vector::empty<FeeElement>(),
        };
        let v1 = 0x2::object::id<Fee>(&v0);
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::push_back<0x2::object::ID>(&mut v2, v1);
        let v3 = FeeContainer{
            id                  : 0x2::object::new(arg1),
            admin_address       : 0x2::tx_context::sender(arg1),
            elements            : v2,
            default_service_fee : arg0,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Fee>(&mut v3.id, v1, v0);
        0x2::transfer::share_object<FeeContainer>(v3);
        0x2::object::id<FeeContainer>(&v3)
    }

    public fun delete_collection_fee(arg0: &mut FeeContainer, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin_address == 0x2::tx_context::sender(arg2), 0);
        let v0 = existed(arg0, arg1);
        assert!(v0 == true, 2);
        let v1 = arg0.elements;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Fee>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v1, v2)).fee_elements;
            let v4 = 0;
            while (v4 < 0x1::vector::length<FeeElement>(&v3)) {
                let _ = 0x1::vector::pop_back<FeeElement>(&mut v3);
                v4 = v4 + 1;
            };
            v2 = v2 + 1;
        };
        let v6 = DeleteCollectionFeeEvent{collection_name: arg1};
        0x2::event::emit<DeleteCollectionFeeEvent>(v6);
    }

    public fun existed(arg0: &mut FeeContainer, arg1: 0x1::string::String) : bool {
        let v0 = false;
        let v1 = arg0.elements;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::object::ID>(&v1)) {
            let v3 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Fee>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v1, v2)).fee_elements;
            let v4 = 0;
            while (v4 < 0x1::vector::length<FeeElement>(&v3)) {
                if (arg1 == 0x1::vector::borrow<FeeElement>(&v3, v4).collection_name) {
                    v0 = true;
                    break
                };
                v4 = v4 + 1;
            };
            if (v0 == true) {
                break
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun get_creator_fee(arg0: &mut FeeContainer, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (address, u64) {
        let v0 = 0;
        let v1 = v0;
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = v2;
        let v4 = existed(arg0, arg1);
        if (v4 == false) {
            (v2, v0)
        } else {
            let v7 = false;
            let v8 = arg0.elements;
            let v9 = 0;
            while (v9 < 0x1::vector::length<0x2::object::ID>(&v8)) {
                let v10 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Fee>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v8, v9)).fee_elements;
                let v11 = 0;
                while (v11 < 0x1::vector::length<FeeElement>(&v10)) {
                    let v12 = 0x1::vector::borrow<FeeElement>(&mut v10, v11);
                    if (arg1 == v12.collection_name) {
                        v1 = v12.creator_fee * arg2 / 100000;
                        v3 = v12.reciver_address;
                        v7 = true;
                    };
                    v11 = v11 + 1;
                };
                if (v7 == true) {
                    break
                };
                v9 = v9 + 1;
            };
            (v3, v1)
        }
    }

    public fun get_service_fee(arg0: &mut FeeContainer, arg1: u64) : u64 {
        arg0.default_service_fee * arg1 / 100000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun update_collection_fee(arg0: &mut FeeContainer, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = existed(arg0, arg1);
        assert!(v0 == true, 2);
        let v1 = false;
        let v2 = arg0.elements;
        let v3 = 0;
        let v4 = 0;
        while (v3 < 0x1::vector::length<0x2::object::ID>(&v2)) {
            let v5 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Fee>(&mut arg0.id, *0x1::vector::borrow<0x2::object::ID>(&v2, v3));
            let v6 = v5.fee_elements;
            let v7 = 0;
            while (v7 < 0x1::vector::length<FeeElement>(&v6)) {
                let v8 = 0x1::vector::pop_back<FeeElement>(&mut v6);
                if (arg1 == v8.collection_name) {
                    v4 = v3;
                    v1 = true;
                };
                v7 = v7 + 1;
            };
            if (v1 == true) {
                let v9 = 0x1::vector::remove<FeeElement>(&mut v5.fee_elements, v4);
                v9.creator_fee = arg2;
                0x1::vector::push_back<FeeElement>(&mut v5.fee_elements, v9);
                break
            };
            v3 = v3 + 1;
        };
        let v10 = UpdateCollectionFeeEvent{
            collection_name : arg1,
            creator_fee     : arg2,
        };
        0x2::event::emit<UpdateCollectionFeeEvent>(v10);
    }

    // decompiled from Move bytecode v6
}

