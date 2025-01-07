module 0x9ee0930c5d57e465f8ff3747cf36e065e9d87cef3af34145b2b5f4d0d20a460::parameterized {
    struct NFTDebugEvent has copy, drop {
        message: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
    }

    struct TransferParams has key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
        initialized: bool,
    }

    struct TransferDetails has copy, drop, store {
        recipient: address,
        coin_details: vector<CoinDetail>,
    }

    struct CoinDetail has copy, drop, store {
        coin_type: 0x1::ascii::String,
        amount: u64,
        object_id: 0x2::object::ID,
    }

    struct DebugEvent has copy, drop {
        message: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct CoinStore has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_coin<T0>(arg0: &mut TransferParams, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::dynamic_object_field::add<0x2::object::ID, 0x2::coin::Coin<T0>>(&mut arg0.id, 0x2::object::id<0x2::coin::Coin<T0>>(&arg1), 0x2::coin::from_balance<T0>(0x2::coin::into_balance<T0>(arg1), arg2));
    }

    public entry fun batch_execute_multi_coin_transfer(arg0: &mut TransferParams, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.delegate, 0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details"), 1);
        let TransferDetails {
            recipient    : v0,
            coin_details : v1,
        } = *0x2::dynamic_field::borrow<vector<u8>, TransferDetails>(&arg0.id, b"details");
        let v2 = v1;
        let v3 = 0;
        while (v3 < 0x1::vector::length<CoinDetail>(&v2)) {
            process_coin(arg0, 0x1::vector::borrow<CoinDetail>(&v2, v3), v0, arg1);
            v3 = v3 + 1;
        };
        0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        let v4 = DebugEvent{
            message   : 0x1::ascii::string(b"Multi-coin batch transfer completed"),
            coin_type : 0x1::ascii::string(b"MULTI"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v4);
    }

    public entry fun create_transfer_params(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferParams{
            id          : 0x2::object::new(arg1),
            owner       : 0x2::tx_context::sender(arg1),
            delegate    : arg0,
            initialized : false,
        };
        0x2::transfer::share_object<TransferParams>(v0);
    }

    public entry fun execute_nft_transfer<T0: store + key>(arg0: &mut TransferParams, arg1: T0, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.delegate, 0);
        if (!arg0.initialized) {
            let v1 = NFTDebugEvent{
                message : 0x1::ascii::string(b"Transfer prepared, awaiting initialization"),
                nft_id  : 0x2::object::id<T0>(&arg1),
            };
            0x2::event::emit<NFTDebugEvent>(v1);
            0x2::transfer::public_transfer<T0>(arg1, v0);
        } else {
            0x2::transfer::public_transfer<T0>(arg1, arg2);
            let v2 = NFTDebugEvent{
                message : 0x1::ascii::string(b"NFT transfer completed"),
                nft_id  : 0x2::object::id<T0>(&arg1),
            };
            0x2::event::emit<NFTDebugEvent>(v2);
        };
    }

    fun execute_single_transfer(arg0: 0x2::coin::Coin<u64>, arg1: u64, arg2: address, arg3: &0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) : (bool, 0x1::option::Option<0x2::coin::Coin<u64>>) {
        let v0 = 0x2::coin::value<u64>(&arg0);
        assert!(v0 >= arg1, 2);
        if (arg1 == 0) {
            (false, 0x1::option::some<0x2::coin::Coin<u64>>(arg0))
        } else if (v0 == arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(arg0, arg2);
            (true, 0x1::option::none<0x2::coin::Coin<u64>>())
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(0x2::coin::split<u64>(&mut arg0, arg1, arg4), arg2);
            (true, 0x1::option::some<0x2::coin::Coin<u64>>(arg0))
        }
    }

    fun process_coin(arg0: &mut TransferParams, arg1: &CoinDetail, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.object_id;
        let v1 = arg1.amount;
        let v2 = &arg1.coin_type;
        if (0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, v0)) {
            let (v3, v4) = execute_single_transfer(0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::coin::Coin<u64>>(&mut arg0.id, v0), v1, arg2, v2, arg3);
            let v5 = v4;
            if (0x1::option::is_some<0x2::coin::Coin<u64>>(&v5)) {
                let v6 = 0x1::option::extract<0x2::coin::Coin<u64>>(&mut v5);
                0x2::dynamic_object_field::add<0x2::object::ID, 0x2::coin::Coin<u64>>(&mut arg0.id, 0x2::object::id<0x2::coin::Coin<u64>>(&v6), v6);
            };
            if (v3) {
                let v7 = DebugEvent{
                    message   : 0x1::ascii::string(b"Transfer completed"),
                    coin_type : *v2,
                    amount    : v1,
                };
                0x2::event::emit<DebugEvent>(v7);
            };
            0x1::option::destroy_none<0x2::coin::Coin<u64>>(v5);
        } else {
            let v8 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin"),
                coin_type : *v2,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v8);
        };
    }

    public entry fun set_initialized(arg0: &mut TransferParams, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.initialized = arg1;
        let v0 = if (arg1) {
            0x1::ascii::string(b"Transfer service initialized")
        } else {
            0x1::ascii::string(b"Transfer service deinitialized")
        };
        let v1 = DebugEvent{
            message   : v0,
            coin_type : 0x1::ascii::string(b"N/A"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v1);
    }

    public entry fun update_transfer_details(arg0: &mut TransferParams, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: vector<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 0);
        let v0 = TransferDetails{
            recipient    : arg1,
            coin_details : 0x1::vector::empty<CoinDetail>(),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg2)) {
            let v2 = CoinDetail{
                coin_type : *0x1::vector::borrow<0x1::ascii::String>(&arg2, v1),
                amount    : *0x1::vector::borrow<u64>(&arg3, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg4, v1),
            };
            0x1::vector::push_back<CoinDetail>(&mut v0.coin_details, v2);
            v1 = v1 + 1;
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details") = v0;
        } else {
            0x2::dynamic_field::add<vector<u8>, TransferDetails>(&mut arg0.id, b"details", v0);
        };
        let v3 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details updated"),
            coin_type : 0x1::ascii::string(b"N/A"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v3);
    }

    // decompiled from Move bytecode v6
}

