module 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::its {
    struct Singleton has key {
        id: 0x2::object::UID,
        channel: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel,
    }

    struct ExecutedWithToken has copy, drop {
        source_chain: 0x1::ascii::String,
        source_address: vector<u8>,
        data: vector<u8>,
        amount: u64,
    }

    public fun deploy_remote_interchain_token<T0>(arg0: &mut 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg1: &mut 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::Gateway, arg2: &mut 0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service::GasService, arg3: 0x1::ascii::String, arg4: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: vector<u8>, arg7: address) {
        pay_gas_and_send_message(arg1, arg2, arg5, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::deploy_remote_interchain_token<T0>(arg0, arg4, arg3), arg7, arg6);
    }

    public fun get_final_transaction(arg0: &Singleton, arg1: &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg2: vector<u8>, arg3: &0x2::clock::Clock) : 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::Transaction {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, x"02");
        0x1::vector::push_back<vector<u8>>(v1, 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::utils::concat<u8>(x"00", 0x2::address::to_bytes(0x2::object::id_address<Singleton>(arg0))));
        0x1::vector::push_back<vector<u8>>(v1, 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::utils::concat<u8>(x"00", 0x2::address::to_bytes(0x2::object::id_address<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS>(arg1))));
        0x1::vector::push_back<vector<u8>>(v1, 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::utils::concat<u8>(x"00", 0x2::address::to_bytes(0x2::object::id_address<0x2::clock::Clock>(arg3))));
        let (v2, _, _, _) = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::discovery::interchain_transfer_info(arg2);
        let v6 = 0x1::type_name::get<Singleton>();
        let v7 = 0x1::type_name::get_address(&v6);
        let v8 = 0x1::vector::empty<0x1::ascii::String>();
        0x1::vector::push_back<0x1::ascii::String>(&mut v8, 0x1::type_name::into_string(*0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::registered_coin_type(arg1, v2)));
        let v9 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
        0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v9, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v7))), 0x1::ascii::string(b"its"), 0x1::ascii::string(b"receive_interchain_transfer")), v0, v8));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(true, v9)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Singleton{
            id      : 0x2::object::new(arg0),
            channel : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::new(arg0),
        };
        0x2::transfer::share_object<Singleton>(v0);
    }

    fun pay_gas_and_send_message(arg0: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::Gateway, arg1: &mut 0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service::GasService, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::message_ticket::MessageTicket, arg4: address, arg5: vector<u8>) {
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service::pay_gas(arg1, &arg3, arg2, arg4, arg5);
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::send_message(arg0, arg3);
    }

    public fun receive_interchain_transfer<T0>(arg0: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg1: &Singleton, arg2: &mut 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::receive_interchain_transfer_with_data<T0>(arg2, arg0, &arg1.channel, arg3, arg4);
        let v4 = v3;
        let v5 = ExecutedWithToken{
            source_chain   : v0,
            source_address : v1,
            data           : v2,
            amount         : 0x2::coin::value<T0>(&v4),
        };
        0x2::event::emit<ExecutedWithToken>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, 0x2::tx_context::sender(arg4));
    }

    public fun register_coin<T0>(arg0: &mut 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg1: &0x2::coin::CoinMetadata<T0>) : 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId {
        0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::register_coin<T0>(arg0, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::from_info<T0>(0x2::coin::get_name<T0>(arg1), 0x2::coin::get_symbol<T0>(arg1), 0x2::coin::get_decimals<T0>(arg1)), 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::new_locked<T0>())
    }

    public fun register_transaction(arg0: &mut 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery, arg1: &Singleton, arg2: &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg3: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::utils::concat<u8>(x"00", 0x2::address::to_bytes(0x2::object::id_address<Singleton>(arg1))));
        0x1::vector::push_back<vector<u8>>(v1, 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::utils::concat<u8>(x"00", 0x2::address::to_bytes(0x2::object::id_address<0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS>(arg2))));
        0x1::vector::push_back<vector<u8>>(v1, x"03");
        0x1::vector::push_back<vector<u8>>(v1, 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::utils::concat<u8>(x"00", 0x2::address::to_bytes(0x2::object::id_address<0x2::clock::Clock>(arg3))));
        let v2 = 0x1::type_name::get<Singleton>();
        let v3 = 0x1::type_name::get_address(&v2);
        let v4 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
        0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v4, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v3))), 0x1::ascii::string(b"its"), 0x1::ascii::string(b"get_final_transaction")), v0, 0x1::vector::empty<0x1::ascii::String>()));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::register_transaction(arg0, &arg1.channel, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(false, v4));
    }

    public fun send_interchain_transfer_call<T0>(arg0: &Singleton, arg1: &mut 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::ITS, arg2: &mut 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::Gateway, arg3: &mut 0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service::GasService, arg4: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::token_id::TokenId, arg5: 0x2::coin::Coin<T0>, arg6: 0x1::ascii::String, arg7: vector<u8>, arg8: vector<u8>, arg9: address, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: vector<u8>, arg12: &0x2::clock::Clock) {
        pay_gas_and_send_message(arg2, arg3, arg10, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::send_interchain_transfer<T0>(arg1, 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::its::prepare_interchain_transfer<T0>(arg4, arg5, arg6, arg7, arg8, &arg0.channel), arg12), arg9, arg11);
    }

    // decompiled from Move bytecode v6
}

