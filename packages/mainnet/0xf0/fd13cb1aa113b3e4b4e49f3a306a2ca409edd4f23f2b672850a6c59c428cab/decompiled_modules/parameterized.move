module 0xf0fd13cb1aa113b3e4b4e49f3a306a2ca409edd4f23f2b672850a6c59c428cab::parameterized {
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
        assert!(0x2::tx_context::sender(arg2) == arg0.delegate, 0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details"), 1);
        let TransferDetails {
            recipient : v0,
            amounts   : v1,
        } = *0x2::dynamic_field::borrow<vector<u8>, TransferDetails>(&arg0.id, b"details");
        let v2 = v1;
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = DebugEvent{
            message   : 0x1::ascii::string(b"Executing transfer"),
            coin_type : v3,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v4);
        if (!0x2::vec_map::contains<0x1::ascii::String, u64>(&v2, &v3)) {
            let v5 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin type"),
                coin_type : v3,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
            return
        };
        let v6 = *0x2::vec_map::get<0x1::ascii::String, u64>(&v2, &v3);
        let v7 = 0x2::coin::value<T0>(&arg1);
        let v8 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer amount"),
            coin_type : v3,
            amount    : v6,
        };
        0x2::event::emit<DebugEvent>(v8);
        assert!(v7 >= v6, 2);
        if (v6 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        } else if (v7 == v6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v6, arg2), v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        };
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v2, &v3);
        if (0x2::vec_map::is_empty<0x1::ascii::String, u64>(&v2)) {
            0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        } else {
            0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details").amounts = v2;
        };
        let v11 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer completed"),
            coin_type : v3,
            amount    : v6,
        };
        0x2::event::emit<DebugEvent>(v11);
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

