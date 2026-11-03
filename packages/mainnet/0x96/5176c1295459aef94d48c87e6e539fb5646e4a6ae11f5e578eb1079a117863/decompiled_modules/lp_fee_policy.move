module 0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::lp_fee_policy {
    struct LpFeePolicy has key {
        id: 0x2::object::UID,
        destination: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<address>,
        defaults: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<SharePair>,
        coins: 0x2::table::Table<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>,
    }

    struct SharePair has copy, drop, store {
        meme_bps: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps,
        quote_bps: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps,
    }

    fun new(arg0: address, arg1: SharePair, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : LpFeePolicy {
        LpFeePolicy{
            id          : 0x2::object::new(arg3),
            destination : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<address>(arg0, arg2),
            defaults    : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<SharePair>(arg1, arg2),
            coins       : 0x2::table::new<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(arg3),
        }
    }

    public fun apply_coin_shares<T0>(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0x2::clock::Clock) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x1::option::Option<SharePair>>(0x2::table::borrow<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&arg0.coins, v0));
        let v2 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<0x1::option::Option<SharePair>>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&mut arg0.coins, v0), arg2);
        let v3 = if (0x1::option::is_some<SharePair>(&v1)) {
            let v4 = 0x1::option::destroy_some<SharePair>(v1);
            0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v4.meme_bps))
        } else {
            0x1::option::destroy_none<SharePair>(v1);
            0x1::option::none<u64>()
        };
        let v5 = if (0x1::option::is_some<SharePair>(&v1)) {
            let v6 = 0x1::option::destroy_some<SharePair>(v1);
            0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v6.quote_bps))
        } else {
            0x1::option::destroy_none<SharePair>(v1);
            0x1::option::none<u64>()
        };
        let v7 = if (0x1::option::is_some<SharePair>(&v2)) {
            let v8 = 0x1::option::destroy_some<SharePair>(v2);
            0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v8.meme_bps))
        } else {
            0x1::option::destroy_none<SharePair>(v2);
            0x1::option::none<u64>()
        };
        let v9 = if (0x1::option::is_some<SharePair>(&v2)) {
            let v10 = 0x1::option::destroy_some<SharePair>(v2);
            0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v10.quote_bps))
        } else {
            0x1::option::destroy_none<SharePair>(v2);
            0x1::option::none<u64>()
        };
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::lp_fee_policy_changed(0x1::option::some<0x1::type_name::TypeName>(v0), v3, v5, v7, v9);
    }

    public fun apply_default_shares(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0x2::clock::Clock) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<SharePair>(&arg0.defaults);
        let v1 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<SharePair>(&mut arg0.defaults, arg2);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::lp_fee_policy_changed(0x1::option::none<0x1::type_name::TypeName>(), 0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v0.meme_bps)), 0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v0.quote_bps)), 0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v1.meme_bps)), 0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v1.quote_bps)));
    }

    public fun apply_protocol_destination(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0x2::clock::Clock) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::lp_fee_destination_changed(0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<address>(&arg0.destination), 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<address>(&mut arg0.destination, arg2));
    }

    public fun cancel_coin_shares<T0>(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<0x1::option::Option<SharePair>>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&mut arg0.coins, v0));
        let v2 = if (0x1::option::is_some<SharePair>(&v1)) {
            let v3 = 0x1::option::destroy_some<SharePair>(v1);
            0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v3.meme_bps))
        } else {
            0x1::option::destroy_none<SharePair>(v1);
            0x1::option::none<u64>()
        };
        let v4 = if (0x1::option::is_some<SharePair>(&v1)) {
            let v5 = 0x1::option::destroy_some<SharePair>(v1);
            0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v5.quote_bps))
        } else {
            0x1::option::destroy_none<SharePair>(v1);
            0x1::option::none<u64>()
        };
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::coin_shares_cancelled(v0, v2, v4);
    }

    public fun cancel_default_shares(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<SharePair>(&mut arg0.defaults);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::default_shares_cancelled(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v0.meme_bps), 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v0.quote_bps));
    }

    public fun cancel_protocol_destination(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::protocol_destination_cancelled(0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<address>(&mut arg0.destination));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SharePair{
            meme_bps  : 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::new(1500),
            quote_bps : 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::new(1500),
        };
        0x2::transfer::share_object<LpFeePolicy>(new(@0x52ecee5e58e2f3a7461cc604f4efcc3b68031e4715456d821e3a2719b0593600, v0, 0, arg0));
    }

    public(friend) fun protocol_destination(arg0: &LpFeePolicy) : address {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<address>(&arg0.destination)
    }

    public fun schedule_clear_coin_shares<T0>(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::FeeAdmin>, arg3: u64, arg4: &0x2::clock::Clock) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x1::option::Option<SharePair>>(0x2::table::borrow<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&arg0.coins, v0));
        assert!(0x1::option::is_some<SharePair>(&v1) || arg3 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<0x1::option::Option<SharePair>>(0x2::table::borrow<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&arg0.coins, v0)), 13835340427907170307);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::coin_shares_scheduled(v0, 0x1::option::none<u64>(), 0x1::option::none<u64>(), 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<0x1::option::Option<SharePair>>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&mut arg0.coins, v0), 0x1::option::none<SharePair>(), arg3, arg4), arg3);
    }

    public fun schedule_coin_shares<T0>(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::FeeAdmin>, arg3: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, arg4: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = SharePair{
            meme_bps  : arg3,
            quote_bps : arg4,
        };
        let v2 = 0x1::option::some<SharePair>(v1);
        if (!0x2::table::contains<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&arg0.coins, v0)) {
            0x2::table::add<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&mut arg0.coins, v0, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<0x1::option::Option<SharePair>>(0x1::option::none<SharePair>(), 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<SharePair>(&arg0.defaults)));
        };
        assert!(0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x1::option::Option<SharePair>>(0x2::table::borrow<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&arg0.coins, v0)) != v2 || arg5 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<0x1::option::Option<SharePair>>(0x2::table::borrow<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&arg0.coins, v0)), 13835340311943053315);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::coin_shares_scheduled(v0, 0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg3)), 0x1::option::some<u64>(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg4)), 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<0x1::option::Option<SharePair>>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&mut arg0.coins, v0), v2, arg5, arg6), arg5);
    }

    public fun schedule_default_shares(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::FeeAdmin>, arg3: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, arg4: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        let v0 = SharePair{
            meme_bps  : arg3,
            quote_bps : arg4,
        };
        assert!(v0 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<SharePair>(&arg0.defaults) || arg5 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<SharePair>(&arg0.defaults), 13835340015590309891);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::default_shares_scheduled(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg3), 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg4), 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<SharePair>(&mut arg0.defaults, v0, arg5, arg6), arg5);
    }

    public fun schedule_protocol_destination(arg0: &mut LpFeePolicy, arg1: &0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::TreasuryAdmin>, arg3: address, arg4: u64, arg5: &0x2::clock::Clock) {
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_fun_migrators::assert_current(arg1);
        assert!(arg3 != @0x0, 13835058291505364993);
        assert!(arg3 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<address>(&arg0.destination) || arg4 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<address>(&arg0.destination), 13835058312980201473);
        0x965176c1295459aef94d48c87e6e539fb5646e4a6ae11f5e578eb1079a117863::blast_events::protocol_destination_scheduled(arg3, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<address>(&mut arg0.destination, arg3, arg4, arg5), arg4);
    }

    public(friend) fun shares<T0>(arg0: &LpFeePolicy) : (0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = if (0x2::table::contains<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&arg0.coins, v0)) {
            0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x1::option::Option<SharePair>>(0x2::table::borrow<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x1::option::Option<SharePair>>>(&arg0.coins, v0))
        } else {
            0x1::option::none<SharePair>()
        };
        let v2 = v1;
        let v3 = 0x1::option::get_with_default<SharePair>(&v2, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<SharePair>(&arg0.defaults));
        (v3.meme_bps, v3.quote_bps)
    }

    // decompiled from Move bytecode v7
}

