module 0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::asset_manager {
    struct ASSET_MANAGER has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        latest_package_id: 0x1::string::String,
        hub_nid: u256,
        hub_asset_manager: vector<u8>,
        token_deposits: 0x2::object_bag::ObjectBag,
        owner: address,
        publisher: 0x2::package::Publisher,
        rate_limit_state_id: 0x1::string::String,
    }

    struct Params has drop {
        type_args: vector<0x1::string::String>,
        args: vector<0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun transfer<T0>(arg0: &mut Config, arg1: &mut 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::State, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) {
        enforce_version(arg0, 2);
        let v0 = get_type_string<T0>();
        let v1 = 0x2::tx_context::sender(arg5);
        if (0x2::object_bag::contains<0x1::string::String>(&arg0.token_deposits, v0)) {
            0x2::coin::join<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.token_deposits, v0), arg2);
        } else {
            0x2::object_bag::add<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.token_deposits, v0, arg2);
        };
        0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::send_message(arg1, 0x2::object::id<Config>(arg0), &arg0.publisher, arg0.hub_nid, hub_asset_manager(arg0), 0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::transfer_msg::encode(0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::transfer_msg::new(*0x1::string::as_bytes(&v0), 0x1::bcs::to_bytes<address>(&v1), arg3, 0x2::coin::value<T0>(&arg2), arg4)));
    }

    entry fun configure(arg0: &mut Config, arg1: u256, arg2: vector<u8>, arg3: 0x1::string::String, arg4: &AdminCap) {
        enforce_version(arg0, 2);
        arg0.hub_nid = arg1;
        arg0.hub_asset_manager = arg2;
        arg0.rate_limit_state_id = arg3;
    }

    public(friend) fun enforce_version(arg0: &Config, arg1: u64) {
        assert!(arg0.version == arg1, 3);
    }

    entry fun get_recv_message_args(arg0: &Config, arg1: vector<u8>) : Params {
        enforce_version(arg0, 2);
        let v0 = 0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::transfer_msg::decode(&arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::transfer_msg::token(&v0)));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v2, id_to_hex_string(0x2::object::uid_as_inner(&arg0.id)));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"connection"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, arg0.rate_limit_state_id);
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"src_chain_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"src_address"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"conn_sn"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"payload"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"signatures"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"clock"));
        Params{
            type_args : v1,
            args      : v2,
        }
    }

    public fun get_token_balance<T0>(arg0: &Config) : u64 {
        if (0x2::object_bag::contains<0x1::string::String>(&arg0.token_deposits, get_type_string<T0>())) {
            0x2::coin::value<T0>(0x2::object_bag::borrow<0x1::string::String, 0x2::coin::Coin<T0>>(&arg0.token_deposits, get_type_string<T0>()))
        } else {
            0
        }
    }

    public fun get_type_string<T0>() : 0x1::string::String {
        to_hex_string(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun hub_asset_manager(arg0: &Config) : vector<u8> {
        arg0.hub_asset_manager
    }

    public fun hub_network_id(arg0: &Config) : u256 {
        arg0.hub_nid
    }

    public fun id_to_hex_string(arg0: &0x2::object::ID) : 0x1::string::String {
        to_hex_string(0x1::string::utf8(0x2::hex::encode(0x2::object::id_to_bytes(arg0))))
    }

    fun init(arg0: ASSET_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ASSET_MANAGER>(arg0, arg1);
        let v1 = Config{
            id                  : 0x2::object::new(arg1),
            version             : 2,
            latest_package_id   : 0x1::string::from_ascii(*0x2::package::published_package(&v0)),
            hub_nid             : 0,
            hub_asset_manager   : 0x1::vector::empty<u8>(),
            token_deposits      : 0x2::object_bag::new(arg1),
            owner               : 0x2::tx_context::sender(arg1),
            publisher           : v0,
            rate_limit_state_id : 0x1::string::utf8(b""),
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    entry fun migrate(arg0: &mut Config, arg1: 0x1::string::String, arg2: &0x2::package::UpgradeCap) {
        assert!(arg0.version < 2, 2);
        arg0.version = 2;
        arg0.latest_package_id = arg1;
    }

    entry fun recv_message<T0>(arg0: &mut Config, arg1: &mut 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::State, arg2: &mut 0xf796d36fada0fedbc2c1a3b31980fdc9028faea6f3750ec7819d15e991995a0e::rate_limits::RateLimitState, arg3: u256, arg4: vector<u8>, arg5: u256, arg6: vector<u8>, arg7: vector<vector<u8>>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0, 2);
        assert!(arg4 == hub_asset_manager(arg0), 1);
        assert!(arg3 == hub_network_id(arg0), 1);
        let v0 = 0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::transfer_msg::decode(&arg6);
        let v1 = 0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::transfer_msg::amount(&v0);
        let v2 = 0x1::string::utf8(0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::transfer_msg::token(&v0));
        0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::verify_message(arg1, 0x2::object::id<Config>(arg0), &arg0.publisher, arg3, arg4, arg5, arg6, arg7);
        0xf796d36fada0fedbc2c1a3b31980fdc9028faea6f3750ec7819d15e991995a0e::rate_limits::verify_withdraw<T0>(arg2, 0x2::coin::balance<T0>(0x2::object_bag::borrow<0x1::string::String, 0x2::coin::Coin<T0>>(&arg0.token_deposits, v2)), arg8, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::object_bag::borrow_mut<0x1::string::String, 0x2::coin::Coin<T0>>(&mut arg0.token_deposits, v2), v1, arg9), 0x2::address::from_bytes(0xa17a409164d1676db71b411ab50813ba2c7dd547d2df538c699049566f1ff922::transfer_msg::to(&v0)));
    }

    entry fun set_hub_details(arg0: &mut Config, arg1: u256, arg2: vector<u8>, arg3: &AdminCap) {
        enforce_version(arg0, 2);
        arg0.hub_nid = arg1;
        arg0.hub_asset_manager = arg2;
    }

    entry fun set_rate_limit_id(arg0: &mut Config, arg1: 0x1::string::String, arg2: &AdminCap) {
        enforce_version(arg0, 2);
        arg0.rate_limit_state_id = arg1;
    }

    public fun to_hex_string(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, arg0);
        v0
    }

    // decompiled from Move bytecode v6
}

