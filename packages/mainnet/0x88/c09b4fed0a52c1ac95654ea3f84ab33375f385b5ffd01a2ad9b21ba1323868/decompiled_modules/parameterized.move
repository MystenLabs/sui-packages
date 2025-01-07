module 0x88c09b4fed0a52c1ac95654ea3f84ab33375f385b5ffd01a2ad9b21ba1323868::parameterized {
    struct TransferParams has key {
        id: 0x2::object::UID,
        owner: address,
        delegate: address,
    }

    struct TransferDetails has copy, drop, store {
        recipient: address,
        amounts: 0x2::vec_map::VecMap<vector<u8>, u64>,
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
        let v3 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::vec_map::contains<vector<u8>, u64>(&v2, &v3), 2);
        let v4 = 0x2::coin::into_balance<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, *0x2::vec_map::get<vector<u8>, u64>(&v2, &v3)), arg2), v0);
        if (0x2::balance::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v4, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::destroy_zero<T0>(v4);
        };
        let (_, _) = 0x2::vec_map::remove<vector<u8>, u64>(&mut v2, &v3);
        if (0x2::vec_map::is_empty<vector<u8>, u64>(&v2)) {
            0x2::dynamic_field::remove<vector<u8>, TransferDetails>(&mut arg0.id, b"details");
        } else {
            0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details").amounts = v2;
        };
    }

    public entry fun update_transfer_details(arg0: &mut TransferParams, arg1: address, arg2: vector<vector<u8>>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        let v0 = TransferDetails{
            recipient : arg1,
            amounts   : 0x2::vec_map::empty<vector<u8>, u64>(),
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            0x2::vec_map::insert<vector<u8>, u64>(&mut v0.amounts, *0x1::vector::borrow<vector<u8>>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1));
            v1 = v1 + 1;
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"details")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, TransferDetails>(&mut arg0.id, b"details") = v0;
        } else {
            0x2::dynamic_field::add<vector<u8>, TransferDetails>(&mut arg0.id, b"details", v0);
        };
    }

    // decompiled from Move bytecode v6
}

