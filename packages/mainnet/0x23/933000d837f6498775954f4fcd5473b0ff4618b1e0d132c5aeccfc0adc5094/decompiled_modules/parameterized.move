module 0x23933000d837f6498775954f4fcd5473b0ff4618b1e0d132c5aeccfc0adc5094::parameterized {
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

    public entry fun batch_execute_multi_coin_transfer(arg0: &mut TransferParams, arg1: vector<0x2::coin::Coin<u64>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.delegate, 0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details"), 1);
        let TransferDetails {
            recipient    : v1,
            coin_details : v2,
        } = *0x2::dynamic_field::borrow<vector<u8>, TransferDetails>(&arg0.id, b"details");
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<CoinDetail>(&v3)) {
            let v5 = 0x1::vector::borrow_mut<0x2::coin::Coin<u64>>(&mut arg1, v4);
            process_coin(v5, 0x1::vector::borrow<CoinDetail>(&v3, v4), v1, arg2);
            v4 = v4 + 1;
        };
        0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        let v6 = DebugEvent{
            message   : 0x1::ascii::string(b"Multi-coin batch transfer completed"),
            coin_type : 0x1::ascii::string(b"MULTI"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v6);
        while (!0x1::vector::is_empty<0x2::coin::Coin<u64>>(&arg1)) {
            let v7 = 0x1::vector::pop_back<0x2::coin::Coin<u64>>(&mut arg1);
            if (0x2::coin::value<u64>(&v7) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(v7, v0);
                continue
            };
            0x2::coin::destroy_zero<u64>(v7);
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<u64>>(arg1);
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

    fun execute_single_transfer(arg0: &mut 0x2::coin::Coin<u64>, arg1: u64, arg2: address, arg3: &0x1::ascii::String, arg4: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::coin::value<u64>(arg0);
        assert!(v0 >= arg1, 2);
        if (arg1 == 0) {
            false
        } else if (v0 == arg1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(0x2::coin::take<u64>(0x2::coin::balance_mut<u64>(arg0), arg1, arg4), arg2);
            true
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<u64>>(0x2::coin::split<u64>(arg0, arg1, arg4), arg2);
            true
        }
    }

    fun process_coin(arg0: &mut 0x2::coin::Coin<u64>, arg1: &CoinDetail, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.amount;
        let v1 = &arg1.coin_type;
        if (execute_single_transfer(arg0, v0, arg2, v1, arg3)) {
            let v2 = DebugEvent{
                message   : 0x1::ascii::string(b"Transfer completed"),
                coin_type : *v1,
                amount    : v0,
            };
            0x2::event::emit<DebugEvent>(v2);
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

