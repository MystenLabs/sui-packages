module 0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::stake {
    struct STAKE has drop {
        dummy_field: bool,
    }

    struct STAKE_ADMIN has drop {
        dummy_field: bool,
    }

    struct StakeEvent has copy, drop {
        user: address,
        stake_amount: u64,
        mint_amount: u64,
    }

    struct UnstakeEvent has copy, drop {
        user: address,
        unstake_amount: u64,
        redeem_amount: u64,
    }

    struct RebaseEvent has copy, drop {
        epoch_num: u64,
        last_epoch: u64,
        rebase_rate: u64,
        redeem_rate: u64,
    }

    struct RebasePool has key {
        id: 0x2::object::UID,
        stake_supply: 0x2::balance::Supply<STAKE>,
        vapor_mint_cap: 0x1::option::Option<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::MintCap>,
        epoch_num: u64,
        last_epoch: u64,
        rebase_rate: u64,
        redeem_rate: u64,
    }

    public fun stake(arg0: &mut RebasePool, arg1: &mut 0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::Treasury, arg2: 0x2::coin::Coin<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::VAPOR>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STAKE> {
        let v0 = 0x2::coin::value<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::VAPOR>(&arg2);
        assert!(v0 > 0, 0);
        0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::burn(arg1, arg2);
        let v1 = (((v0 as u128) * (1000000 as u128) / (arg0.redeem_rate as u128)) as u64);
        let v2 = StakeEvent{
            user         : 0x2::tx_context::sender(arg3),
            stake_amount : v0,
            mint_amount  : v1,
        };
        0x2::event::emit<StakeEvent>(v2);
        0x2::coin::from_balance<STAKE>(0x2::balance::increase_supply<STAKE>(&mut arg0.stake_supply, v1), arg3)
    }

    entry fun begin_pool(arg0: &0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::OperatorCap<STAKE_ADMIN>, arg1: &mut RebasePool, arg2: &0x2::clock::Clock) {
        arg1.last_epoch = 0x2::clock::timestamp_ms(arg2);
    }

    public entry fun destroy_vapor_mint_cap(arg0: &0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::OwnerCap<STAKE_ADMIN>, arg1: &mut RebasePool) {
        0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::destroy_mint_cap(0x1::option::extract<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::MintCap>(&mut arg1.vapor_mint_cap));
    }

    public entry fun get_epoch_num(arg0: &RebasePool) : u64 {
        arg0.epoch_num
    }

    public fun get_rebase_rate(arg0: &RebasePool) : u64 {
        arg0.rebase_rate
    }

    public fun get_redeem_rate(arg0: &RebasePool) : u64 {
        arg0.redeem_rate
    }

    public fun get_stake_supply(arg0: &RebasePool) : u64 {
        0x2::balance::supply_value<STAKE>(&arg0.stake_supply)
    }

    public fun get_staked_vapor(arg0: &RebasePool) : u64 {
        (((0x2::balance::supply_value<STAKE>(&arg0.stake_supply) as u128) * (arg0.redeem_rate as u128) / (1000000 as u128)) as u64)
    }

    fun init(arg0: STAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = STAKE_ADMIN{dummy_field: false};
        let v1 = 0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::create_owner_cap<STAKE_ADMIN>(v0, arg1);
        0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::transfer_owner_cap<STAKE_ADMIN>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::OperatorCap<STAKE_ADMIN>>(0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::create_operator_cap<STAKE_ADMIN>(&v1, arg1), 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::coin::create_currency<STAKE>(arg0, 9, b"sVAPOR", b"Staked VAPOR", b"Rebase staked VAPOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bafybeidshtufhkiqww3dw4of6bi2pziiyuow4jafbuhc62dqyxdsqau7zi.ipfs.nftstorage.link/")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAKE>>(v3);
        let v4 = RebasePool{
            id             : 0x2::object::new(arg1),
            stake_supply   : 0x2::coin::treasury_into_supply<STAKE>(v2),
            vapor_mint_cap : 0x1::option::none<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::MintCap>(),
            epoch_num      : 0,
            last_epoch     : 0,
            rebase_rate    : 1 * 1000000,
            redeem_rate    : 1 * 1000000,
        };
        0x2::transfer::share_object<RebasePool>(v4);
    }

    entry fun rebase(arg0: &0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::OperatorCap<STAKE_ADMIN>, arg1: &mut RebasePool, arg2: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.last_epoch + 43200000, 2);
        arg1.epoch_num = arg1.epoch_num + 1;
        arg1.last_epoch = arg1.last_epoch + 43200000;
        arg1.redeem_rate = arg1.redeem_rate * arg1.rebase_rate / 1000000;
        let v0 = RebaseEvent{
            epoch_num   : arg1.epoch_num,
            last_epoch  : arg1.last_epoch,
            rebase_rate : arg1.rebase_rate,
            redeem_rate : arg1.redeem_rate,
        };
        0x2::event::emit<RebaseEvent>(v0);
    }

    entry fun set_pool_time(arg0: &0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::OperatorCap<STAKE_ADMIN>, arg1: &mut RebasePool, arg2: u64) {
        arg1.last_epoch = arg2;
    }

    public entry fun set_rebase_rate(arg0: &0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::OwnerCap<STAKE_ADMIN>, arg1: &mut RebasePool, arg2: u64) {
        arg1.rebase_rate = arg2;
    }

    public entry fun set_vapor_mint_cap(arg0: &0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::admin::OwnerCap<STAKE_ADMIN>, arg1: &mut RebasePool, arg2: 0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::MintCap) {
        0x1::option::fill<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::MintCap>(&mut arg1.vapor_mint_cap, arg2);
    }

    entry fun stake_to_sender(arg0: &mut RebasePool, arg1: &mut 0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::Treasury, arg2: 0x2::coin::Coin<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::VAPOR>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = stake(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<STAKE>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun unstake(arg0: &mut RebasePool, arg1: &mut 0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::Treasury, arg2: 0x2::coin::Coin<STAKE>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::VAPOR> {
        let v0 = 0x2::coin::value<STAKE>(&arg2);
        assert!(v0 > 0, 1);
        0x2::balance::decrease_supply<STAKE>(&mut arg0.stake_supply, 0x2::coin::into_balance<STAKE>(arg2));
        let v1 = (((v0 as u128) * (arg0.redeem_rate as u128) / (1000000 as u128)) as u64);
        let v2 = UnstakeEvent{
            user           : 0x2::tx_context::sender(arg3),
            unstake_amount : v0,
            redeem_amount  : v1,
        };
        0x2::event::emit<UnstakeEvent>(v2);
        0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::mint(0x1::option::borrow<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::MintCap>(&arg0.vapor_mint_cap), arg1, v1, arg3)
    }

    entry fun unstake_to_sender(arg0: &mut RebasePool, arg1: &mut 0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::Treasury, arg2: 0x2::coin::Coin<STAKE>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = unstake(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7bd1e2693124665a1daca56a4882ea00b7d2345b47a33757e68ff3d66a0c56f5::vapor::VAPOR>>(v0, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

