module 0x3e3eb38f8b6ead403622e74be26e9a3acf198157843c69354b56a97f4dca74ec::cetus_staking {
    struct TokenRegistry has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct TokenBox has store, key {
        id: 0x2::object::UID,
        owner: address,
        lp_token: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position,
    }

    struct StakeProof has store, key {
        id: 0x2::object::UID,
        box_id: 0x2::object::ID,
    }

    struct StakeEvent has copy, drop {
        registry_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        lp_token_id: 0x2::object::ID,
        timestamp: u64,
        liquidity: u128,
    }

    struct UnstakeEvent has copy, drop {
        lp_token_id: 0x2::object::ID,
        timestamp: u64,
    }

    public entry fun create_registry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<TokenRegistry>(new_registry(arg0, arg1));
    }

    public fun new_registry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : TokenRegistry {
        TokenRegistry{
            id      : 0x2::object::new(arg1),
            pool_id : 0x2::object::id_from_address(arg0),
        }
    }

    public fun stake(arg0: &0x2::clock::Clock, arg1: &mut TokenRegistry, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::tx_context::TxContext) : StakeProof {
        assert!(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&arg2) == arg1.pool_id, 0);
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = TokenBox{
            id       : v0,
            owner    : 0x2::tx_context::sender(arg3),
            lp_token : arg2,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, TokenBox>(&mut arg1.id, v1, v2);
        let v3 = StakeEvent{
            registry_id : 0x2::object::id<TokenRegistry>(arg1),
            pool_id     : arg1.pool_id,
            lp_token_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg2),
            timestamp   : 0x2::clock::timestamp_ms(arg0),
            liquidity   : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(&arg2),
        };
        0x2::event::emit<StakeEvent>(v3);
        StakeProof{
            id     : 0x2::object::new(arg3),
            box_id : v1,
        }
    }

    public entry fun stake_and_get_proof(arg0: &0x2::clock::Clock, arg1: &mut TokenRegistry, arg2: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = stake(arg0, arg1, arg2, arg3);
        0x2::transfer::transfer<StakeProof>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun unstake(arg0: &0x2::clock::Clock, arg1: &mut TokenRegistry, arg2: StakeProof) : 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position {
        let StakeProof {
            id     : v0,
            box_id : v1,
        } = arg2;
        0x2::object::delete(v0);
        assert!(0x2::dynamic_object_field::exists_with_type<0x2::object::ID, TokenBox>(&arg1.id, v1), 1);
        let TokenBox {
            id       : v2,
            owner    : _,
            lp_token : v4,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, TokenBox>(&mut arg1.id, v1);
        let v5 = v4;
        0x2::object::delete(v2);
        let v6 = UnstakeEvent{
            lp_token_id : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&v5),
            timestamp   : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<UnstakeEvent>(v6);
        v5
    }

    public entry fun unstake_and_get_token(arg0: &0x2::clock::Clock, arg1: &mut TokenRegistry, arg2: StakeProof, arg3: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(unstake(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

