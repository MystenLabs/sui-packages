module 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::launch_config {
    struct TradeFees has copy, drop, store {
        quote_fee_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        meme_fee_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
    }

    struct LaunchConfig has key {
        id: 0x2::object::UID,
        meme_decimals: 0x2::vec_set::VecSet<u8>,
        quotes: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        trade_fees: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<TradeFeesKey, TradeFees>,
        venues: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::DelayedSet<VenueKey, 0x1::type_name::TypeName>,
        protocol_allocation: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<ProtocolAllocationKey, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::ProtocolAllocation>,
        protocol_lp_fees: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<ProtocolLpFeesKey, ProtocolLpFees>,
        creation_fee: 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::Delayed<CreationFeeKey, u64>,
        partners: 0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::PartnerList,
    }

    struct TradeFeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolLpFees has copy, drop, store {
        meme_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
        quote_bps: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps,
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

    fun new(arg0: TradeFees, arg1: 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::ProtocolAllocation, arg2: ProtocolLpFees, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : LaunchConfig {
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
            trade_fees          : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<TradeFeesKey, TradeFees>(v1, &v0, arg0, arg3),
            venues              : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::new<VenueKey, 0x1::type_name::TypeName>(v2, &v0, arg3),
            protocol_allocation : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<ProtocolAllocationKey, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::ProtocolAllocation>(v3, &v0, arg1, arg3),
            protocol_lp_fees    : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<ProtocolLpFeesKey, ProtocolLpFees>(v4, &v0, arg2, arg3),
            creation_fee        : 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::new<CreationFeeKey, u64>(v5, &v0, 0, arg3),
            partners            : 0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::new(&v0, arg4),
        }
    }

    public(friend) fun protocol_allocation(arg0: &LaunchConfig) : 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::ProtocolAllocation {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<ProtocolAllocationKey, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::ProtocolAllocation>(&arg0.protocol_allocation)
    }

    public fun add_partner(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::FeeAdmin>, arg3: &0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::Partner) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::add(&mut arg0.partners, arg3);
    }

    public fun apply_creation_fee(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<CreationFeeKey, u64>(&mut arg0.creation_fee, arg2);
    }

    public fun apply_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<ProtocolAllocationKey, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::ProtocolAllocation>(&mut arg0.protocol_allocation, arg2);
    }

    public fun apply_protocol_lp_fees(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<ProtocolLpFeesKey, ProtocolLpFees>(&mut arg0.protocol_lp_fees, arg2);
    }

    public fun apply_trade_fees(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::apply<TradeFeesKey, TradeFees>(&mut arg0.trade_fees, arg2);
    }

    public fun apply_venue<T0: drop>(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::apply_add<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, 0x1::type_name::with_original_ids<T0>(), arg2);
    }

    public fun apply_venue_delay(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::apply_delay<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, arg2);
    }

    public(friend) fun assert_partner(arg0: &LaunchConfig, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) {
        0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::assert_accepted(&arg0.partners, arg1, arg2);
    }

    public fun cancel_creation_fee(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<CreationFeeKey, u64>(&mut arg0.creation_fee);
    }

    public fun cancel_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<ProtocolAllocationKey, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::ProtocolAllocation>(&mut arg0.protocol_allocation);
    }

    public fun cancel_protocol_lp_fees(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<ProtocolLpFeesKey, ProtocolLpFees>(&mut arg0.protocol_lp_fees);
    }

    public fun cancel_trade_fees(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::cancel<TradeFeesKey, TradeFees>(&mut arg0.trade_fees);
    }

    public fun cancel_venue<T0: drop>(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::cancel_add<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, 0x1::type_name::with_original_ids<T0>());
    }

    public fun cancel_venue_delay(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::CancelAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::cancel_delay<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues);
    }

    public(friend) fun creation_fee(arg0: &LaunchConfig) : u64 {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<CreationFeeKey, u64>(&arg0.creation_fee)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TradeFees{
            quote_fee_bps : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(150),
            meme_fee_bps  : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(0),
        };
        0x2::transfer::share_object<LaunchConfig>(new(v0, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::protocol_allocation(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(250), 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(150)), new_protocol_lp_fees(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(1500), 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::new(1500)), 0, arg0));
    }

    public(friend) fun is_guarded(arg0: &LaunchConfig) : bool {
        if (0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::is_guarded<TradeFeesKey, TradeFees>(&arg0.trade_fees)) {
            if (0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::is_guarded<VenueKey, 0x1::type_name::TypeName>(&arg0.venues)) {
                if (0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::is_guarded<ProtocolAllocationKey, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::ProtocolAllocation>(&arg0.protocol_allocation)) {
                    if (0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::is_guarded<ProtocolLpFeesKey, ProtocolLpFees>(&arg0.protocol_lp_fees)) {
                        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::is_guarded<CreationFeeKey, u64>(&arg0.creation_fee)
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

    fun new_protocol_lp_fees(arg0: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg1: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps) : ProtocolLpFees {
        assert!(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg0) <= 3000 && 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg1) <= 3000, 34);
        ProtocolLpFees{
            meme_bps  : arg0,
            quote_bps : arg1,
        }
    }

    public(friend) fun protocol_lp_fees(arg0: &LaunchConfig) : (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps) {
        let ProtocolLpFees {
            meme_bps  : v0,
            quote_bps : v1,
        } = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<ProtocolLpFeesKey, ProtocolLpFees>(&arg0.protocol_lp_fees);
        (v0, v1)
    }

    public fun remove_partner(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::FeeAdmin>, arg3: &0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::Partner, arg4: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::partner_list::remove(&mut arg0.partners, 0x2::object::id<0x2998c10c91e46082548b2f3205f84f09377bbbedf2b0f617f70575a09ec69a54::blast_partners::Partner>(arg3), arg4);
    }

    public fun remove_venue<T0: drop>(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::VenueAdmin>) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::remove<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, 0x1::type_name::with_original_ids<T0>());
    }

    public fun schedule_creation_fee(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::FeeAdmin>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        assert!(arg3 <= 10000000000, 30);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule<CreationFeeKey, u64>(&mut arg0.creation_fee, arg3, arg4, arg5);
    }

    public fun schedule_protocol_allocation(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::TreasuryAdmin>, arg3: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg4: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule<ProtocolAllocationKey, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::ProtocolAllocation>(&mut arg0.protocol_allocation, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::allocation::protocol_allocation(arg3, arg4), arg5, arg6);
    }

    public fun schedule_protocol_lp_fees(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::FeeAdmin>, arg3: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg4: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule<ProtocolLpFeesKey, ProtocolLpFees>(&mut arg0.protocol_lp_fees, new_protocol_lp_fees(arg3, arg4), arg5, arg6);
    }

    public fun schedule_trade_fees(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::FeeAdmin>, arg3: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg4: 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, arg5: u64, arg6: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        assert!(0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg3) <= 1000 && 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::value(arg4) <= 1000, 0);
        let v0 = TradeFees{
            quote_fee_bps : arg3,
            meme_fee_bps  : arg4,
        };
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::schedule<TradeFeesKey, TradeFees>(&mut arg0.trade_fees, v0, arg5, arg6);
    }

    public fun schedule_venue<T0: drop>(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::VenueAdmin>, arg3: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(!0x1::type_name::is_primitive(&v0), 3);
        let v1 = 0x1::type_name::original_id<T0>();
        assert!(v1 != @0x1 && v1 != @0x2, 3);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::schedule_add<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, v0, arg3);
    }

    public fun schedule_venue_delay(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::VenueAdmin>, arg3: u64, arg4: &0x2::clock::Clock) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::schedule_delay<VenueKey, 0x1::type_name::TypeName>(&mut arg0.venues, arg3, arg4);
    }

    public fun set_meme_decimals_allowed(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::ListingAdmin>, arg3: u8, arg4: bool) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        if (arg4) {
            0x2::vec_set::insert<u8>(&mut arg0.meme_decimals, arg3);
        } else {
            0x2::vec_set::remove<u8>(&mut arg0.meme_decimals, &arg3);
        };
        0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::events::meme_decimals_allowed(arg3, arg4);
    }

    public fun set_quote_allowed<T0>(arg0: &mut LaunchConfig, arg1: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_domain::ListingAdmin>, arg3: bool) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (arg3) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.quotes, v0);
        } else {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.quotes, &v0);
        };
        0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::events::quote_allowed<T0>(arg3);
    }

    public(friend) fun snapshot_for_launch<T0>(arg0: &LaunchConfig, arg1: 0x1::type_name::TypeName, arg2: u8) : (0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps, 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::bps::Bps) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.quotes, &v0), 27);
        assert!(0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::contains<VenueKey, 0x1::type_name::TypeName>(&arg0.venues, &arg1), 2);
        assert!(0x2::vec_set::contains<u8>(&arg0.meme_decimals, &arg2), 1);
        let v1 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<TradeFeesKey, TradeFees>(&arg0.trade_fees);
        let v2 = 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed::value<TradeFeesKey, TradeFees>(&arg0.trade_fees);
        (v1.quote_fee_bps, v2.meme_fee_bps)
    }

    public fun unpause(arg0: &LaunchConfig, arg1: &mut 0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::PackageVersion<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg2: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::blast_acl::AdminWitness<0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_admin::UnpauseAdmin<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>>, arg3: &0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_admin::PackageAdmin<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>, arg4: &0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::runtime_config::RuntimeConfig, arg5: &0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury::Treasury, arg6: u8) {
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_version::assert_current<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN>(arg1, 1);
        let v0 = if (is_guarded(arg0)) {
            if (0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::runtime_config::is_guarded(arg4)) {
                0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::blast_treasury::is_guarded(arg5)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 32);
        0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::package_admin::clear_pause_bits<0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::BLAST_FUN, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::PackageWitness>(arg3, arg2, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::package_witness(), arg1, arg6);
    }

    public fun venue_admission<T0: drop>(arg0: &LaunchConfig) : 0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::VenueAdmission {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0xb4c52669d7a07ce26d8fc91ba577b0a05f1f3d0cb9b1ba230c6419fb7ddd55fd::delayed_set::contains<VenueKey, 0x1::type_name::TypeName>(&arg0.venues, &v0), 2);
        0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::venue_admission<T0, 0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::PackageWitness>(0x9c2cef371c0e80648136f7ae65378ac9476e3fdb860538d00290e6e4f975b192::blast_fun::package_witness())
    }

    // decompiled from Move bytecode v7
}

