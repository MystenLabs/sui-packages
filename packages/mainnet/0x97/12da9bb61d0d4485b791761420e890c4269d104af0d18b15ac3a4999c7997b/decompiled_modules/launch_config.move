module 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::launch_config {
    struct TradeFees has copy, drop, store {
        quote_fee_bps: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps,
        meme_fee_bps: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps,
    }

    struct LaunchConfig has key {
        id: 0x2::object::UID,
        meme_decimals: 0x2::vec_set::VecSet<u8>,
        quotes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        trade_fees: 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::Delayed<TradeFeesKey, TradeFees>,
        venues: 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::DelayedSet<VenueKey, 0x1::type_name::TypeName>,
        protocol_allocation: 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::Delayed<ProtocolAllocationKey, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::ProtocolAllocation>,
        protocol_lp_fees: 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::Delayed<ProtocolLpFeesKey, ProtocolLpFees>,
        creation_fee: 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::Delayed<CreationFeeKey, u64>,
        partners: 0x48845f0f2a64595f96c25a1e841735eee263fc147f6c7867cf06b72eef297a42::partner_list::PartnerList,
    }

    struct TradeFeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolLpFees has copy, drop, store {
        meme_bps: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps,
        quote_bps: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps,
    }

    struct VenueKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolAllocationKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolLpFeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct CreationFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    fun new(arg0: TradeFees, arg1: 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::ProtocolAllocation, arg2: ProtocolLpFees, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : LaunchConfig {
        let v0 = 0x2::object::new(arg4);
        let v1 = TradeFeesKey{dummy_field: false};
        let v2 = VenueKey{dummy_field: false};
        let v3 = ProtocolAllocationKey{dummy_field: false};
        let v4 = ProtocolLpFeesKey{dummy_field: false};
        let v5 = CreationFeeKey{dummy_field: false};
        LaunchConfig{
            id                  : v0,
            meme_decimals       : 0x2::vec_set::from_keys<u8>(x"0609"),
            quotes              : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            trade_fees          : 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::new<TradeFeesKey, TradeFees>(v1, &v0, arg0, arg3),
            venues              : 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::new<VenueKey, 0x1::type_name::TypeName>(v2, &v0, arg3),
            protocol_allocation : 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::new<ProtocolAllocationKey, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::ProtocolAllocation>(v3, &v0, arg1, arg3),
            protocol_lp_fees    : 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::new<ProtocolLpFeesKey, ProtocolLpFees>(v4, &v0, arg2, arg3),
            creation_fee        : 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::new<CreationFeeKey, u64>(v5, &v0, 0, arg3),
            partners            : 0x48845f0f2a64595f96c25a1e841735eee263fc147f6c7867cf06b72eef297a42::partner_list::new(&v0, arg4),
        }
    }

    public(friend) fun protocol_allocation(arg0: &LaunchConfig) : 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::ProtocolAllocation {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::value<ProtocolAllocationKey, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::ProtocolAllocation>(&arg0.protocol_allocation)
    }

    public fun add_partner(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::FeeAdmin>, arg3: &0x48845f0f2a64595f96c25a1e841735eee263fc147f6c7867cf06b72eef297a42::blast_partners::Partner) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0x48845f0f2a64595f96c25a1e841735eee263fc147f6c7867cf06b72eef297a42::partner_list::add(&mut arg0.partners, arg3);
    }

    public fun apply_creation_fee(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::apply<CreationFeeKey, u64>(&mut arg0.creation_fee, arg2);
    }

    public fun apply_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::apply<ProtocolAllocationKey, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::ProtocolAllocation>(&mut arg0.protocol_allocation, arg2);
    }

    public fun apply_protocol_lp_fees(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::apply<ProtocolLpFeesKey, ProtocolLpFees>(&mut arg0.protocol_lp_fees, arg2);
    }

    public fun apply_trade_fees(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::apply<TradeFeesKey, TradeFees>(&mut arg0.trade_fees, arg2);
    }

    public fun apply_venue<T0: drop>(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::apply_add<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, 0x1::type_name::with_original_ids<T0>(), arg2);
    }

    public fun apply_venue_delay(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::apply_delay<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, arg2);
    }

    public(friend) fun assert_partner(arg0: &LaunchConfig, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        0x48845f0f2a64595f96c25a1e841735eee263fc147f6c7867cf06b72eef297a42::partner_list::assert_accepted(&arg0.partners, arg1, arg2);
    }

    public fun cancel_creation_fee(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::CancelAdmin>) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::cancel<CreationFeeKey, u64>(&mut arg0.creation_fee);
    }

    public fun cancel_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::CancelAdmin>) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::cancel<ProtocolAllocationKey, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::ProtocolAllocation>(&mut arg0.protocol_allocation);
    }

    public fun cancel_protocol_lp_fees(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::CancelAdmin>) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::cancel<ProtocolLpFeesKey, ProtocolLpFees>(&mut arg0.protocol_lp_fees);
    }

    public fun cancel_trade_fees(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::CancelAdmin>) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::cancel<TradeFeesKey, TradeFees>(&mut arg0.trade_fees);
    }

    public fun cancel_venue<T0: drop>(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::CancelAdmin>) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::cancel_add<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, 0x1::type_name::with_original_ids<T0>());
    }

    public fun cancel_venue_delay(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::CancelAdmin>) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::cancel_delay<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues);
    }

    public(friend) fun creation_fee(arg0: &LaunchConfig) : u64 {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::value<CreationFeeKey, u64>(&arg0.creation_fee)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TradeFees{
            quote_fee_bps : 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::new(150),
            meme_fee_bps  : 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::new(0),
        };
        0x2::transfer::share_object<LaunchConfig>(new(v0, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::protocol_allocation(0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::new(250), 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::new(150)), new_protocol_lp_fees(0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::new(1500), 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::new(1500)), 0, arg0));
    }

    public(friend) fun is_guarded(arg0: &LaunchConfig) : bool {
        if (0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::is_guarded<TradeFeesKey, TradeFees>(&arg0.trade_fees)) {
            if (0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::is_guarded<VenueKey, 0x1::type_name::TypeName>(&arg0.venues)) {
                if (0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::is_guarded<ProtocolAllocationKey, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::ProtocolAllocation>(&arg0.protocol_allocation)) {
                    if (0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::is_guarded<ProtocolLpFeesKey, ProtocolLpFees>(&arg0.protocol_lp_fees)) {
                        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::is_guarded<CreationFeeKey, u64>(&arg0.creation_fee)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    fun new_protocol_lp_fees(arg0: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps, arg1: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps) : ProtocolLpFees {
        assert!(0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::value(arg0) <= 3000 && 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::value(arg1) <= 3000, 34);
        ProtocolLpFees{
            meme_bps  : arg0,
            quote_bps : arg1,
        }
    }

    public(friend) fun protocol_lp_fees(arg0: &LaunchConfig) : (0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps, 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps) {
        let ProtocolLpFees {
            meme_bps  : v0,
            quote_bps : v1,
        } = 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::value<ProtocolLpFeesKey, ProtocolLpFees>(&arg0.protocol_lp_fees);
        (v0, v1)
    }

    public fun remove_partner(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::FeeAdmin>, arg3: &0x48845f0f2a64595f96c25a1e841735eee263fc147f6c7867cf06b72eef297a42::blast_partners::Partner, arg4: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0x48845f0f2a64595f96c25a1e841735eee263fc147f6c7867cf06b72eef297a42::partner_list::remove(&mut arg0.partners, 0x2::object::id<0x48845f0f2a64595f96c25a1e841735eee263fc147f6c7867cf06b72eef297a42::blast_partners::Partner>(arg3), arg4);
    }

    public fun remove_venue<T0: drop>(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::VenueAdmin>) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::remove<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, 0x1::type_name::with_original_ids<T0>());
    }

    public fun schedule_creation_fee(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::FeeAdmin>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        assert!(arg3 <= 10000000000, 30);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::schedule<CreationFeeKey, u64>(&mut arg0.creation_fee, arg3, arg4, arg5);
    }

    public fun schedule_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::TreasuryAdmin>, arg3: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps, arg4: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::schedule<ProtocolAllocationKey, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::ProtocolAllocation>(&mut arg0.protocol_allocation, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::protocol_allocation(arg3, arg4), arg5, arg6);
    }

    public fun schedule_protocol_lp_fees(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::FeeAdmin>, arg3: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps, arg4: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::schedule<ProtocolLpFeesKey, ProtocolLpFees>(&mut arg0.protocol_lp_fees, new_protocol_lp_fees(arg3, arg4), arg5, arg6);
    }

    public fun schedule_trade_fees(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::FeeAdmin>, arg3: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps, arg4: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        assert!(0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::value(arg3) <= 1000 && 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::value(arg4) <= 1000, 0);
        let v0 = TradeFees{
            quote_fee_bps : arg3,
            meme_fee_bps  : arg4,
        };
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::schedule<TradeFeesKey, TradeFees>(&mut arg0.trade_fees, v0, arg5, arg6);
    }

    public fun schedule_venue<T0: drop>(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::VenueAdmin>, arg3: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 3);
        let v1 = 0x1::type_name::original_id<T0>();
        assert!(v1 != @0x1 && v1 != @0x2, 3);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::schedule_add<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, v0, arg3);
    }

    public fun schedule_venue_delay(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::VenueAdmin>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::schedule_delay<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, arg3, arg4);
    }

    public fun set_meme_decimals_allowed(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::ListingAdmin>, arg3: u8, arg4: bool) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        if (arg4) {
            0x2::vec_set::insert<u8>(&mut arg0.meme_decimals, arg3);
        } else {
            0x2::vec_set::remove<u8>(&mut arg0.meme_decimals, &arg3);
        };
        0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::events::meme_decimals_allowed(arg3, arg4);
    }

    public fun set_quote_allowed<T0>(arg0: &mut LaunchConfig, arg1: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_domain::ListingAdmin>, arg3: bool) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (arg3) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.quotes, v0);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.quotes, &v0);
        };
        0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::events::quote_allowed<T0>(arg3);
    }

    public(friend) fun snapshot_for_launch<T0>(arg0: &LaunchConfig, arg1: 0x1::type_name::TypeName, arg2: u8) : (0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps, 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::bps::Bps) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quotes, &v0), 27);
        assert!(0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::contains<VenueKey, 0x1::type_name::TypeName>(&arg0.venues, &arg1), 2);
        assert!(0x2::vec_set::contains<u8>(&arg0.meme_decimals, &arg2), 1);
        let v1 = 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::value<TradeFeesKey, TradeFees>(&arg0.trade_fees);
        let v2 = 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed::value<TradeFeesKey, TradeFees>(&arg0.trade_fees);
        (v1.quote_fee_bps, v2.meme_fee_bps)
    }

    public fun unpause(arg0: &LaunchConfig, arg1: &mut 0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::PackageVersion<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg2: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::blast_acl::AdminWitness<0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_admin::UnpauseAdmin<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>>, arg3: &0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_admin::PackageAdmin<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>, arg4: &0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::runtime_config::RuntimeConfig, arg5: &0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_treasury::Treasury, arg6: u8) {
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_version::assert_current<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN>(arg1, 1);
        let v0 = if (is_guarded(arg0)) {
            if (0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::runtime_config::is_guarded(arg4)) {
                0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::blast_treasury::is_guarded(arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 32);
        0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::package_admin::clear_pause_bits<0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::BLAST_FUN, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::PackageWitness>(arg3, arg2, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::package_witness(), arg1, arg6);
    }

    public fun venue_admission<T0: drop>(arg0: &LaunchConfig) : 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::sealed_treasury_cap::VenueAdmission {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0xe22a044624d16ccc9096f36cb30d4607d66eee0a2633f28137e1193bc8fc9333::delayed_set::contains<VenueKey, 0x1::type_name::TypeName>(&arg0.venues, &v0), 2);
        0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::sealed_treasury_cap::venue_admission<T0, 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::PackageWitness>(0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::blast_fun::package_witness())
    }

    // decompiled from Move bytecode v7
}

