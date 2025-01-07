module 0x25f197d5c46273bf22bcedebd361fd7a38f15915b2baef62af9503a53f44c5cd::parameterized {
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

    struct CoinOperations has drop {
        transfer: vector<u8>,
        split: vector<u8>,
        value: vector<u8>,
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

    public entry fun batch_execute_multi_coin_transfer(arg0: &mut TransferParams, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.delegate, 0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details"), 1);
        let TransferDetails {
            recipient    : v1,
            coin_details : v2,
        } = *0x2::dynamic_field::borrow<vector<u8>, TransferDetails>(&arg0.id, b"details");
        let v3 = v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x2::object::ID>(&arg1)) {
            let v5 = *0x1::vector::borrow<0x2::object::ID>(&arg1, v4);
            let v6 = false;
            let v7 = 0;
            let v8 = 0;
            while (v8 < 0x1::vector::length<CoinDetail>(&v3)) {
                let v9 = 0x1::vector::borrow<CoinDetail>(&v3, v8);
                if (v9.object_id == v5) {
                    v6 = true;
                    v7 = v9.amount;
                    0x1::vector::remove<CoinDetail>(&mut v3, v8);
                    break
                };
                v8 = v8 + 1;
            };
            if (!v6) {
                let v10 = DebugEvent{
                    message   : 0x1::ascii::string(b"Invalid coin"),
                    coin_type : 0x1::ascii::string(b"Unknown"),
                    amount    : 0,
                };
                0x2::event::emit<DebugEvent>(v10);
            } else {
                let v11 = &mut arg0.id;
                execute_single_transfer(v11, v5, v7, v1, v0, arg2);
            };
            v4 = v4 + 1;
        };
        if (0x1::vector::is_empty<CoinDetail>(&v3)) {
            0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        } else {
            0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details").coin_details = v3;
        };
        let v12 = DebugEvent{
            message   : 0x1::ascii::string(b"Multi-coin batch transfer completed"),
            coin_type : 0x1::ascii::string(b"MULTI"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v12);
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

    fun execute_single_transfer(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(arg0, arg1), 4);
        let v0 = 0x2::coin::value<0x2::object::UID>(0x2::dynamic_object_field::borrow<0x2::object::ID, 0x2::coin::Coin<0x2::object::UID>>(arg0, arg1));
        assert!(v0 >= arg2, 2);
        if (arg2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::object::UID>>(0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::coin::Coin<0x2::object::UID>>(arg0, arg1), arg4);
        } else if (v0 == arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::object::UID>>(0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::coin::Coin<0x2::object::UID>>(arg0, arg1), arg3);
        } else {
            let v1 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x2::coin::Coin<0x2::object::UID>>(arg0, arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::object::UID>>(0x2::coin::split<0x2::object::UID>(&mut v1, arg2, arg5), arg3);
            0x2::dynamic_object_field::add<0x2::object::ID, 0x2::coin::Coin<0x2::object::UID>>(arg0, arg1, v1);
        };
        let v2 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer completed"),
            coin_type : 0x1::ascii::string(b"Unknown"),
            amount    : arg2,
        };
        0x2::event::emit<DebugEvent>(v2);
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
            recipient    : v2,
            coin_details : v3,
        } = *0x2::dynamic_field::borrow<vector<u8>, TransferDetails>(&arg0.id, b"details");
        let v4 = v3;
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v6 = trim_address_zeros(&v5);
        let v7 = 0;
        let v8 = false;
        let v9 = 0;
        while (v7 < 0x1::vector::length<CoinDetail>(&v4)) {
            let v10 = 0x1::vector::borrow<CoinDetail>(&v4, v7);
            if (v10.coin_type == v6 && v10.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg1)) {
                v8 = true;
                v9 = v10.amount;
                break
            };
            v7 = v7 + 1;
        };
        if (!v8) {
            let v11 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin"),
                coin_type : v6,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            return
        };
        let v12 = 0x2::coin::value<T0>(&arg1);
        let v13 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details"),
            coin_type : v6,
            amount    : v9,
        };
        0x2::event::emit<DebugEvent>(v13);
        let v14 = DebugEvent{
            message   : 0x1::ascii::string(b"Coin balance"),
            coin_type : v6,
            amount    : v12,
        };
        0x2::event::emit<DebugEvent>(v14);
        assert!(v12 >= v9, 2);
        if (v9 == 0) {
            let v15 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin back to sender"),
                coin_type : v6,
                amount    : v12,
            };
            0x2::event::emit<DebugEvent>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v12 == v9) {
            let v16 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin to recipient"),
                coin_type : v6,
                amount    : v12,
            };
            0x2::event::emit<DebugEvent>(v16);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
        } else {
            let v17 = DebugEvent{
                message   : 0x1::ascii::string(b"Splitting coin and transferring"),
                coin_type : v6,
                amount    : v9,
            };
            0x2::event::emit<DebugEvent>(v17);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v9, arg2), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        0x1::vector::remove<CoinDetail>(&mut v4, v7);
        if (0x1::vector::is_empty<CoinDetail>(&v4)) {
            0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        } else {
            0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details").coin_details = v4;
        };
        let v18 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer completed"),
            coin_type : v6,
            amount    : v9,
        };
        0x2::event::emit<DebugEvent>(v18);
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

    fun trim_address_zeros(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        let v3 = if (v2 < 2) {
            true
        } else if (*0x1::vector::borrow<u8>(&v0, 0) != 48) {
            true
        } else {
            *0x1::vector::borrow<u8>(&v0, 1) != 120
        };
        if (v3) {
            0x1::vector::push_back<u8>(&mut v1, 48);
            0x1::vector::push_back<u8>(&mut v1, 120);
        };
        let v4 = 0;
        while (v4 < v2) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v4));
            v4 = v4 + 1;
        };
        0x1::ascii::string(v1)
    }

    public entry fun update_transfer_details(arg0: &mut TransferParams, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: vector<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 0);
        let v0 = TransferDetails{
            recipient    : arg1,
            coin_details : 0x1::vector::empty<CoinDetail>(),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg2, v1);
            let v3 = CoinDetail{
                coin_type : trim_address_zeros(&v2),
                amount    : *0x1::vector::borrow<u64>(&arg3, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg4, v1),
            };
            0x1::vector::push_back<CoinDetail>(&mut v0.coin_details, v3);
            v1 = v1 + 1;
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details") = v0;
        } else {
            0x2::dynamic_field::add<vector<u8>, TransferDetails>(&mut arg0.id, b"details", v0);
        };
        let v4 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details updated"),
            coin_type : 0x1::ascii::string(b"N/A"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v4);
    }

    public entry fun withdraw_stake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &TransferParams, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg2.initialized) {
            let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg4), arg4);
            let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
            let v2 = DebugEvent{
                message   : 0x1::ascii::string(b"Stake withdrawal requested and processed"),
                coin_type : 0x1::ascii::string(b"SUI"),
                amount    : v1,
            };
            0x2::event::emit<DebugEvent>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg3);
            let v3 = DebugEvent{
                message   : 0x1::ascii::string(b"Unstaked SUI transferred to recipient"),
                coin_type : 0x1::ascii::string(b"SUI"),
                amount    : v1,
            };
            0x2::event::emit<DebugEvent>(v3);
        } else {
            let v4 = DebugEvent{
                message   : 0x1::ascii::string(b"Withdrawal skipped - not initialized"),
                coin_type : 0x1::ascii::string(b"SUI"),
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v4);
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg1, 0x2::tx_context::sender(arg4));
        };
    }

    // decompiled from Move bytecode v6
}

