module 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::intent_filler {
    struct FillCreated has copy, drop {
        fill_hash: vector<u8>,
        filler: address,
        amount: u128,
    }

    struct FillCancelled has copy, drop {
        fill_hash: vector<u8>,
        filler: address,
        amount: u128,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        publisher: 0x2::package::Publisher,
        hub_intents: vector<u8>,
        hub_chain_id: u256,
        fills: 0x2::table::Table<vector<u8>, address>,
        escrow: 0x2::bag::Bag,
        latest_package_id: 0x1::string::String,
    }

    struct INTENT_FILLER has drop {
        dummy_field: bool,
    }

    struct Params has drop {
        type_args: vector<0x1::string::String>,
        args: vector<0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun cancel_fill<T0>(arg0: &mut Config, arg1: u256, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0, 2);
        let v0 = get_type_string<T0>();
        assert!(0x1::string::as_bytes(&v0) == &arg5, 5);
        let v1 = 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::new(arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::encode(&v1);
        let v3 = 0x2::hash::keccak256(&v2);
        assert!(0x2::table::contains<vector<u8>, address>(&arg0.fills, v3), 1);
        let v4 = 0x2::table::remove<vector<u8>, address>(&mut arg0.fills, v3);
        assert!(v4 == 0x2::tx_context::sender(arg7), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.escrow, v3), v4);
        let v5 = FillCancelled{
            fill_hash : v3,
            filler    : v4,
            amount    : arg6,
        };
        0x2::event::emit<FillCancelled>(v5);
    }

    entry fun configure(arg0: &mut Config, arg1: vector<u8>, arg2: u256, arg3: &AdminCap) {
        enforce_version(arg0, 2);
        arg0.hub_chain_id = arg2;
        arg0.hub_intents = arg1;
    }

    public(friend) fun enforce_version(arg0: &Config, arg1: u64) {
        assert!(arg0.version == arg1, 6);
    }

    public entry fun fill_intent<T0>(arg0: &mut Config, arg1: u256, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u128, arg7: 0x2::coin::Coin<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        enforce_version(arg0, 2);
        assert!(arg6 > 0, 4);
        assert!((0x2::coin::value<T0>(&arg7) as u128) == arg6, 4);
        let v0 = get_type_string<T0>();
        assert!(0x1::string::as_bytes(&v0) == &arg5, 5);
        let v1 = 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::new(arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::encode(&v1);
        let v3 = 0x2::hash::keccak256(&v2);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg0.fills, v3), 0);
        0x2::table::add<vector<u8>, address>(&mut arg0.fills, v3, 0x2::tx_context::sender(arg8));
        0x2::bag::add<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.escrow, v3, arg7);
        let v4 = FillCreated{
            fill_hash : v3,
            filler    : 0x2::tx_context::sender(arg8),
            amount    : arg6,
        };
        0x2::event::emit<FillCreated>(v4);
    }

    public fun get_fill(arg0: &Config, arg1: vector<u8>) : address {
        enforce_version(arg0, 2);
        *0x2::table::borrow<vector<u8>, address>(&arg0.fills, arg1)
    }

    public fun get_fill_fund<T0>(arg0: &Config, arg1: vector<u8>) : u64 {
        enforce_version(arg0, 2);
        if (0x2::bag::contains<vector<u8>>(&arg0.escrow, arg1)) {
            return 0x2::coin::value<T0>(0x2::bag::borrow<vector<u8>, 0x2::coin::Coin<T0>>(&arg0.escrow, arg1))
        };
        0
    }

    public fun get_hub_chain_id(arg0: &Config) : u256 {
        enforce_version(arg0, 2);
        arg0.hub_chain_id
    }

    public fun get_hub_intent(arg0: &Config) : vector<u8> {
        enforce_version(arg0, 2);
        arg0.hub_intents
    }

    entry fun get_recv_message_args(arg0: &Config, arg1: vector<u8>) : Params {
        enforce_version(arg0, 2);
        let v0 = 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::decode(&arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::token(&v0)));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v2, id_to_hex_string(0x2::object::uid_as_inner(&arg0.id)));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"connection"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"src_chain_id"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"src_address"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"conn_sn"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"payload"));
        0x1::vector::push_back<0x1::string::String>(&mut v2, 0x1::string::utf8(b"signatures"));
        Params{
            type_args : v1,
            args      : v2,
        }
    }

    public fun get_type_string<T0>() : 0x1::string::String {
        to_hex_string(0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun id_to_hex_string(arg0: &0x2::object::ID) : 0x1::string::String {
        to_hex_string(0x1::string::utf8(0x2::hex::encode(0x2::object::id_to_bytes(arg0))))
    }

    fun init(arg0: INTENT_FILLER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<INTENT_FILLER>(arg0, arg1);
        let v1 = Config{
            id                : 0x2::object::new(arg1),
            version           : 2,
            publisher         : v0,
            hub_intents       : 0x1::vector::empty<u8>(),
            hub_chain_id      : 0,
            fills             : 0x2::table::new<vector<u8>, address>(arg1),
            escrow            : 0x2::bag::new(arg1),
            latest_package_id : 0x1::string::from_ascii(*0x2::package::published_package(&v0)),
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    fun process_message<T0>(arg0: &mut Config, arg1: vector<u8>) : 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill_response::FillResponse {
        let v0 = 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::decode(&arg1);
        let v1 = 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::encode(&v0);
        let v2 = 0x2::hash::keccak256(&v1);
        let v3 = 0x2::table::contains<vector<u8>, address>(&arg0.fills, v2);
        let v4 = get_type_string<T0>();
        let v5 = 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::token(&v0);
        assert!(0x1::string::as_bytes(&v4) == &v5, 5);
        if (v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::bag::remove<vector<u8>, 0x2::coin::Coin<T0>>(&mut arg0.escrow, v2), 0x2::address::from_bytes(0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::receiver(&v0)));
            0x2::table::remove<vector<u8>, address>(&mut arg0.fills, v2);
        };
        0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill_response::new(0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill::fill_id(&v0), v3)
    }

    public entry fun recv_message<T0>(arg0: &mut Config, arg1: &mut 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::State, arg2: u256, arg3: vector<u8>, arg4: u256, arg5: vector<u8>, arg6: vector<vector<u8>>) {
        enforce_version(arg0, 2);
        validate_source(arg0, arg2, arg3);
        0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::verify_message(arg1, 0x2::object::id<Config>(arg0), &arg0.publisher, arg2, arg3, arg4, arg5, arg6);
        let v0 = process_message<T0>(arg0, arg5);
        0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3::send_message(arg1, 0x2::object::uid_to_inner(&arg0.id), &arg0.publisher, arg0.hub_chain_id, arg0.hub_intents, 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill_response::encode(&v0));
    }

    public fun to_hex_string(arg0: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, arg0);
        v0
    }

    fun validate_source(arg0: &Config, arg1: u256, arg2: vector<u8>) {
        assert!(arg1 == arg0.hub_chain_id, 3);
        assert!(arg2 == arg0.hub_intents, 3);
    }

    // decompiled from Move bytecode v6
}

