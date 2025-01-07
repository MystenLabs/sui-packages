module 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::airdrop {
    struct AirdropRegistry has key {
        id: 0x2::object::UID,
        roles: 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::Roles,
        record: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct AirdropConfig {
        max_token_limit: u64,
        tokens: u64,
        role: 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::Role<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>,
    }

    struct AirdropEvent<phantom T0> has copy, drop {
        user_id: 0x1::string::String,
        addr: address,
        value: u64,
    }

    struct AIRDROP has drop {
        dummy_field: bool,
    }

    public(friend) fun add_record(arg0: &mut AirdropRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<0x1::string::String, bool>(&mut arg0.record, arg1, true);
    }

    public fun authorize_api(arg0: &mut AirdropRegistry, arg1: &0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::assert_publisher_from_package(arg1);
        0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::authorize<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(roles_mut(arg0), 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::new_role<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(arg2));
    }

    public fun deauthorize_api(arg0: &mut AirdropRegistry, arg1: &0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::assert_publisher_from_package(arg1);
        0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::deauthorize<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(roles_mut(arg0), 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::new_role<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(arg2));
    }

    public fun finalize_send(arg0: &mut AirdropRegistry, arg1: AirdropConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let AirdropConfig {
            max_token_limit : v0,
            tokens          : v1,
            role            : v2,
        } = arg1;
        let v3 = v2;
        assert!(v1 <= v0, 1);
        assert!(0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::addr<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(&v3) == 0x2::tx_context::sender(arg2), 2);
        0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::authorize<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(roles_mut(arg0), v3);
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<AIRDROP>(arg0, arg1);
        let v0 = AirdropRegistry{
            id     : 0x2::object::new(arg1),
            roles  : 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::new(arg1),
            record : 0x2::table::new<0x1::string::String, bool>(arg1),
        };
        0x2::transfer::share_object<AirdropRegistry>(v0);
    }

    public fun init_send(arg0: &mut AirdropRegistry, arg1: &mut 0x2::tx_context::TxContext) : AirdropConfig {
        0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::assert_has_role<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(roles(arg0), 0x2::tx_context::sender(arg1));
        0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::deauthorize<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(roles_mut(arg0), 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::new_role<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(0x2::tx_context::sender(arg1)));
        AirdropConfig{
            max_token_limit : 10000000000000000,
            tokens          : 0,
            role            : 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::new_role<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(0x2::tx_context::sender(arg1)),
        }
    }

    public fun is_airdropped(arg0: &AirdropRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(&arg0.record, arg1)
    }

    public(friend) fun remove_record(arg0: &mut AirdropRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table::remove<0x1::string::String, bool>(&mut arg0.record, arg1);
    }

    public(friend) fun roles(arg0: &AirdropRegistry) : &0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::Roles {
        &arg0.roles
    }

    public(friend) fun roles_mut(arg0: &mut AirdropRegistry) : &mut 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::Roles {
        &mut arg0.roles
    }

    public fun send_token<T0>(arg0: &mut 0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::safe::Safe<T0>, arg1: u64, arg2: 0x1::string::String, arg3: address, arg4: &mut AirdropRegistry, arg5: &mut AirdropConfig, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::addr<0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::roles::ApiRole>(&arg5.role) == 0x2::tx_context::sender(arg6), 2);
        assert!(!is_airdropped(arg4, arg2), 0);
        arg5.tokens = arg5.tokens + arg1;
        let v0 = 0x2::coin::take<T0>(0x506a6fc25f1c7d52ceb06ea44a3114c9380f8e2029b4356019822f248b49e411::safe::balance_mut<T0>(arg0), arg1, arg6);
        let v1 = AirdropEvent<T0>{
            user_id : arg2,
            addr    : arg3,
            value   : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<AirdropEvent<T0>>(v1);
        add_record(arg4, arg2, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

