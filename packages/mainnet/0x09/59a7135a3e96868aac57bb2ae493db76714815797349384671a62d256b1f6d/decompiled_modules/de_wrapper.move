module 0x959a7135a3e96868aac57bb2ae493db76714815797349384671a62d256b1f6d::de_wrapper {
    struct New<phantom T0, phantom T1> has copy, drop {
        de_wrapper_id: 0x2::object::ID,
    }

    struct Wrap<phantom T0, phantom T1> has copy, drop {
        de_wrapper_id: 0x2::object::ID,
        de_token_id: 0x2::object::ID,
    }

    struct Receive<phantom T0, phantom T1> has copy, drop {
        de_wrapper_id: 0x2::object::ID,
        receiving_type: 0x1::ascii::String,
        receiving_id: 0x2::object::ID,
    }

    struct DE_WRAPPER has drop {
        dummy_field: bool,
    }

    struct DeWrapper<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        tokens: vector<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>,
    }

    struct DeWrapperCreation<phantom T0, phantom T1> {
        wrapper_id: 0x2::object::ID,
        owner: address,
    }

    public fun transfer<T0, T1>(arg0: DeWrapper<T0, T1>, arg1: DeWrapperCreation<T0, T1>) {
        let DeWrapperCreation {
            wrapper_id : v0,
            owner      : v1,
        } = arg1;
        if (0x2::object::id<DeWrapper<T0, T1>>(&arg0) != v0) {
            err_invalid_creation();
        };
        0x2::transfer::transfer<DeWrapper<T0, T1>>(arg0, v1);
    }

    public fun create<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : (DeWrapper<T0, T1>, DeWrapperCreation<T0, T1>) {
        let v0 = DeWrapper<T0, T1>{
            id     : 0x2::object::new(arg0),
            tokens : 0x1::vector::empty<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(),
        };
        let v1 = New<T0, T1>{de_wrapper_id: 0x2::object::id<DeWrapper<T0, T1>>(&v0)};
        0x2::event::emit<New<T0, T1>>(v1);
        let v2 = DeWrapperCreation<T0, T1>{
            wrapper_id : 0x2::object::id<DeWrapper<T0, T1>>(&v0),
            owner      : 0x2::tx_context::sender(arg0),
        };
        (v0, v2)
    }

    fun err_invalid_creation() {
        abort 102
    }

    fun err_token_id_not_found() {
        abort 101
    }

    public fun force_unlock_with_penalty<T0, T1>(arg0: &mut DeWrapper<T0, T1>, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeCenter<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeTokenUpdateResponse<T0, T1>) {
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::force_unlock_with_penalty<T0, T1>(arg1, take<T0, T1>(arg0, arg3), arg2, arg4)
    }

    public fun increase_unlock_amount<T0, T1>(arg0: &mut DeWrapper<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeCenter<T0, T1>, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>) : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeTokenUpdateResponse<T0, T1> {
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::increase_unlock_amount<T0, T1>(arg2, token_mut<T0, T1>(arg0, arg1), arg4, arg3)
    }

    public fun increase_unlock_time<T0, T1>(arg0: &mut DeWrapper<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeCenter<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64) : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeTokenUpdateResponse<T0, T1> {
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::increase_unlock_time<T0, T1>(arg2, token_mut<T0, T1>(arg0, arg1), arg4, arg3)
    }

    fun init(arg0: DE_WRAPPER, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DE_WRAPPER>(arg0, arg1);
    }

    public fun merge<T0, T1>(arg0: &mut DeWrapper<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeCenter<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeTokenUpdateResponse<T0, T1>, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeTokenUpdateResponse<T0, T1>) {
        let v0 = take<T0, T1>(arg0, arg2);
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::merge<T0, T1>(arg3, token_mut<T0, T1>(arg0, arg1), v0, arg4, arg5)
    }

    public fun receive<T0, T1, T2: store + key>(arg0: &mut DeWrapper<T0, T1>, arg1: 0x2::transfer::Receiving<T2>) : T2 {
        let v0 = Receive<T0, T1>{
            de_wrapper_id  : 0x2::object::id<DeWrapper<T0, T1>>(arg0),
            receiving_type : 0x1::type_name::into_string(0x1::type_name::get<T2>()),
            receiving_id   : 0x2::transfer::receiving_object_id<T2>(&arg1),
        };
        0x2::event::emit<Receive<T0, T1>>(v0);
        0x2::transfer::public_receive<T2>(&mut arg0.id, arg1)
    }

    fun take<T0, T1>(arg0: &mut DeWrapper<T0, T1>, arg1: 0x2::object::ID) : 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1> {
        let v0 = &arg0.tokens;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(v0)) {
            if (0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(0x1::vector::borrow<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(v0, v1)) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v2)) {
                    err_token_id_not_found();
                };
                return 0x1::vector::swap_remove<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(&mut arg0.tokens, 0x1::option::destroy_some<u64>(v2))
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun token<T0, T1>(arg0: &DeWrapper<T0, T1>, arg1: 0x2::object::ID) : &0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1> {
        let v0 = &arg0.tokens;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(v0)) {
            if (0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(0x1::vector::borrow<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(v0, v1)) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v2)) {
                    err_token_id_not_found();
                };
                return 0x1::vector::borrow<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(&arg0.tokens, 0x1::option::destroy_some<u64>(v2))
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun token_mut<T0, T1>(arg0: &mut DeWrapper<T0, T1>, arg1: 0x2::object::ID) : &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1> {
        let v0 = &arg0.tokens;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(v0)) {
            if (0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(0x1::vector::borrow<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(v0, v1)) == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v2)) {
                    err_token_id_not_found();
                };
                return 0x1::vector::borrow_mut<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(&mut arg0.tokens, 0x1::option::destroy_some<u64>(v2))
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun total_voting_weight<T0, T1>(arg0: &DeWrapper<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = &arg0.tokens;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::voting_weight<T0, T1>(0x1::vector::borrow<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(v0, v2), arg1));
            v2 = v2 + 1;
        };
        let v3 = 0;
        0x1::vector::reverse<u64>(&mut v1);
        let v4 = 0;
        while (v4 < 0x1::vector::length<u64>(&v1)) {
            v3 = v3 + 0x1::vector::pop_back<u64>(&mut v1);
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<u64>(v1);
        v3
    }

    public fun unlock<T0, T1>(arg0: &mut DeWrapper<T0, T1>, arg1: &mut 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeCenter<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::DeTokenUpdateResponse<T0, T1>) {
        0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_center::unlock<T0, T1>(arg1, take<T0, T1>(arg0, arg3), arg2, arg4)
    }

    public fun wrap<T0, T1>(arg0: &mut DeWrapper<T0, T1>, arg1: 0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>) {
        let v0 = Wrap<T0, T1>{
            de_wrapper_id : 0x2::object::id<DeWrapper<T0, T1>>(arg0),
            de_token_id   : 0x2::object::id<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(&arg1),
        };
        0x2::event::emit<Wrap<T0, T1>>(v0);
        0x1::vector::push_back<0x6104e610f707fe5f1b3f34aa274c113a6b0523e63d5fb2069710e1c2d1f1fd1c::de_token::DeToken<T0, T1>>(&mut arg0.tokens, arg1);
    }

    // decompiled from Move bytecode v6
}

