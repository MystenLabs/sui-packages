module 0x8a685416b0419c913ff4387da7487f4cdcfb1526431195efde1a06e13708ca90::admin {
    struct Config has key {
        id: 0x2::object::UID,
        ops_wallet: address,
        paused: bool,
        fee_bps: u16,
        landmarks_minted: u64,
        countries_minted: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OpsWalletUpdated has copy, drop {
        old_ops: address,
        new_ops: address,
    }

    struct PauseToggled has copy, drop {
        paused: bool,
    }

    public fun assert_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 1);
    }

    public fun assert_ops(arg0: &Config, arg1: address) {
        assert!(arg1 == arg0.ops_wallet, 3);
    }

    public(friend) fun bump_countries(arg0: &mut Config, arg1: u64) {
        arg0.countries_minted = arg0.countries_minted + arg1;
    }

    public(friend) fun bump_landmarks(arg0: &mut Config, arg1: u64) {
        arg0.landmarks_minted = arg0.landmarks_minted + arg1;
    }

    public fun countries_minted(arg0: &Config) : u64 {
        arg0.countries_minted
    }

    public fun fee_bps(arg0: &Config) : u16 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Config{
            id               : 0x2::object::new(arg0),
            ops_wallet       : v0,
            paused           : false,
            fee_bps          : 100,
            landmarks_minted : 0,
            countries_minted : 0,
        };
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun landmarks_minted(arg0: &Config) : u64 {
        arg0.landmarks_minted
    }

    public fun max_landmarks_primary() : u64 {
        10000
    }

    public fun ops_wallet(arg0: &Config) : address {
        arg0.ops_wallet
    }

    public fun set_fee_bps(arg0: &AdminCap, arg1: &mut Config, arg2: u16) {
        assert!(arg2 <= 10000, 2);
        arg1.fee_bps = arg2;
    }

    public fun set_ops_wallet(arg0: &AdminCap, arg1: &mut Config, arg2: address) {
        arg1.ops_wallet = arg2;
        let v0 = OpsWalletUpdated{
            old_ops : arg1.ops_wallet,
            new_ops : arg2,
        };
        0x2::event::emit<OpsWalletUpdated>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PauseToggled{paused: arg2};
        0x2::event::emit<PauseToggled>(v0);
    }

    public fun split_fee<T0>(arg0: &Config, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>) {
        (arg1, 0x2::coin::split<T0>(&mut arg1, (((0x2::coin::value<T0>(&arg1) as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64), arg2))
    }

    public fun withdraw_sui(arg0: &AdminCap, arg1: &mut Config, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1.ops_wallet);
    }

    // decompiled from Move bytecode v7
}

