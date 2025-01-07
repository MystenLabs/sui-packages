module 0xa39e90252de8ae9490cd2a84d5b5898923f0621f03d11971a9a481f9528d8f1f::parameterized {
    struct NFTTransferDetails has copy, drop, store {
        recipient: address,
        nft_id: 0x2::object::ID,
    }

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
        amounts: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct DebugEvent has copy, drop {
        message: 0x1::ascii::String,
        coin_type: 0x1::ascii::String,
        amount: u64,
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

    public entry fun execute_nft_transfer<T0: store + key>(arg0: &mut TransferParams, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.delegate, 0);
        if (!arg0.initialized) {
            let v0 = NFTDebugEvent{
                message : 0x1::ascii::string(b"Transfer prepared, awaiting initialization"),
                nft_id  : arg1,
            };
            0x2::event::emit<NFTDebugEvent>(v0);
            return
        };
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_details"), 1);
        let NFTTransferDetails {
            recipient : v1,
            nft_id    : v2,
        } = *0x2::dynamic_field::borrow<vector<u8>, NFTTransferDetails>(&arg0.id, b"nft_details");
        assert!(arg1 == v2, 3);
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg0.id, arg1), 3);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1), v1);
        0x2::dynamic_field::remove<vector<u8>, NFTTransferDetails>(&mut arg0.id, b"nft_details");
        let v3 = NFTDebugEvent{
            message : 0x1::ascii::string(b"NFT transfer completed"),
            nft_id  : arg1,
        };
        0x2::event::emit<NFTDebugEvent>(v3);
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
            message   : 0x1::ascii::string(b"Original coin type"),
            coin_type : v5,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v7);
        let v8 = DebugEvent{
            message   : 0x1::ascii::string(b"Trimmed coin type"),
            coin_type : v6,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v8);
        let v9 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v4);
        let v10 = 0;
        let v11 = false;
        while (v10 < 0x1::vector::length<0x1::ascii::String>(&v9)) {
            let v12 = trim_address_zeros(0x1::vector::borrow<0x1::ascii::String>(&v9, v10));
            let v13 = DebugEvent{
                message   : 0x1::ascii::string(b"Stored coin type"),
                coin_type : v12,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v13);
            if (v12 == v6) {
                v11 = true;
                break
            };
            v10 = v10 + 1;
        };
        if (!v11) {
            let v14 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin type"),
                coin_type : v6,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v14);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            return
        };
        if (!0x2::vec_map::contains<0x1::ascii::String, u64>(&v4, &v6)) {
            let v15 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin type"),
                coin_type : v6,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            return
        };
        let v16 = *0x2::vec_map::get<0x1::ascii::String, u64>(&v4, &v6);
        let v17 = 0x2::coin::value<T0>(&arg1);
        let v18 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details"),
            coin_type : v6,
            amount    : v16,
        };
        0x2::event::emit<DebugEvent>(v18);
        let v19 = DebugEvent{
            message   : 0x1::ascii::string(b"Coin balance"),
            coin_type : v6,
            amount    : v17,
        };
        0x2::event::emit<DebugEvent>(v19);
        assert!(v17 >= v16, 2);
        if (v16 == 0) {
            let v20 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin back to sender"),
                coin_type : v6,
                amount    : v17,
            };
            0x2::event::emit<DebugEvent>(v20);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v17 == v16) {
            let v21 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin to recipient"),
                coin_type : v6,
                amount    : v17,
            };
            0x2::event::emit<DebugEvent>(v21);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
        } else {
            let v22 = DebugEvent{
                message   : 0x1::ascii::string(b"Splitting coin and transferring"),
                coin_type : v6,
                amount    : v16,
            };
            0x2::event::emit<DebugEvent>(v22);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v16, arg2), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v4, &v6);
        if (0x2::vec_map::is_empty<0x1::ascii::String, u64>(&v4)) {
            0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        } else {
            0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details").amounts = v4;
        };
        let v25 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer completed"),
            coin_type : v6,
            amount    : v16,
        };
        0x2::event::emit<DebugEvent>(v25);
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

    public entry fun update_nft_transfer_details<T0: store + key>(arg0: &mut TransferParams, arg1: address, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        let v0 = 0x2::object::id<T0>(&arg2);
        let v1 = NFTTransferDetails{
            recipient : arg1,
            nft_id    : v0,
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"nft_details")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, NFTTransferDetails>(&mut arg0.id, b"nft_details") = v1;
        } else {
            0x2::dynamic_field::add<vector<u8>, NFTTransferDetails>(&mut arg0.id, b"nft_details", v1);
        };
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg2);
        let v2 = NFTDebugEvent{
            message : 0x1::ascii::string(b"NFT transfer details updated"),
            nft_id  : v0,
        };
        0x2::event::emit<NFTDebugEvent>(v2);
    }

    public entry fun update_transfer_details(arg0: &mut TransferParams, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        let v0 = TransferDetails{
            recipient : arg1,
            amounts   : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg2, v1);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v0.amounts, trim_address_zeros(&v2), *0x1::vector::borrow<u64>(&arg3, v1));
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

