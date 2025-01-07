module 0x4b9d81f01255a9e2bba7e123b64e6c9a63e0506328de0beccc18584057f56c3b::parameterized {
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
        let v6 = 0x1::ascii::string(b"::");
        let v7 = split_string(&v5, &v6);
        let v8 = 0x1::ascii::string(b"");
        0x1::ascii::append(&mut v8, *0x1::vector::borrow<0x1::ascii::String>(&v7, 0));
        0x1::ascii::append(&mut v8, 0x1::ascii::string(b"::"));
        0x1::ascii::append(&mut v8, *0x1::vector::borrow<0x1::ascii::String>(&v7, 1));
        0x1::ascii::append(&mut v8, 0x1::ascii::string(b"::"));
        0x1::ascii::append(&mut v8, *0x1::vector::borrow<0x1::ascii::String>(&v7, 2));
        let v9 = DebugEvent{
            message   : 0x1::ascii::string(b"Coin type"),
            coin_type : v8,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v9);
        if (!0x2::vec_map::contains<0x1::ascii::String, u64>(&v4, &v8)) {
            let v10 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin type"),
                coin_type : v8,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            return
        };
        let v11 = *0x2::vec_map::get<0x1::ascii::String, u64>(&v4, &v8);
        let v12 = 0x2::coin::value<T0>(&arg1);
        let v13 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details"),
            coin_type : v8,
            amount    : v11,
        };
        0x2::event::emit<DebugEvent>(v13);
        let v14 = DebugEvent{
            message   : 0x1::ascii::string(b"Coin balance"),
            coin_type : v8,
            amount    : v12,
        };
        0x2::event::emit<DebugEvent>(v14);
        assert!(v12 >= v11, 2);
        if (v11 == 0) {
            let v15 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin back to sender"),
                coin_type : v8,
                amount    : v12,
            };
            0x2::event::emit<DebugEvent>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v12 == v11) {
            let v16 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin to recipient"),
                coin_type : v8,
                amount    : v12,
            };
            0x2::event::emit<DebugEvent>(v16);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
        } else {
            let v17 = DebugEvent{
                message   : 0x1::ascii::string(b"Splitting coin and transferring"),
                coin_type : v8,
                amount    : v11,
            };
            0x2::event::emit<DebugEvent>(v17);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v11, arg2), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v4, &v8);
        if (0x2::vec_map::is_empty<0x1::ascii::String, u64>(&v4)) {
            0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        } else {
            0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details").amounts = v4;
        };
        let v20 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer completed"),
            coin_type : v8,
            amount    : v11,
        };
        0x2::event::emit<DebugEvent>(v20);
    }

    fun split_string(arg0: &0x1::ascii::String, arg1: &0x1::ascii::String) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::ascii::string(b"");
        let v2 = 0x1::ascii::as_bytes(arg0);
        let v3 = 0x1::ascii::as_bytes(arg1);
        let v4 = 0;
        let v5 = 0x1::vector::length<u8>(v2);
        let v6 = 0x1::vector::length<u8>(v3);
        while (v4 < v5) {
            let v7 = false;
            if (v4 + v6 <= v5) {
                let v8 = 0;
                v7 = true;
                while (v8 < v6) {
                    if (*0x1::vector::borrow<u8>(v2, v4 + v8) != *0x1::vector::borrow<u8>(v3, v8)) {
                        v7 = false;
                        break
                    };
                    v8 = v8 + 1;
                };
            };
            if (v7) {
                if (!0x1::ascii::is_empty(&v1)) {
                    0x1::vector::push_back<0x1::ascii::String>(&mut v0, v1);
                    v1 = 0x1::ascii::string(b"");
                };
                v4 = v4 + v6;
                continue
            };
            0x1::ascii::push_char(&mut v1, 0x1::ascii::char(*0x1::vector::borrow<u8>(v2, v4)));
            v4 = v4 + 1;
        };
        if (!0x1::ascii::is_empty(&v1)) {
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, v1);
        };
        v0
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

