module 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::config {
    struct Config has key {
        id: 0x2::object::UID,
        admin: address,
        treasury: address,
        entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
        paused: bool,
        whitelisted_collections: vector<0x1::type_name::TypeName>,
    }

    struct ConfigUpdated has copy, drop {
        entry_fee: u64,
        winner_payout: u64,
        treasury_share: u64,
    }

    struct TreasuryUpdated has copy, drop {
        old_treasury: address,
        new_treasury: address,
    }

    public fun admin(arg0: &Config) : address {
        arg0.admin
    }

    public fun entry_fee(arg0: &Config) : u64 {
        arg0.entry_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                      : 0x2::object::new(arg0),
            admin                   : 0x2::tx_context::sender(arg0),
            treasury                : @0x956624f2fbbdf16bb5e334b550efd975ff7677e34bbd4e18cb6f485756af6c08,
            entry_fee               : 100000000,
            winner_payout           : 150000000,
            treasury_share          : 50000000,
            paused                  : false,
            whitelisted_collections : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_collection_whitelisted<T0: store + key>(arg0: &Config) : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        0x1::vector::contains<0x1::type_name::TypeName>(&arg0.whitelisted_collections, &v0)
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun remove_collection<T0: store + key>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_admin_only());
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (v1, v2) = 0x1::vector::index_of<0x1::type_name::TypeName>(&arg0.whitelisted_collections, &v0);
        if (v1) {
            0x1::vector::remove<0x1::type_name::TypeName>(&mut arg0.whitelisted_collections, v2);
        };
    }

    public fun set_economics(arg0: &mut Config, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_admin_only());
        assert!(arg2 + arg3 <= 2 * arg1, 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_invalid_economics());
        arg0.entry_fee = arg1;
        arg0.winner_payout = arg2;
        arg0.treasury_share = arg3;
        let v0 = ConfigUpdated{
            entry_fee      : arg1,
            winner_payout  : arg2,
            treasury_share : arg3,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_paused(arg0: &mut Config, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_admin_only());
        arg0.paused = arg1;
    }

    public fun set_treasury(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_admin_only());
        assert!(arg1 != @0x0, 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_invalid_address());
        arg0.treasury = arg1;
        let v0 = TreasuryUpdated{
            old_treasury : arg0.treasury,
            new_treasury : arg1,
        };
        0x2::event::emit<TreasuryUpdated>(v0);
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun treasury_share(arg0: &Config) : u64 {
        arg0.treasury_share
    }

    public fun whitelist_collection<T0: store + key>(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0x5d20351dc2275d127b4cbd3f5fb05286dc8a7bf347f3a9bdfee073e66ea08fa0::errors::e_admin_only());
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x1::vector::contains<0x1::type_name::TypeName>(&arg0.whitelisted_collections, &v0)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.whitelisted_collections, v0);
        };
    }

    public fun winner_payout(arg0: &Config) : u64 {
        arg0.winner_payout
    }

    // decompiled from Move bytecode v6
}

