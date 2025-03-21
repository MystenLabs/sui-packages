module 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_airdrop {
    struct AirdropRegistry has key {
        id: 0x2::object::UID,
        lottery_roles: 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::LotteryRoles,
        record: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct AirdropConfig {
        max_token_limit: u64,
        tokens: u64,
        role: 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::Role<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>,
    }

    struct AirdropEvent<phantom T0> has copy, drop {
        nonce: 0x1::string::String,
        addr: address,
        value: u64,
        userId: 0x1::string::String,
    }

    struct LOTTERY_AIRDROP has drop {
        dummy_field: bool,
    }

    public(friend) fun add_record(arg0: &mut AirdropRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<0x1::string::String, bool>(&mut arg0.record, arg1, true);
    }

    public fun authorize_api(arg0: &mut AirdropRegistry, arg1: &0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::assert_publisher_from_package(arg1);
        0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::authorize<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(roles_mut(arg0), 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::new_role<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(arg2));
    }

    public fun deauthorize_api(arg0: &mut AirdropRegistry, arg1: &0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::assert_publisher_from_package(arg1);
        0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::deauthorize<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(roles_mut(arg0), 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::new_role<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(arg2));
    }

    public fun finalize_send(arg0: &mut AirdropRegistry, arg1: AirdropConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let AirdropConfig {
            max_token_limit : v0,
            tokens          : v1,
            role            : v2,
        } = arg1;
        let v3 = v2;
        assert!(v1 <= v0, 1);
        assert!(0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::addr<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(&v3) == 0x2::tx_context::sender(arg2), 2);
        0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::authorize<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(roles_mut(arg0), v3);
    }

    fun init(arg0: LOTTERY_AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LOTTERY_AIRDROP>(arg0, arg1);
        let v0 = AirdropRegistry{
            id            : 0x2::object::new(arg1),
            lottery_roles : 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::new(arg1),
            record        : 0x2::table::new<0x1::string::String, bool>(arg1),
        };
        0x2::transfer::share_object<AirdropRegistry>(v0);
    }

    public fun init_send(arg0: &mut AirdropRegistry, arg1: &mut 0x2::tx_context::TxContext) : AirdropConfig {
        0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::assert_has_role<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(roles(arg0), 0x2::tx_context::sender(arg1));
        0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::deauthorize<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(roles_mut(arg0), 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::new_role<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(0x2::tx_context::sender(arg1)));
        AirdropConfig{
            max_token_limit : 10000000000000000,
            tokens          : 0,
            role            : 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::new_role<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(0x2::tx_context::sender(arg1)),
        }
    }

    public fun is_airdropped(arg0: &AirdropRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, bool>(&arg0.record, arg1)
    }

    public(friend) fun remove_record(arg0: &mut AirdropRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::table::remove<0x1::string::String, bool>(&mut arg0.record, arg1);
    }

    public(friend) fun roles(arg0: &AirdropRegistry) : &0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::LotteryRoles {
        &arg0.lottery_roles
    }

    public(friend) fun roles_mut(arg0: &mut AirdropRegistry) : &mut 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::LotteryRoles {
        &mut arg0.lottery_roles
    }

    public fun send_token<T0>(arg0: &mut 0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_safe::LotterySafe<T0>, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut AirdropRegistry, arg6: &mut AirdropConfig, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::addr<0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_roles::ApiRole>(&arg6.role) == 0x2::tx_context::sender(arg7), 2);
        assert!(!is_airdropped(arg5, arg3), 0);
        arg6.tokens = arg6.tokens + arg1;
        let v0 = 0x2::coin::take<T0>(0x41bfbb74a7a5404cc2fe219fef54194b68b0e1fde41d3f57ac9d435557e7a00b::lottery_safe::balance_mut<T0>(arg0), arg1, arg7);
        let v1 = AirdropEvent<T0>{
            nonce  : arg3,
            addr   : arg4,
            value  : 0x2::coin::value<T0>(&v0),
            userId : arg2,
        };
        0x2::event::emit<AirdropEvent<T0>>(v1);
        add_record(arg5, arg3, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

