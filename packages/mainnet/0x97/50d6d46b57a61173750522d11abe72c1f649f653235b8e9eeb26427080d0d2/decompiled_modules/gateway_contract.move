module 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::gateway_contract {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PauseCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResourceSetterCap has store, key {
        id: 0x2::object::UID,
    }

    struct ExecuteDappIReceive has store, key {
        id: 0x2::object::UID,
        route_amount: u256,
        request_identifier: u256,
        request_timestamp: u256,
        src_chain_id: 0x1::string::String,
        route_recipient: address,
        dest_chain_id: 0x1::string::String,
        request_sender: 0x1::string::String,
        dapp_object_id: address,
        dapp_module_address: address,
        packet: vector<u8>,
        is_read_call: bool,
        relayer_router_address: 0x1::string::String,
    }

    struct ExecuteDappIAck has store, key {
        id: 0x2::object::UID,
        request_identifier: u256,
        ack_request_identifier: u256,
        dest_chain_id: 0x1::string::String,
        dapp_object_id: address,
        dapp_module_address: address,
        exec_data: vector<u8>,
        exec_flag: bool,
        relayer_router_address: 0x1::string::String,
    }

    struct ValidateAsm has store, key {
        id: 0x2::object::UID,
        route_amount: u256,
        request_identifier: u256,
        request_timestamp: u256,
        src_chain_id: 0x1::string::String,
        route_recipient: address,
        dest_chain_id: 0x1::string::String,
        request_sender: 0x1::string::String,
        dapp_object_id: address,
        dapp_module_address: address,
        asm_object_id: address,
        asm_module_address: address,
        packet: vector<u8>,
        is_read_call: bool,
        relayer_router_address: 0x1::string::String,
    }

    struct GatewayContract has store, key {
        id: 0x2::object::UID,
        current_version: u128,
        chain_id: 0x1::string::String,
        event_nonce: u256,
        last_valset_nonce: u256,
        isend_defauft_fee: u64,
        last_valset_checkpoint: vector<u8>,
        nonce_executed: 0x2::table::Table<vector<u8>, bool>,
        ack_nonce_executed: 0x2::table::Table<u256, bool>,
        paused: bool,
        initialized: bool,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        route_treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>,
    }

    struct Metadata has store, key {
        id: 0x2::object::UID,
        request_sender: vector<u8>,
    }

    struct GATEWAY_CONTRACT has drop {
        dummy_field: bool,
    }

    public fun delete_metadata(arg0: Metadata, arg1: &mut 0x2::tx_context::TxContext) {
        let Metadata {
            id             : v0,
            request_sender : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun executed_i_ack_dapp(arg0: &mut GatewayContract, arg1: ExecuteDappIAck, arg2: vector<u8>, arg3: bool) {
        let ExecuteDappIAck {
            id                     : v0,
            request_identifier     : v1,
            ack_request_identifier : v2,
            dest_chain_id          : v3,
            dapp_object_id         : _,
            dapp_module_address    : _,
            exec_data              : _,
            exec_flag              : _,
            relayer_router_address : v8,
        } = arg1;
        let v9 = v3;
        let v10 = v2;
        is_nonce_executed(arg0, v9, v10);
        is_ack_nonce_executed(arg0, v1);
        0x2::object::delete(v0);
        0x2::table::add<vector<u8>, bool>(&mut arg0.nonce_executed, get_nonce_executed_key(&v9, &v10), true);
        0x2::table::add<u256, bool>(&mut arg0.ack_nonce_executed, v1, true);
        arg0.event_nonce = arg0.event_nonce + 1;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_i_ack_event(v10, v9, arg0.event_nonce, v1, v8, arg0.chain_id, arg2, arg3);
    }

    public fun executed_i_receive_dapp(arg0: &mut GatewayContract, arg1: ExecuteDappIReceive, arg2: vector<u8>, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let ExecuteDappIReceive {
            id                     : v0,
            route_amount           : v1,
            request_identifier     : v2,
            request_timestamp      : _,
            src_chain_id           : v4,
            route_recipient        : v5,
            dest_chain_id          : v6,
            request_sender         : v7,
            dapp_object_id         : _,
            dapp_module_address    : _,
            packet                 : _,
            is_read_call           : _,
            relayer_router_address : v12,
        } = arg1;
        let v13 = v4;
        let v14 = v2;
        is_nonce_executed(arg0, v13, v14);
        0x2::object::delete(v0);
        if (v1 > 0) {
            0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::mint(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&mut arg0.route_treasury_cap), v5, (v1 as u64), arg4);
        };
        0x2::table::add<vector<u8>, bool>(&mut arg0.nonce_executed, get_nonce_executed_key(&v13, &v14), true);
        arg0.event_nonce = arg0.event_nonce + 1;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_i_receive_event(v14, arg0.event_nonce, v13, v6, v12, v7, arg2, arg3);
    }

    public entry fun get_ack_nonce_status(arg0: &GatewayContract, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.ack_nonce_executed, arg1)
    }

    public entry fun get_balance(arg0: &GatewayContract) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public entry fun get_chain_id(arg0: &GatewayContract) : 0x1::string::String {
        arg0.chain_id
    }

    public entry fun get_event_nonce(arg0: &GatewayContract) : u256 {
        arg0.event_nonce
    }

    public fun get_i_ack_args(arg0: &ExecuteDappIAck) : (u256, bool, vector<u8>) {
        (arg0.request_identifier, arg0.exec_flag, arg0.exec_data)
    }

    public fun get_i_receive_args(arg0: &ExecuteDappIReceive) : (0x1::string::String, vector<u8>, 0x1::string::String) {
        (arg0.request_sender, arg0.packet, arg0.src_chain_id)
    }

    public entry fun get_isend_defauft_fee(arg0: &GatewayContract) : u64 {
        arg0.isend_defauft_fee
    }

    public entry fun get_last_valset_checkpoint(arg0: &GatewayContract) : vector<u8> {
        arg0.last_valset_checkpoint
    }

    fun get_nonce_executed_key(arg0: &0x1::string::String, arg1: &u256) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<0x1::string::String>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u256>(arg1));
        v0
    }

    public entry fun get_nonce_status(arg0: &GatewayContract, arg1: 0x1::string::String, arg2: u256) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.nonce_executed, get_nonce_executed_key(&arg1, &arg2))
    }

    public entry fun get_pause(arg0: &GatewayContract) : bool {
        arg0.paused
    }

    public fun get_verify_cross_chain_request_args(arg0: &ValidateAsm) : (u256, u256, 0x1::string::String, 0x1::string::String, vector<u8>, address, address) {
        (arg0.request_identifier, arg0.request_timestamp, arg0.request_sender, arg0.src_chain_id, arg0.packet, arg0.dapp_module_address, arg0.dapp_object_id)
    }

    public entry fun grant_role(arg0: &mut AdminCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg1 == 0) {
            let v0 = AdminCap{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<AdminCap>(v0, arg2);
        } else if (arg1 == 1) {
            let v1 = ResourceSetterCap{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<ResourceSetterCap>(v1, arg2);
        } else {
            assert!(arg1 == 2, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_unknown_role());
            let v2 = PauseCap{id: 0x2::object::new(arg3)};
            0x2::transfer::public_transfer<PauseCap>(v2, arg2);
        };
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_grant_role_event(arg1, arg2);
    }

    public fun i_send(arg0: &mut GatewayContract, arg1: &mut Metadata, arg2: u128, arg3: u256, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg9: &mut 0x1::option::Option<0x2::coin::Coin<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>, arg10: &mut 0x2::tx_context::TxContext) : u256 {
        assert!(0x1::vector::length<u8>(&arg1.request_sender) != 0, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_metadata_not_set());
        when_not_paused(arg0);
        valid_fee_sent(arg0, arg8);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(arg8) && arg0.isend_defauft_fee > 0) {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(0x1::option::borrow_mut<0x2::coin::Coin<0x2::sui::SUI>>(arg8), arg0.isend_defauft_fee, arg10));
        };
        if (arg3 > 0) {
            0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::burn(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&mut arg0.route_treasury_cap), 0x1::option::borrow_mut<0x2::coin::Coin<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(arg9), (arg3 as u64), arg10);
        };
        arg0.event_nonce = arg0.event_nonce + 1;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_i_send_event(arg2, arg3, arg0.event_nonce, arg1.request_sender, arg0.chain_id, arg5, arg4, arg6, arg7);
        arg0.event_nonce
    }

    fun init(arg0: GATEWAY_CONTRACT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GatewayContract{
            id                     : 0x2::object::new(arg1),
            current_version        : 0,
            chain_id               : 0x1::string::utf8(b""),
            event_nonce            : 0,
            last_valset_nonce      : 0,
            isend_defauft_fee      : 0,
            last_valset_checkpoint : x"0000000000000000000000000000000000000000000000000000000000000000",
            nonce_executed         : 0x2::table::new<vector<u8>, bool>(arg1),
            ack_nonce_executed     : 0x2::table::new<u256, bool>(arg1),
            paused                 : false,
            initialized            : false,
            balance                : 0x2::balance::zero<0x2::sui::SUI>(),
            route_treasury_cap     : 0x1::option::none<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(),
        };
        let v1 = ResourceSetterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<ResourceSetterCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = PauseCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<PauseCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<GatewayContract>(v0);
    }

    public entry fun initialize(arg0: &mut GatewayContract, arg1: &mut AdminCap, arg2: 0x1::string::String, arg3: vector<vector<u8>>, arg4: vector<u64>, arg5: u256, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.initialized, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_already_initialized());
        arg0.isend_defauft_fee = arg6;
        arg0.initialized = true;
        arg0.chain_id = arg2;
        let v0 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::create_valset_args(arg3, arg4, arg5);
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::validate_power(&v0);
        arg0.last_valset_checkpoint = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::make_checkpoint(&v0);
        arg0.last_valset_nonce = arg5;
        arg0.event_nonce = arg0.event_nonce + 1;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_valset_update_event(arg0.event_nonce, arg0.chain_id, &v0);
    }

    fun is_ack_nonce_executed(arg0: &GatewayContract, arg1: u256) {
        assert!(!get_ack_nonce_status(arg0, arg1), 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_already_executed());
    }

    fun is_nonce_executed(arg0: &GatewayContract, arg1: 0x1::string::String, arg2: u256) {
        assert!(!get_nonce_status(arg0, arg1, arg2), 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_already_executed());
    }

    public fun new_metadata(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Metadata{
            id             : 0x2::object::new(arg1),
            request_sender : 0x1::vector::empty<u8>(),
        };
        0x2::transfer::public_transfer<Metadata>(v0, arg0);
    }

    public entry fun pause(arg0: &mut GatewayContract, arg1: &mut PauseCap, arg2: &0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        arg0.paused = true;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_paused_event();
    }

    public entry fun renounce_admin_cap(arg0: AdminCap, arg1: &0x2::tx_context::TxContext) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_renounce_role_event(0);
    }

    public entry fun renounce_pause_cap(arg0: PauseCap, arg1: &0x2::tx_context::TxContext) {
        let PauseCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_renounce_role_event(2);
    }

    public entry fun renounce_resource_setter_cap(arg0: ResourceSetterCap, arg1: &0x2::tx_context::TxContext) {
        let ResourceSetterCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_renounce_role_event(1);
    }

    public entry fun rescue_fee(arg0: &mut GatewayContract, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= arg2, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_insufficient_balance());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun revoke_pause_role(arg0: &mut AdminCap, arg1: PauseCap, arg2: &mut 0x2::tx_context::TxContext) {
        let PauseCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun revoke_resource_setter_role(arg0: &mut AdminCap, arg1: ResourceSetterCap, arg2: &mut 0x2::tx_context::TxContext) {
        let ResourceSetterCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun set_chain_id(arg0: &mut GatewayContract, arg1: &mut ResourceSetterCap, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        arg0.chain_id = arg2;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_set_chain_id_event(arg2);
    }

    public fun set_dapp_metadata(arg0: &mut GatewayContract, arg1: &mut Metadata, arg2: address, arg3: address, arg4: 0x1::string::String, arg5: &mut 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        valid_fee_sent(arg0, arg5);
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(arg5) && arg0.isend_defauft_fee > 0) {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(0x1::option::borrow_mut<0x2::coin::Coin<0x2::sui::SUI>>(arg5), arg0.isend_defauft_fee, arg6));
        };
        arg0.event_nonce = arg0.event_nonce + 1;
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg3));
        arg1.request_sender = v0;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_set_dapp_metadata_event(arg0.event_nonce, v0, arg0.chain_id, arg4);
    }

    public entry fun set_isend_fee(arg0: &mut GatewayContract, arg1: &mut ResourceSetterCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg0.isend_defauft_fee = arg2;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_bridge_fee_updated_event(arg0.isend_defauft_fee, arg2);
    }

    public entry fun set_route_treasury_cap(arg0: &mut GatewayContract, arg1: &mut ResourceSetterCap, arg2: 0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>, arg3: &0x2::tx_context::TxContext) {
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_set_route_treasury_event(0x2::object::id_address<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&arg2));
        if (0x1::option::is_some<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&arg0.route_treasury_cap)) {
            let v0 = 0x1::option::swap<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&mut arg0.route_treasury_cap, arg2);
            0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_trasfer_route_treasury_event(0x2::object::id_address<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&v0), 0x2::tx_context::sender(arg3));
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x1::option::fill<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&mut arg0.route_treasury_cap, arg2);
        };
    }

    public entry fun set_version(arg0: &mut GatewayContract, arg1: &mut ResourceSetterCap, arg2: u128, arg3: &0x2::tx_context::TxContext) {
        arg0.current_version = arg2;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_set_version_event(arg0.current_version);
    }

    public entry fun take_route_treasury_cap(arg0: &mut GatewayContract, arg1: address, arg2: &mut ResourceSetterCap, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&arg0.route_treasury_cap), 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_route_treasury_cap());
        let v0 = 0x1::option::extract<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&mut arg0.route_treasury_cap);
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_trasfer_route_treasury_event(0x2::object::id_address<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&v0), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(v0, arg1);
    }

    public entry fun unpause(arg0: &mut GatewayContract, arg1: &mut PauseCap, arg2: &0x2::tx_context::TxContext) {
        when_paused(arg0);
        arg0.paused = false;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_unpaused_event();
    }

    public entry fun update_valset(arg0: &mut GatewayContract, arg1: vector<vector<u8>>, arg2: vector<u64>, arg3: u256, arg4: vector<vector<u8>>, arg5: vector<u64>, arg6: u256, arg7: vector<vector<u8>>, arg8: &0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        let v0 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::create_valset_args(arg1, arg2, arg3);
        let v1 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::create_valset_args(arg4, arg5, arg6);
        assert!(arg3 > arg6, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_invalid_valset_nonce());
        assert!(arg3 <= arg6 + 1000000, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_invalid_valset_nonce());
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::validate_power(&v0);
        assert!(0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::make_checkpoint(&v1) == arg0.last_valset_checkpoint, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_incorrect_checkpoint());
        let v2 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::make_checkpoint(&v0);
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::check_validator_signatures(&v1, &arg7, &v2);
        arg0.last_valset_checkpoint = v2;
        arg0.last_valset_nonce = arg3;
        arg0.event_nonce = arg0.event_nonce + 1;
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_valset_update_event(arg0.event_nonce, arg0.chain_id, &v0);
    }

    fun valid_fee_sent(arg0: &GatewayContract, arg1: &0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>) {
        let v0 = 0;
        if (0x1::option::is_some<0x2::coin::Coin<0x2::sui::SUI>>(arg1)) {
            v0 = 0x2::coin::value<0x2::sui::SUI>(0x1::option::borrow<0x2::coin::Coin<0x2::sui::SUI>>(arg1));
        };
        assert!(v0 >= arg0.isend_defauft_fee, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_invalid_fee());
    }

    public fun validate_asm(arg0: &mut GatewayContract, arg1: ValidateAsm, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let ValidateAsm {
            id                     : v0,
            route_amount           : v1,
            request_identifier     : v2,
            request_timestamp      : v3,
            src_chain_id           : v4,
            route_recipient        : v5,
            dest_chain_id          : v6,
            request_sender         : v7,
            dapp_object_id         : v8,
            dapp_module_address    : v9,
            asm_object_id          : _,
            asm_module_address     : _,
            packet                 : v12,
            is_read_call           : v13,
            relayer_router_address : v14,
        } = arg1;
        let v15 = v4;
        let v16 = v2;
        is_nonce_executed(arg0, v15, v16);
        0x2::object::delete(v0);
        if (arg2) {
            let v17 = ExecuteDappIReceive{
                id                     : 0x2::object::new(arg3),
                route_amount           : v1,
                request_identifier     : v16,
                request_timestamp      : v3,
                src_chain_id           : v15,
                route_recipient        : v5,
                dest_chain_id          : v6,
                request_sender         : v7,
                dapp_object_id         : v8,
                dapp_module_address    : v9,
                packet                 : v12,
                is_read_call           : v13,
                relayer_router_address : v14,
            };
            0x2::transfer::public_transfer<ExecuteDappIReceive>(v17, v8);
        } else {
            0x2::table::add<vector<u8>, bool>(&mut arg0.nonce_executed, get_nonce_executed_key(&v15, &v16), true);
            arg0.event_nonce = arg0.event_nonce + 1;
            0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_i_receive_event(v16, arg0.event_nonce, v15, v6, v14, v7, b"", false);
        };
    }

    public fun validate_i_ack(arg0: &mut GatewayContract, arg1: vector<vector<u8>>, arg2: vector<u64>, arg3: u256, arg4: vector<vector<u8>>, arg5: u256, arg6: u256, arg7: 0x1::string::String, arg8: vector<u8>, arg9: vector<u8>, arg10: bool, arg11: 0x1::string::String, arg12: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        is_nonce_executed(arg0, arg7, arg6);
        is_ack_nonce_executed(arg0, arg5);
        let v0 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::create_valset_args(arg1, arg2, arg3);
        assert!(0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::make_checkpoint(&v0) == arg0.last_valset_checkpoint, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_incorrect_checkpoint());
        let v1 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::helper::get_i_ack_msg_hash(&arg5, &arg6, &arg7, &arg8, &arg9, &arg10, &arg0.chain_id);
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::check_validator_signatures(&v0, &arg4, &v1);
        if (0x1::vector::length<u8>(&arg8) != 64) {
            0x2::table::add<vector<u8>, bool>(&mut arg0.nonce_executed, get_nonce_executed_key(&arg7, &arg6), true);
            0x2::table::add<u256, bool>(&mut arg0.ack_nonce_executed, arg5, true);
            arg0.event_nonce = arg0.event_nonce + 1;
            0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_i_ack_event(arg6, arg7, arg0.event_nonce, arg5, arg11, arg0.chain_id, b"", false);
            return
        };
        let (v2, v3) = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::helper::get_handler_info(&arg8);
        let v4 = ExecuteDappIAck{
            id                     : 0x2::object::new(arg12),
            request_identifier     : arg5,
            ack_request_identifier : arg6,
            dest_chain_id          : arg7,
            dapp_object_id         : v3,
            dapp_module_address    : v2,
            exec_data              : arg9,
            exec_flag              : arg10,
            relayer_router_address : arg11,
        };
        0x2::transfer::public_transfer<ExecuteDappIAck>(v4, v3);
    }

    public entry fun validate_i_receive(arg0: &mut GatewayContract, arg1: vector<vector<u8>>, arg2: vector<u64>, arg3: u256, arg4: vector<vector<u8>>, arg5: u256, arg6: u256, arg7: u256, arg8: 0x1::string::String, arg9: address, arg10: 0x1::string::String, arg11: vector<u8>, arg12: 0x1::string::String, arg13: vector<u8>, arg14: vector<u8>, arg15: bool, arg16: 0x1::string::String, arg17: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg0);
        is_nonce_executed(arg0, arg8, arg6);
        assert!(arg10 == arg0.chain_id, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_invalid_dst_chain_id());
        let v0 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::types::create_valset_args(arg1, arg2, arg3);
        assert!(0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::make_checkpoint(&v0) == arg0.last_valset_checkpoint, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_incorrect_checkpoint());
        let v1 = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::helper::get_i_receive_msg_hash(&arg5, &arg6, &arg7, &arg8, &arg9, &arg10, &arg11, &arg12, &arg13, &arg14, &arg15);
        0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::valset_update::check_validator_signatures(&v0, &arg4, &v1);
        let v2 = 0x1::vector::length<u8>(&arg11);
        if (0x1::vector::length<u8>(&arg13) != 64 || v2 > 0 && v2 != 64) {
            if (arg5 > 0) {
                0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::mint(0x1::option::borrow_mut<0x2::coin::TreasuryCap<0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::route::ROUTE>>(&mut arg0.route_treasury_cap), arg9, (arg5 as u64), arg17);
            };
            0x2::table::add<vector<u8>, bool>(&mut arg0.nonce_executed, get_nonce_executed_key(&arg10, &arg6), true);
            arg0.event_nonce = arg0.event_nonce + 1;
            0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::events::emit_i_receive_event(arg6, arg0.event_nonce, arg8, arg10, arg16, arg12, b"", false);
            return
        };
        let (v3, v4) = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::helper::get_handler_info(&arg13);
        if (v2 > 0) {
            let (v5, v6) = 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::helper::get_handler_info(&arg13);
            let v7 = ValidateAsm{
                id                     : 0x2::object::new(arg17),
                route_amount           : arg5,
                request_identifier     : arg6,
                request_timestamp      : arg7,
                src_chain_id           : arg8,
                route_recipient        : arg9,
                dest_chain_id          : arg10,
                request_sender         : arg12,
                dapp_object_id         : v4,
                dapp_module_address    : v3,
                asm_object_id          : v6,
                asm_module_address     : v5,
                packet                 : arg14,
                is_read_call           : arg15,
                relayer_router_address : arg16,
            };
            0x2::transfer::public_transfer<ValidateAsm>(v7, v6);
            return
        };
        let v8 = ExecuteDappIReceive{
            id                     : 0x2::object::new(arg17),
            route_amount           : arg5,
            request_identifier     : arg6,
            request_timestamp      : arg7,
            src_chain_id           : arg8,
            route_recipient        : arg9,
            dest_chain_id          : arg10,
            request_sender         : arg12,
            dapp_object_id         : v4,
            dapp_module_address    : v3,
            packet                 : arg14,
            is_read_call           : arg15,
            relayer_router_address : arg16,
        };
        0x2::transfer::public_transfer<ExecuteDappIReceive>(v8, v4);
    }

    fun when_not_paused(arg0: &GatewayContract) {
        assert!(!arg0.paused, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_paused());
    }

    fun when_paused(arg0: &GatewayContract) {
        assert!(arg0.paused, 0x9750d6d46b57a61173750522d11abe72c1f649f653235b8e9eeb26427080d0d2::errors::err_not_paused());
    }

    // decompiled from Move bytecode v6
}

