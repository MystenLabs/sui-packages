module 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_pool {
    struct PoolGenesis has key {
        id: 0x2::object::UID,
        creator: address,
        is_init: bool,
    }

    struct PoolState has key {
        id: 0x2::object::UID,
        wormhole_emitter: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap,
        consumed_vaas: 0x2::object_table::ObjectTable<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_verify::Unit>,
        registered_emitters: 0x2::vec_map::VecMap<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>,
    }

    struct PoolWithdrawEvent has copy, drop {
        nonce: u64,
        source_chain_id: u16,
        dst_chain_id: u16,
        pool_address: vector<u8>,
        receiver: vector<u8>,
        amount: u64,
    }

    public(friend) fun send_message(arg0: &mut PoolState, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u16, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg0.wormhole_emitter, 0, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_pool::send_message(arg3, arg4, arg6)), arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolGenesis{
            id      : 0x2::object::new(arg0),
            creator : 0x2::tx_context::sender(arg0),
            is_init : false,
        };
        0x2::transfer::share_object<PoolGenesis>(v0);
    }

    public entry fun initialize(arg0: &mut PoolGenesis, arg1: u16, arg2: vector<u8>, arg3: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg4), 2);
        assert!(!arg0.is_init, 3);
        let v0 = 0x2::vec_map::empty<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>();
        0x2::vec_map::insert<u16, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress>(&mut v0, arg1, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::new(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::new(arg2)));
        let v1 = PoolState{
            id                  : 0x2::object::new(arg4),
            wormhole_emitter    : 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg3, arg4),
            consumed_vaas       : 0x2::object_table::new<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes32::Bytes32, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_verify::Unit>(arg4),
            registered_emitters : v0,
        };
        0x2::transfer::share_object<PoolState>(v1);
        arg0.is_init = true;
    }

    public entry fun receive_withdraw<T0>(arg0: &0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::GovernanceGenesis, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut PoolState, arg3: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_pool::Pool<T0>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::genesis::check_latest_version(arg0);
        let (v0, v1, v2, v3, v4, _) = 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::pool_codec::decode_withdraw_payload(0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_payload(0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::wormhole_adapter_verify::parse_verify_and_replay_protect(arg1, &arg2.registered_emitters, &mut arg2.consumed_vaas, arg4, arg5, arg6)));
        let v6 = v3;
        let v7 = v2;
        0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_pool::withdraw<T0>(arg3, v6, v4, v7, arg6);
        let v8 = PoolWithdrawEvent{
            nonce           : v1,
            source_chain_id : v0,
            dst_chain_id    : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_chain_id(&v7),
            pool_address    : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_address(&v7),
            receiver        : 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_address::get_dola_address(&v6),
            amount          : v4,
        };
        0x2::event::emit<PoolWithdrawEvent>(v8);
    }

    public(friend) fun send_deposit<T0>(arg0: &mut PoolState, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_pool::Pool<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u16, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, arg2, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(&mut arg0.wormhole_emitter, 0, 0x2daca359a68a04f3ed381b4427ffdb2ec1e464821c5098bbb4ddb9024e680845::dola_pool::deposit<T0>(arg3, arg4, arg5, arg6, arg8)), arg7);
    }

    // decompiled from Move bytecode v6
}

