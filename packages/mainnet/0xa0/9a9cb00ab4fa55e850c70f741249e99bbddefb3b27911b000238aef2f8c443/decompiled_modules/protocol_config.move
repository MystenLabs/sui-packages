module 0xa09a9cb00ab4fa55e850c70f741249e99bbddefb3b27911b000238aef2f8c443::protocol_config {
    struct Guardian has store, key {
        id: 0x2::object::UID,
    }

    struct ProtocolConfig has key {
        id: 0x2::object::UID,
        protocol_fee_bps: u64,
        coins: 0x2::vec_set::VecSet<0x1::ascii::String>,
        price_feed_ids: 0x2::vec_map::VecMap<0x1::ascii::String, 0x2::object::ID>,
    }

    struct ProtocolFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    struct TokenAdded has copy, drop {
        token_type: 0x1::ascii::String,
        price_feed_id: 0x2::object::ID,
    }

    struct TokenRemoved has copy, drop {
        token_type: 0x1::ascii::String,
    }

    public fun add_token<T0>(arg0: &mut ProtocolConfig, arg1: &Guardian, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(!0x2::vec_set::contains<0x1::ascii::String>(&arg0.coins, &v0), 4);
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.coins, v0);
        0x2::vec_map::insert<0x1::ascii::String, 0x2::object::ID>(&mut arg0.price_feed_ids, v0, arg2);
        let v1 = TokenAdded{
            token_type    : v0,
            price_feed_id : arg2,
        };
        0x2::event::emit<TokenAdded>(v1);
    }

    public fun get_allowed_tokens(arg0: &ProtocolConfig) : &0x2::vec_set::VecSet<0x1::ascii::String> {
        &arg0.coins
    }

    public fun get_price_feed_id(arg0: &ProtocolConfig, arg1: &0x1::ascii::String) : 0x2::object::ID {
        *0x2::vec_map::get<0x1::ascii::String, 0x2::object::ID>(&arg0.price_feed_ids, arg1)
    }

    public fun get_protocol_fee(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProtocolConfig{
            id               : 0x2::object::new(arg0),
            protocol_fee_bps : 10,
            coins            : 0x2::vec_set::empty<0x1::ascii::String>(),
            price_feed_ids   : 0x2::vec_map::empty<0x1::ascii::String, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<ProtocolConfig>(v0);
        let v1 = Guardian{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Guardian>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_token_allowed(arg0: &ProtocolConfig, arg1: &0x1::ascii::String) : bool {
        0x2::vec_set::contains<0x1::ascii::String>(&arg0.coins, arg1)
    }

    public fun remove_token<T0>(arg0: &mut ProtocolConfig, arg1: &Guardian, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        assert!(0x2::vec_set::contains<0x1::ascii::String>(&arg0.coins, &v0), 5);
        0x2::vec_set::remove<0x1::ascii::String>(&mut arg0.coins, &v0);
        let (_, _) = 0x2::vec_map::remove<0x1::ascii::String, 0x2::object::ID>(&mut arg0.price_feed_ids, &v0);
        let v3 = TokenRemoved{token_type: v0};
        0x2::event::emit<TokenRemoved>(v3);
    }

    public fun update_protocol_fee(arg0: &mut ProtocolConfig, arg1: &Guardian, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 50, 1);
        arg0.protocol_fee_bps = arg2;
        let v0 = ProtocolFeeUpdated{
            old_fee : arg0.protocol_fee_bps,
            new_fee : arg2,
        };
        0x2::event::emit<ProtocolFeeUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

