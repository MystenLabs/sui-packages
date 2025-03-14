module 0x8d5c4c41100bb78c14355b7be6e8d8a5f8cadcff5780e7ff16b992958d856fcc::parameterized {
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

    fun add_transfer_details(arg0: &mut TransferParams, arg1: TransferDetails) {
        0x2::dynamic_field::add<vector<u8>, TransferDetails>(&mut arg0.id, b"details", arg1);
    }

    public entry fun create_and_update_transfer_params(arg0: address, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: vector<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = TransferParams{
            id          : 0x2::object::new(arg5),
            owner       : 0x2::tx_context::sender(arg5),
            delegate    : arg0,
            initialized : false,
        };
        let v1 = TransferDetails{
            recipient    : arg1,
            coin_details : 0x1::vector::empty<CoinDetail>(),
        };
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::ascii::String>(&arg2)) {
            let v3 = *0x1::vector::borrow<0x1::ascii::String>(&arg2, v2);
            let v4 = CoinDetail{
                coin_type : trim_address_zeros(&v3),
                amount    : *0x1::vector::borrow<u64>(&arg3, v2),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg4, v2),
            };
            0x1::vector::push_back<CoinDetail>(&mut v1.coin_details, v4);
            v2 = v2 + 1;
        };
        let v5 = &mut v0;
        add_transfer_details(v5, v1);
        0x2::transfer::share_object<TransferParams>(v0);
        let v6 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer params created and updated"),
            coin_type : 0x1::ascii::string(b"N/A"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v6);
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
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        let v3 = &mut v2.coin_details;
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v5 = trim_address_zeros(&v4);
        let v6 = 0;
        let v7 = false;
        let v8 = 0;
        while (v6 < 0x1::vector::length<CoinDetail>(v3)) {
            let v9 = 0x1::vector::borrow<CoinDetail>(v3, v6);
            if (v9.coin_type == v5 && v9.object_id == 0x2::object::id<0x2::coin::Coin<T0>>(&arg1)) {
                v7 = true;
                v8 = v9.amount;
                break
            };
            v6 = v6 + 1;
        };
        if (!v7) {
            let v10 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin"),
                coin_type : v5,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v10);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            return
        };
        let v11 = 0x2::coin::value<T0>(&arg1);
        let v12 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details"),
            coin_type : v5,
            amount    : v8,
        };
        0x2::event::emit<DebugEvent>(v12);
        let v13 = DebugEvent{
            message   : 0x1::ascii::string(b"Coin balance"),
            coin_type : v5,
            amount    : v11,
        };
        0x2::event::emit<DebugEvent>(v13);
        assert!(v11 >= v8, 2);
        if (v8 == 0) {
            let v14 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin back to sender"),
                coin_type : v5,
                amount    : v11,
            };
            0x2::event::emit<DebugEvent>(v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v11 == v8) {
            let v15 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin to recipient"),
                coin_type : v5,
                amount    : v11,
            };
            0x2::event::emit<DebugEvent>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2.recipient);
        } else {
            let v16 = DebugEvent{
                message   : 0x1::ascii::string(b"Splitting coin and transferring"),
                coin_type : v5,
                amount    : v8,
            };
            0x2::event::emit<DebugEvent>(v16);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v8, arg2), v2.recipient);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        0x1::vector::remove<CoinDetail>(v3, v6);
        if (0x1::vector::is_empty<CoinDetail>(v3)) {
            0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        };
        let v17 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer completed"),
            coin_type : v5,
            amount    : v8,
        };
        0x2::event::emit<DebugEvent>(v17);
    }

    public entry fun mint_custom_token(arg0: &mut TransferParams, arg1: &mut 0x9be791e6607b482ed85a4d00b3971199207782f34db281a5d7474c7d9aa2938a::coin_factory::CoinFactory, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.owner || v0 == arg0.delegate, 0);
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

