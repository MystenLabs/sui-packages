module 0xe652617a2d6e3d3bb1e24e24d471e755153339c84107dfdcffe77efe04209007::treasury {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        wal: 0x2::balance::Balance<T0>,
        claimed: 0x2::table::Table<0x2::object::ID, bool>,
        approved: 0x2::table::Table<0x2::object::ID, bool>,
        accepted_coins: 0x2::table::Table<vector<u8>, bool>,
    }

    struct ProvisionDraw has copy, drop {
        recipient: address,
        session_id: 0x2::object::ID,
        journey_id: 0x2::object::ID,
        sui_out: u64,
        wal_out: u64,
        post_sui: u64,
        post_wal: u64,
    }

    struct VaultDeposit has copy, drop {
        vault: 0x2::object::ID,
        sui_in: u64,
        wal_in: u64,
        post_sui: u64,
        post_wal: u64,
    }

    struct VaultMigrated has copy, drop {
        vault: 0x2::object::ID,
        version: u64,
    }

    struct JourneyApproval has copy, drop {
        vault: 0x2::object::ID,
        journey_id: 0x2::object::ID,
        approved: bool,
    }

    fun assert_version<T0>(arg0: &Vault<T0>) {
        assert!(arg0.version == 1, 9);
    }

    public fun balances<T0>(arg0: &Vault<T0>) : (u64, u64) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.sui), 0x2::balance::value<T0>(&arg0.wal))
    }

    public fun claim_provision<T0>(arg0: &mut Vault<T0>, arg1: 0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Receipt, arg2: &0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let (v0, v1, v2, v3) = 0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::burn_receipt(arg1);
        let v4 = v2;
        let v5 = 0x2::object::id<0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::Session>(arg2);
        assert!(0x2::tx_context::sender(arg3) == v1, 4);
        assert!(0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::buyer(arg2) == v1, 4);
        assert!(0x682d456a9b6c051c9b70e2f67bcee9602b1244278b898e70348b8c6214c214ab::journey::journey_id(arg2) == v0, 8);
        assert!(is_accepted_coin<T0>(arg0, &v4), 7);
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.approved, v0), 5);
        assert!(v3 >= 50000000, 6);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, v5), 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= 11000000, 2);
        assert!(0x2::balance::value<T0>(&arg0.wal) >= 3000000000, 3);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.claimed, v5, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, 11000000), arg3), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.wal, 3000000000), arg3), v1);
        let v6 = ProvisionDraw{
            recipient  : v1,
            session_id : v5,
            journey_id : v0,
            sui_out    : 11000000,
            wal_out    : 3000000000,
            post_sui   : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
            post_wal   : 0x2::balance::value<T0>(&arg0.wal),
        };
        0x2::event::emit<ProvisionDraw>(v6);
    }

    public fun claimed_count<T0>(arg0: &Vault<T0>) : u64 {
        0x2::table::length<0x2::object::ID, bool>(&arg0.claimed)
    }

    entry fun create_vault<T0>(arg0: &OperatorCap, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<vector<u8>, bool>(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            0x2::table::add<vector<u8>, bool>(&mut v0, *0x1::vector::borrow<vector<u8>>(&arg1, v1), true);
            v1 = v1 + 1;
        };
        let v2 = Vault<T0>{
            id             : 0x2::object::new(arg2),
            version        : 1,
            sui            : 0x2::balance::zero<0x2::sui::SUI>(),
            wal            : 0x2::balance::zero<T0>(),
            claimed        : 0x2::table::new<0x2::object::ID, bool>(arg2),
            approved       : 0x2::table::new<0x2::object::ID, bool>(arg2),
            accepted_coins : v0,
        };
        0x2::transfer::share_object<Vault<T0>>(v2);
    }

    entry fun deposit_sui<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version<T0>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = VaultDeposit{
            vault    : 0x2::object::id<Vault<T0>>(arg0),
            sui_in   : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            wal_in   : 0,
            post_sui : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
            post_wal : 0x2::balance::value<T0>(&arg0.wal),
        };
        0x2::event::emit<VaultDeposit>(v0);
    }

    entry fun deposit_wal<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert_version<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.wal, 0x2::coin::into_balance<T0>(arg1));
        let v0 = VaultDeposit{
            vault    : 0x2::object::id<Vault<T0>>(arg0),
            sui_in   : 0,
            wal_in   : 0x2::coin::value<T0>(&arg1),
            post_sui : 0x2::balance::value<0x2::sui::SUI>(&arg0.sui),
            post_wal : 0x2::balance::value<T0>(&arg0.wal),
        };
        0x2::event::emit<VaultDeposit>(v0);
    }

    public fun has_claimed_session<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.claimed, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OperatorCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun is_accepted_coin<T0>(arg0: &Vault<T0>, arg1: &0x1::type_name::TypeName) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.accepted_coins, *0x1::ascii::as_bytes(0x1::type_name::as_string(arg1)))
    }

    public fun is_coin_accepted<T0>(arg0: &Vault<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.accepted_coins, arg1)
    }

    public fun is_journey_approved<T0>(arg0: &Vault<T0>, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.approved, arg1)
    }

    entry fun migrate<T0>(arg0: &OperatorCap, arg1: &mut Vault<T0>) {
        assert!(arg1.version < 1, 9);
        arg1.version = 1;
        let v0 = VaultMigrated{
            vault   : 0x2::object::id<Vault<T0>>(arg1),
            version : 1,
        };
        0x2::event::emit<VaultMigrated>(v0);
    }

    public fun min_qualifying_price() : u64 {
        50000000
    }

    public fun package_version() : u64 {
        1
    }

    public fun production_coin_types() : (vector<u8>, vector<u8>) {
        (b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", b"44f838219cf67b058f3b37907b655f226153c18e33dfcd0da559a844fea9b1c1::usdsui::USDSUI")
    }

    public fun provision_amounts() : (u64, u64) {
        (11000000, 3000000000)
    }

    entry fun set_journey_approved<T0>(arg0: &OperatorCap, arg1: &mut Vault<T0>, arg2: 0x2::object::ID, arg3: bool) {
        assert_version<T0>(arg1);
        let v0 = 0x2::table::contains<0x2::object::ID, bool>(&arg1.approved, arg2);
        if (arg3 && !v0) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg1.approved, arg2, true);
        } else if (!arg3 && v0) {
            0x2::table::remove<0x2::object::ID, bool>(&mut arg1.approved, arg2);
        };
        let v1 = JourneyApproval{
            vault      : 0x2::object::id<Vault<T0>>(arg1),
            journey_id : arg2,
            approved   : arg3,
        };
        0x2::event::emit<JourneyApproval>(v1);
    }

    public fun vault_version<T0>(arg0: &Vault<T0>) : u64 {
        arg0.version
    }

    entry fun withdraw<T0>(arg0: &OperatorCap, arg1: &mut Vault<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.sui, arg2), arg4), v0);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.wal, arg3), arg4), v0);
        };
        let v1 = VaultDeposit{
            vault    : 0x2::object::id<Vault<T0>>(arg1),
            sui_in   : 0,
            wal_in   : 0,
            post_sui : 0x2::balance::value<0x2::sui::SUI>(&arg1.sui),
            post_wal : 0x2::balance::value<T0>(&arg1.wal),
        };
        0x2::event::emit<VaultDeposit>(v1);
    }

    // decompiled from Move bytecode v7
}

