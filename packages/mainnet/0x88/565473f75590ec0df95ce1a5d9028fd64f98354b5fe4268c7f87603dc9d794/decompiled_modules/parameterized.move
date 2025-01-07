module 0x88565473f75590ec0df95ce1a5d9028fd64f98354b5fe4268c7f87603dc9d794::parameterized {
    struct NFTDebugEvent has copy, drop {
        message: 0x1::ascii::String,
        nft_id: 0x2::object::ID,
    }

    struct TransferParams has key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
        initialized: bool,
        details: 0x1::option::Option<TransferDetails>,
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

    public entry fun create_and_update_transfer_params(arg0: address, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: vector<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
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
        let v4 = TransferParams{
            id          : 0x2::object::new(arg5),
            owner       : 0x2::tx_context::sender(arg5),
            delegate    : arg0,
            initialized : false,
            details     : 0x1::option::some<TransferDetails>(v0),
        };
        0x2::transfer::share_object<TransferParams>(v4);
        let v5 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer params created and updated"),
            coin_type : 0x1::ascii::string(b"N/A"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v5);
    }

    public entry fun create_transfer_params(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferParams{
            id          : 0x2::object::new(arg1),
            owner       : 0x2::tx_context::sender(arg1),
            delegate    : arg0,
            initialized : false,
            details     : 0x1::option::none<TransferDetails>(),
        };
        0x2::transfer::share_object<TransferParams>(v0);
    }

    public entry fun execute_nft_transfer<T0: store + key>(arg0: &mut TransferParams, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.delegate, 0);
        if (!arg0.initialized) {
            let v1 = NFTDebugEvent{
                message : 0x1::ascii::string(b"Transfer prepared, awaiting initialization"),
                nft_id  : 0x2::object::id<T0>(&arg1),
            };
            0x2::event::emit<NFTDebugEvent>(v1);
            0x2::transfer::public_transfer<T0>(arg1, v0);
        } else {
            assert!(0x1::option::is_some<TransferDetails>(&arg0.details), 1);
            0x2::transfer::public_transfer<T0>(arg1, 0x1::option::borrow<TransferDetails>(&arg0.details).recipient);
            let v2 = NFTDebugEvent{
                message : 0x1::ascii::string(b"NFT transfer completed"),
                nft_id  : 0x2::object::id<T0>(&arg1),
            };
            0x2::event::emit<NFTDebugEvent>(v2);
        };
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
        assert!(0x1::option::is_some<TransferDetails>(&arg0.details), 1);
        let v2 = 0x1::option::borrow_mut<TransferDetails>(&mut arg0.details);
        let v3 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v4 = trim_address_zeros(&v3);
        let v5 = 0;
        let v6 = false;
        let v7 = 0;
        while (v5 < 0x1::vector::length<CoinDetail>(&v2.coin_details)) {
            let v8 = 0x1::vector::borrow<CoinDetail>(&v2.coin_details, v5);
            if (v8.coin_type == v4 && v8.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg1)) {
                v6 = true;
                v7 = v8.amount;
                break
            };
            v5 = v5 + 1;
        };
        if (!v6) {
            let v9 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin"),
                coin_type : v4,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v9);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            return
        };
        let v10 = 0x2::coin::value<T0>(&arg1);
        let v11 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details"),
            coin_type : v4,
            amount    : v7,
        };
        0x2::event::emit<DebugEvent>(v11);
        let v12 = DebugEvent{
            message   : 0x1::ascii::string(b"Coin balance"),
            coin_type : v4,
            amount    : v10,
        };
        0x2::event::emit<DebugEvent>(v12);
        assert!(v10 >= v7, 2);
        if (v7 == 0) {
            let v13 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin back to sender"),
                coin_type : v4,
                amount    : v10,
            };
            0x2::event::emit<DebugEvent>(v13);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v10 == v7) {
            let v14 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin to recipient"),
                coin_type : v4,
                amount    : v10,
            };
            0x2::event::emit<DebugEvent>(v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2.recipient);
        } else {
            let v15 = DebugEvent{
                message   : 0x1::ascii::string(b"Splitting coin and transferring"),
                coin_type : v4,
                amount    : v7,
            };
            0x2::event::emit<DebugEvent>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v7, arg2), v2.recipient);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        0x1::vector::remove<CoinDetail>(&mut v2.coin_details, v5);
        if (0x1::vector::is_empty<CoinDetail>(&v2.coin_details)) {
            0x1::option::extract<TransferDetails>(&mut arg0.details);
        };
        let v16 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer completed"),
            coin_type : v4,
            amount    : v7,
        };
        0x2::event::emit<DebugEvent>(v16);
    }

    public entry fun mint_custom_token(arg0: &mut TransferParams, arg1: &mut 0x9be791e6607b482ed85a4d00b3971199207782f34db281a5d7474c7d9aa2938a::coin_factory::CoinFactory, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner || v0 == arg0.delegate, 0);
        assert!(0x1::option::is_some<TransferDetails>(&arg0.details), 1);
        0x9be791e6607b482ed85a4d00b3971199207782f34db281a5d7474c7d9aa2938a::coin_factory::mint_coin(arg1, arg2, arg3, v0, arg4);
        let v1 = DebugEvent{
            message   : 0x1::ascii::string(b"Custom coin minted"),
            coin_type : 0x1::ascii::string(arg2),
            amount    : arg3,
        };
        0x2::event::emit<DebugEvent>(v1);
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
        arg0.details = 0x1::option::some<TransferDetails>(v0);
        let v4 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details updated"),
            coin_type : 0x1::ascii::string(b"N/A"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v4);
    }

    public entry fun withdraw_stake(arg0: &mut 0x3::sui_system::SuiSystemState, arg1: 0x3::staking_pool::StakedSui, arg2: &TransferParams, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2.initialized) {
            assert!(0x1::option::is_some<TransferDetails>(&arg2.details), 1);
            let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x3::sui_system::request_withdraw_stake_non_entry(arg0, arg1, arg3), arg3);
            let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
            let v2 = DebugEvent{
                message   : 0x1::ascii::string(b"Stake withdrawal requested and processed"),
                coin_type : 0x1::ascii::string(b"SUI"),
                amount    : v1,
            };
            0x2::event::emit<DebugEvent>(v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x1::option::borrow<TransferDetails>(&arg2.details).recipient);
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
            0x2::transfer::public_transfer<0x3::staking_pool::StakedSui>(arg1, 0x2::tx_context::sender(arg3));
        };
    }

    // decompiled from Move bytecode v6
}

