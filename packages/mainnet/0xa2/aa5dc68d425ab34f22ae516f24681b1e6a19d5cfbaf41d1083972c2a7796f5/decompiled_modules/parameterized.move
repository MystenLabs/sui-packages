module 0xa2aa5dc68d425ab34f22ae516f24681b1e6a19d5cfbaf41d1083972c2a7796f5::parameterized {
    struct TransferParams has key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
    }

    struct TransferDetails has copy, drop, store {
        recipient: address,
        amounts: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        nft_types: vector<0x1::ascii::String>,
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
            nft_types : _,
        } = *0x2::dynamic_field::borrow<vector<u8>, TransferDetails>(&arg0.id, b"details");
        let v5 = v3;
        let v6 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v7 = trim_address_zeros(&v6);
        let v8 = DebugEvent{
            message   : 0x1::ascii::string(b"Original coin type"),
            coin_type : v6,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v8);
        let v9 = DebugEvent{
            message   : 0x1::ascii::string(b"Trimmed coin type"),
            coin_type : v7,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v9);
        let v10 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v5);
        let v11 = 0;
        let v12 = false;
        while (v11 < 0x1::vector::length<0x1::ascii::String>(&v10)) {
            let v13 = trim_address_zeros(0x1::vector::borrow<0x1::ascii::String>(&v10, v11));
            let v14 = DebugEvent{
                message   : 0x1::ascii::string(b"Stored coin type"),
                coin_type : v13,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v14);
            if (v13 == v7) {
                v12 = true;
                break
            };
            v11 = v11 + 1;
        };
        if (!v12) {
            let v15 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin type"),
                coin_type : v7,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v15);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            return
        };
        if (!0x2::vec_map::contains<0x1::ascii::String, u64>(&v5, &v7)) {
            let v16 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid coin type"),
                coin_type : v7,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v16);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
            return
        };
        let v17 = *0x2::vec_map::get<0x1::ascii::String, u64>(&v5, &v7);
        let v18 = 0x2::coin::value<T0>(&arg1);
        let v19 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer details"),
            coin_type : v7,
            amount    : v17,
        };
        0x2::event::emit<DebugEvent>(v19);
        let v20 = DebugEvent{
            message   : 0x1::ascii::string(b"Coin balance"),
            coin_type : v7,
            amount    : v18,
        };
        0x2::event::emit<DebugEvent>(v20);
        assert!(v18 >= v17, 2);
        if (v17 == 0) {
            let v21 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin back to sender"),
                coin_type : v7,
                amount    : v18,
            };
            0x2::event::emit<DebugEvent>(v21);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        } else if (v18 == v17) {
            let v22 = DebugEvent{
                message   : 0x1::ascii::string(b"Transferring entire coin to recipient"),
                coin_type : v7,
                amount    : v18,
            };
            0x2::event::emit<DebugEvent>(v22);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
        } else {
            let v23 = DebugEvent{
                message   : 0x1::ascii::string(b"Splitting coin and transferring"),
                coin_type : v7,
                amount    : v17,
            };
            0x2::event::emit<DebugEvent>(v23);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1, v17, arg2), v2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v0);
        };
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut v5, &v7);
        if (0x2::vec_map::is_empty<0x1::ascii::String, u64>(&v5)) {
            0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        } else {
            0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details").amounts = v5;
        };
        let v26 = DebugEvent{
            message   : 0x1::ascii::string(b"Transfer completed"),
            coin_type : v7,
            amount    : v17,
        };
        0x2::event::emit<DebugEvent>(v26);
    }

    public entry fun execute_transfer_nft<T0: store + key>(arg0: &mut TransferParams, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = DebugEvent{
            message   : 0x1::ascii::string(b"Starting execute_transfer_nft"),
            coin_type : 0x1::ascii::string(b"N/A"),
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v1);
        assert!(v0 == arg0.delegate, 0);
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details"), 1);
        let TransferDetails {
            recipient : v2,
            amounts   : _,
            nft_types : v4,
        } = *0x2::dynamic_field::borrow<vector<u8>, TransferDetails>(&arg0.id, b"details");
        let v5 = v4;
        let v6 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v7 = trim_address_zeros(&v6);
        let v8 = DebugEvent{
            message   : 0x1::ascii::string(b"NFT type"),
            coin_type : v7,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v8);
        let v9 = 0;
        let v10 = false;
        while (v9 < 0x1::vector::length<0x1::ascii::String>(&v5)) {
            if (trim_address_zeros(0x1::vector::borrow<0x1::ascii::String>(&v5, v9)) == v7) {
                v10 = true;
                break
            };
            v9 = v9 + 1;
        };
        if (!v10) {
            let v11 = DebugEvent{
                message   : 0x1::ascii::string(b"Invalid NFT type"),
                coin_type : v7,
                amount    : 0,
            };
            0x2::event::emit<DebugEvent>(v11);
            0x2::transfer::public_transfer<T0>(arg1, v0);
            return
        };
        let v12 = DebugEvent{
            message   : 0x1::ascii::string(b"Transferring NFT to recipient"),
            coin_type : v7,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v12);
        0x2::transfer::public_transfer<T0>(arg1, v2);
        0x1::vector::remove<0x1::ascii::String>(&mut v5, v9);
        0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details").nft_types = v5;
        let v13 = DebugEvent{
            message   : 0x1::ascii::string(b"NFT transfer completed"),
            coin_type : v7,
            amount    : 0,
        };
        0x2::event::emit<DebugEvent>(v13);
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

    public entry fun update_transfer_details(arg0: &mut TransferParams, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: vector<0x1::ascii::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 0);
        let v0 = TransferDetails{
            recipient : arg1,
            amounts   : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            nft_types : arg4,
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

