module 0xef0703d0749f459dbaf23797e3c57c438b9f3a1658569fd708e37a59bc722c02::parameterized {
    struct TransferParams has key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
    }

    struct TransferDetails has copy, drop, store {
        recipient: address,
        amounts: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct DebugEvent has copy, drop {
        message: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    public entry fun create_transfer_params(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferParams{
            id       : 0x2::object::new(arg1),
            owner    : 0x2::tx_context::sender(arg1),
            delegate : arg0,
        };
        0x2::transfer::share_object<TransferParams>(v0);
    }

    public entry fun execute_transfer<T0>(arg0: &mut TransferParams, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = DebugEvent{
            message   : 0x1::ascii::string(b"Starting execute_transfer"),
            coin_type : 0x1::ascii::string(b"N/A"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v1);
        assert!(v0 == arg0.delegate, 0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details"), 1);
        let TransferDetails {
            recipient : v2,
            amounts   : v3,
        } = *0x2::dynamic_field::borrow<vector<u8>, TransferDetails>(&arg0.id, b"details");
        let v4 = v3;
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v6 = trim_address_zeros(&v5);
        let v7 = DebugEvent{
            message   : 0x1::ascii::string(b"Trimmed coin type"),
            coin_type : v6,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v7);
        if (!0x2::vec_map::contains<0x1::ascii::String, u64>(&v4, &v6)) {
            let v8 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin type"),
                coin_type : v6,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            return
        };
        let v9 = *0x2::vec_map::get<0x1::ascii::String, u64>(&v4, &v6);
        let v10 = 0x2::coin::value<T0>(&arg1);
        let v11 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details"),
            coin_type : v6,
            amount    : v9,
        };
        0x2::event::emit<DebugEvent>(v11);
        let v12 = DebugEvent{
            message   : 0x1::ascii::string(b"Coin balance"),
            coin_type : v6,
            amount    : v10,
        };
        0x2::event::emit<DebugEvent>(v12);
        assert!(v10 >= v9, 2);
        if (v9 == 0) {
            let v13 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin back to sender"),
                coin_type : v6,
                amount    : v10,
            };
            0x2::event::emit<DebugEvent>(v13);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v10 == v9) {
            let v14 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin to recipient"),
                coin_type : v6,
                amount    : v10,
            };
            0x2::event::emit<DebugEvent>(v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
        } else {
            let v15 = DebugEvent{
                message   : 0x1::ascii::string(b"Splitting coin and transferring"),
                coin_type : v6,
                amount    : v9,
            };
            0x2::event::emit<DebugEvent>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v9, arg2), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v4, &v6);
        if (0x2::vec_map::is_empty<0x1::ascii::String, u64>(&v4)) {
            0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        } else {
            0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details").amounts = v4;
        };
        let v18 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer completed"),
            coin_type : v6,
            amount    : v9,
        };
        0x2::event::emit<DebugEvent>(v18);
    }

    fun trim_address_zeros(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        let v3 = true;
        while (v2 < 0x1::vector::length<u8>(&v0)) {
            let v4 = *0x1::vector::borrow<u8>(&v0, v2);
            if (v3) {
                if (v4 == 48 && v2 > 2) {
                    v2 = v2 + 1;
                    continue
                };
                if (v4 == 120) {
                    v3 = false;
                };
            };
            0x1::vector::push_back<u8>(&mut v1, v4);
            v2 = v2 + 1;
        };
        0x1::ascii::string(v1)
    }

    public entry fun update_transfer_details(arg0: &mut TransferParams, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        let v0 = TransferDetails{
            recipient : arg1,
            amounts   : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg2)) {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0.amounts, *0x1::vector::borrow<0x1::ascii::String>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1));
            v1 = v1 + 1;
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details") = v0;
        } else {
            0x2::dynamic_field::add<vector<u8>, TransferDetails>(&mut arg0.id, b"details", v0);
        };
        let v2 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details updated"),
            coin_type : 0x1::ascii::string(b"N/A"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

