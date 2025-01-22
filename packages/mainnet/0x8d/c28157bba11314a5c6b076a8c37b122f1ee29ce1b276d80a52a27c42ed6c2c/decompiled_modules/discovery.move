module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::discovery {
    public fun call_info(arg0: &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg1: vector<u8>) : 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction {
        let v0 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_reader(arg1);
        let v1 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v0);
        let v2 = v1;
        if (v1 == 4) {
            0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::skip_slot(&mut v0);
            let v3 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v0);
            v0 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_reader(v3);
            v2 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v0);
        };
        if (v2 == 0) {
            let v5 = &mut v0;
            interchain_transfer_tx(arg0, v5)
        } else {
            assert!(v2 == 1, 9223372431991767041);
            let v6 = &mut v0;
            deploy_interchain_token_tx(arg0, v6)
        }
    }

    fun deploy_interchain_token_tx(arg0: &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg1: &mut 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::AbiReader) : 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::object::id_address<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS>(arg0)));
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = &mut v1;
        0x1::vector::push_back<vector<u8>>(v2, v0);
        0x1::vector::push_back<vector<u8>>(v2, x"02");
        0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::skip_slot(arg1);
        0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::skip_slot(arg1);
        let v3 = 0x1::ascii::string(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(arg1));
        0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::skip_slot(arg1);
        let v4 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v4, 0x1::type_name::into_string(*0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::unregistered_coin_type(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::package_value(arg0), &v3, (0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(arg1) as u8))));
        let v5 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
        0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v5, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::package_id<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS>(), 0x1::ascii::string(b"its"), 0x1::ascii::string(b"receive_deploy_interchain_token")), v1, v4));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(true, v5)
    }

    public fun interchain_transfer_info(arg0: vector<u8>) : (0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, address, u64, vector<u8>) {
        let v0 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::new_reader(arg0);
        assert!(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v0) == 0, 9223372182883794947);
        0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::skip_slot(&mut v0);
        (0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::from_u256(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v0)), 0x2::address::from_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v0)), (0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(&mut v0) as u64), 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(&mut v0))
    }

    fun interchain_transfer_tx(arg0: &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg1: &mut 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::AbiReader) : 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction {
        0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::skip_slot(arg1);
        0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::skip_slot(arg1);
        let v0 = 0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(arg1);
        if (0x1::vector::is_empty<u8>(&v0)) {
            let v2 = x"00";
            0x1::vector::append<u8>(&mut v2, 0x2::address::to_bytes(0x2::object::id_address<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS>(arg0)));
            let v3 = 0x1::vector::empty<vector<u8>>();
            let v4 = &mut v3;
            0x1::vector::push_back<vector<u8>>(v4, v2);
            0x1::vector::push_back<vector<u8>>(v4, x"02");
            0x1::vector::push_back<vector<u8>>(v4, x"0006");
            let v5 = 0x1::vector::empty<0x1::ascii::String>();
            0x1::vector::push_back<0x1::ascii::String>(&mut v5, 0x1::type_name::into_string(*0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::registered_coin_type(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::package_value(arg0), 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::from_u256(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_u256(arg1)))));
            let v6 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
            0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v6, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::package_id<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS>(), 0x1::ascii::string(b"its"), 0x1::ascii::string(b"receive_interchain_transfer")), v3, v5));
            0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(true, v6)
        } else {
            let v7 = x"00";
            let v8 = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its_v0::relayer_discovery_id(0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::package_value(arg0));
            0x1::vector::append<u8>(&mut v7, 0x2::address::to_bytes(0x2::object::id_to_address(&v8)));
            let v9 = x"01";
            0x1::vector::append<u8>(&mut v9, 0x2::address::to_bytes(0x2::address::from_bytes(0x451b9e382d50aff0b2f5582482ae28ebbffbf1ff2d7bcce3220637a862649be1::abi::read_bytes(arg1))));
            let v10 = 0x1::vector::empty<vector<u8>>();
            let v11 = &mut v10;
            0x1::vector::push_back<vector<u8>>(v11, v7);
            0x1::vector::push_back<vector<u8>>(v11, v9);
            let v12 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
            0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v12, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::package_id<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery>(), 0x1::ascii::string(b"discovery"), 0x1::ascii::string(b"get_transaction")), v10, 0x1::vector::empty<0x1::ascii::String>()));
            0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(false, v12)
        }
    }

    public fun register_transaction(arg0: &mut 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg1: &mut 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery) {
        let v0 = x"00";
        let v1 = 0x2::object::id<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::object::id_to_bytes(&v1));
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = &mut v2;
        0x1::vector::push_back<vector<u8>>(v3, v0);
        0x1::vector::push_back<vector<u8>>(v3, x"03");
        let v4 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
        0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v4, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::package_id<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS>(), 0x1::ascii::string(b"discovery"), 0x1::ascii::string(b"call_info")), v2, 0x1::vector::empty<0x1::ascii::String>()));
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::register_transaction(arg0, arg1, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(false, v4));
    }

    // decompiled from Move bytecode v6
}

