module 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::launch_config {
    struct TradeFees has copy, drop, store {
        quote_fee_bps: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps,
        meme_fee_bps: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps,
    }

    struct LaunchConfig has key {
        id: 0x2::object::UID,
        meme_decimals: 0x2::vec_set::VecSet<u8>,
        quotes: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        trade_fees: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<TradeFees>,
        migration_witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        witness_delay_ms: u64,
        pending_witness_delay: 0x1::option::Option<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>,
        pending_witnesses: 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>,
        protocol_allocation: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation>,
        creation_fee: 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Delayed<u64>,
    }

    struct PartnerKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    fun new(arg0: TradeFees, arg1: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : LaunchConfig {
        LaunchConfig{
            id                    : 0x2::object::new(arg3),
            meme_decimals         : 0x2::vec_set::from_keys<u8>(x"0609"),
            quotes                : 0x2::table::new<0x1::type_name::TypeName, bool>(arg3),
            trade_fees            : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<TradeFees>(arg0, arg2),
            migration_witnesses   : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            witness_delay_ms      : arg2,
            pending_witness_delay : 0x1::option::none<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(),
            pending_witnesses     : 0x2::vec_map::empty<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(),
            protocol_allocation   : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation>(arg1, arg2),
            creation_fee          : 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new<u64>(0, arg2),
        }
    }

    public(friend) fun protocol_allocation(arg0: &LaunchConfig) : 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation>(&arg0.protocol_allocation)
    }

    public fun add_partner(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::FeeAdmin>, arg3: &0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::Partner) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0x2::object::id<0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::Partner>(arg3);
        let v1 = PartnerKey{pos0: v0};
        if (0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v1)) {
            let v2 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v1);
            assert!(*v2 != 18446744073709551615, 23);
            *v2 = 18446744073709551615;
        } else {
            0x2::dynamic_field::add<PartnerKey, u64>(&mut arg0.id, v1, 18446744073709551615);
        };
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::partner_added(v0);
    }

    public fun apply_creation_fee(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::creation_fee_changed(0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<u64>(&mut arg0.creation_fee, arg2));
    }

    public fun apply_migration_delay(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let (_, v1) = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::take_ready<bool>(0x1::option::extract<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&mut arg0.pending_witness_delay), arg2);
        arg0.witness_delay_ms = v1;
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::migration_delay_changed(v1);
    }

    public fun apply_migration_witness<T0: drop>(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (_, _) = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::take_ready<bool>(*0x2::vec_map::get<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&arg0.pending_witnesses, &v0), arg2);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&mut arg0.pending_witnesses, &v0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.migration_witnesses, v0);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::migration_witness_set<T0>(true);
    }

    public fun apply_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation>(&mut arg0.protocol_allocation, arg2);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::protocol_allocation_set(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::meme_bps(&v0)), 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::quote_bps(&v0)));
    }

    public fun apply_trade_fees(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::apply<TradeFees>(&mut arg0.trade_fees, arg2);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::launch_trade_fees_changed(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v0.quote_fee_bps), 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v0.meme_fee_bps));
    }

    public(friend) fun assert_partner(arg0: &LaunchConfig, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PartnerKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v0), 36);
        assert!(arg2 < *0x2::dynamic_field::borrow<PartnerKey, u64>(&arg0.id, v0), 36);
    }

    public fun cancel_creation_fee(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::creation_fee_cancelled(0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<u64>(&mut arg0.creation_fee));
    }

    public fun cancel_migration_delay(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        0x1::option::extract<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&mut arg0.pending_witness_delay);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::migration_delay_cancelled();
    }

    public fun cancel_migration_witness<T0: drop>(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&mut arg0.pending_witnesses, &v0);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::migration_witness_cancelled(v0);
    }

    public fun cancel_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation>(&mut arg0.protocol_allocation);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::protocol_allocation_cancelled(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::meme_bps(&v0)), 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::quote_bps(&v0)));
    }

    public fun cancel_trade_fees(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::CancelAdmin>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::cancel<TradeFees>(&mut arg0.trade_fees);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::trade_fees_cancelled(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v0.quote_fee_bps), 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(v0.meme_fee_bps));
    }

    public(friend) fun creation_fee(arg0: &LaunchConfig) : u64 {
        0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<u64>(&arg0.creation_fee)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TradeFees{
            quote_fee_bps : 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::new(150),
            meme_fee_bps  : 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::new(0),
        };
        0x2::transfer::share_object<LaunchConfig>(new(v0, 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::protocol_allocation(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::new(250), 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::new(150)), 0, arg0));
    }

    public fun remove_migration_witness<T0: drop>(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::AdapterAdmin>) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.migration_witnesses, &v0) || 0x2::vec_map::contains<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&arg0.pending_witnesses, &v0), 23);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&arg0.pending_witnesses, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&mut arg0.pending_witnesses, &v0);
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::migration_witness_cancelled(v0);
        };
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.migration_witnesses, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.migration_witnesses, &v0);
            0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::migration_witness_set<T0>(false);
        };
    }

    public fun remove_partner(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::FeeAdmin>, arg3: &0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::Partner, arg4: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0x2::object::id<0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::Partner>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert_partner(arg0, v0, v1);
        let v2 = v1 + 0x5526582a1ae9d3cdde47e3b9ec1a24c285a2edff70d750a4b973229e3ae7b5b5::blast_partners::delay_ms();
        let v3 = PartnerKey{pos0: v0};
        let v4 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v3);
        assert!(*v4 == 18446744073709551615, 23);
        *v4 = v2;
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::partner_removed(v0, v2);
    }

    public fun schedule_creation_fee(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::FeeAdmin>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        assert!(arg3 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<u64>(&arg0.creation_fee) || arg4 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<u64>(&arg0.creation_fee), 23);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::creation_fee_scheduled(arg3, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<u64>(&mut arg0.creation_fee, arg3, arg4, arg5), arg4);
    }

    public fun schedule_migration_delay(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::AdapterAdmin>, arg3: u64, arg4: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new_pending<bool>(false, arg0.witness_delay_ms, arg3, arg4);
        arg0.pending_witness_delay = 0x1::option::some<0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(v0);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::migration_delay_scheduled(arg3, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::ready_at_ms<bool>(&v0));
    }

    public fun schedule_migration_witness<T0: drop>(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::AdapterAdmin>, arg3: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 4);
        let v1 = 0x1::type_name::original_id<T0>();
        assert!(v1 != @0x1 && v1 != @0x2, 4);
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.migration_witnesses, &v0), 23);
        let v2 = arg0.witness_delay_ms;
        let v3 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::new_pending<bool>(true, v2, v2, arg3);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&arg0.pending_witnesses, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&mut arg0.pending_witnesses, &v0);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::Pending<bool>>(&mut arg0.pending_witnesses, v0, v3);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::migration_witness_scheduled(v0, 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::ready_at_ms<bool>(&v3), v2);
    }

    public fun schedule_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::TreasuryAdmin>, arg3: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, arg4: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        assert!(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg3) <= 9998 && 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg4) <= 9999, 5);
        let v0 = 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::protocol_allocation(arg3, arg4);
        assert!(v0 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation>(&arg0.protocol_allocation) || arg5 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation>(&arg0.protocol_allocation), 23);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::protocol_allocation_scheduled(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg3), 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg4), 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::allocation::ProtocolAllocation>(&mut arg0.protocol_allocation, v0, arg5, arg6), arg5);
    }

    public fun schedule_trade_fees(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::FeeAdmin>, arg3: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, arg4: 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        assert!(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg3) <= 1000 && 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg4) <= 1000, 1);
        let v0 = TradeFees{
            quote_fee_bps : arg3,
            meme_fee_bps  : arg4,
        };
        assert!(v0 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<TradeFees>(&arg0.trade_fees) || arg5 != 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::delay_ms<TradeFees>(&arg0.trade_fees), 23);
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::trade_fees_scheduled(0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg3), 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::value(arg4), 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::schedule<TradeFees>(&mut arg0.trade_fees, v0, arg5, arg6), arg5);
    }

    public fun set_meme_decimals_allowed(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::ListingAdmin>, arg3: u8, arg4: bool) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        if (arg4) {
            0x2::vec_set::insert<u8>(&mut arg0.meme_decimals, arg3);
        } else {
            0x2::vec_set::remove<u8>(&mut arg0.meme_decimals, &arg3);
        };
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::meme_decimals_set(arg3, arg4);
    }

    public fun set_quote_allowed<T0>(arg0: &mut LaunchConfig, arg1: &0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::PackageVersion, arg2: &0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::blast_acl::AdminWitness<0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun_domain::ListingAdmin>, arg3: bool) {
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::blast_fun::assert_current(arg1);
        if (arg3) {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.quotes, 0x1::type_name::with_original_ids<T0>(), true);
        } else {
            0x2::table::remove<0x1::type_name::TypeName, bool>(&mut arg0.quotes, 0x1::type_name::with_original_ids<T0>());
        };
        0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::events::quote_set<T0>(arg3);
    }

    public(friend) fun snapshot_for_launch<T0>(arg0: &LaunchConfig, arg1: 0x1::type_name::TypeName, arg2: u8) : (0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps, 0x513772b5ab6cb7896e30427c665176c36f993d96616205550fc187090720c425::bps::Bps) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.quotes, 0x1::type_name::with_original_ids<T0>()), 32);
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.migration_witnesses, &arg1), 3);
        assert!(0x2::vec_set::contains<u8>(&arg0.meme_decimals, &arg2), 2);
        let v0 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<TradeFees>(&arg0.trade_fees);
        let v1 = 0xa22ec84d1b7b04964100e0a216b373034ee98af16f0b98c4bb96dc41ff0b36d4::delayed::value<TradeFees>(&arg0.trade_fees);
        (v0.quote_fee_bps, v1.meme_fee_bps)
    }

    // decompiled from Move bytecode v7
}

