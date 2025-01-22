module 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::gmp {
    struct Singleton has key {
        id: 0x2::object::UID,
        channel: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::Channel,
    }

    struct Executed has copy, drop {
        data: vector<u8>,
    }

    public fun execute(arg0: 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::ApprovedMessage, arg1: &mut Singleton) {
        let (_, _, _, v3) = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::consume_approved_message(&arg1.channel, arg0);
        let v4 = Executed{data: v3};
        0x2::event::emit<Executed>(v4);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Singleton{
            id      : 0x2::object::new(arg0),
            channel : 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::channel::new(arg0),
        };
        0x2::transfer::share_object<Singleton>(v0);
    }

    public fun register_transaction(arg0: &mut 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::RelayerDiscovery, arg1: &Singleton) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, x"02");
        0x1::vector::push_back<vector<u8>>(v1, 0xe7b3b82168fd366b810305e097ce1df8d5b58ed516b1238e4dd756df18af22a::utils::concat<u8>(x"00", 0x2::address::to_bytes(0x2::object::id_address<Singleton>(arg1))));
        let v2 = 0x1::type_name::get<Singleton>();
        let v3 = 0x1::type_name::get_address(&v2);
        let v4 = 0x1::vector::empty<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>();
        0x1::vector::push_back<0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::MoveCall>(&mut v4, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_move_call(0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_function(0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v3))), 0x1::ascii::string(b"gmp"), 0x1::ascii::string(b"execute")), v0, 0x1::vector::empty<0x1::ascii::String>()));
        0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::discovery::register_transaction(arg0, &arg1.channel, 0x2b839b25c7133e5e0f8f585cb2e89bf430a6585a88c4a0343ae3b246372d431c::transaction::new_transaction(true, v4));
    }

    public fun send_call(arg0: &Singleton, arg1: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::Gateway, arg2: &mut 0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service::GasService, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: vector<u8>, arg6: address, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: vector<u8>) {
        let v0 = 0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::prepare_message(&arg0.channel, arg3, arg4, arg5);
        0xc10dd54f42a2f3ebdb8f113bd0a0627934c90e608d1e32e5fd0c7ae4d03d93b3::gas_service::pay_gas(arg2, &v0, arg7, arg6, arg8);
        0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::gateway::send_message(arg1, v0);
    }

    // decompiled from Move bytecode v6
}

