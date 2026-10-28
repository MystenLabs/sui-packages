module 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::events {
    struct ProtocolAllocationSet has copy, drop {
        meme_bps: u64,
        quote_bps: u64,
    }

    struct MemeDecimalsSet has copy, drop {
        decimals: u8,
        allowed: bool,
    }

    struct LaunchTradeFeesChanged has copy, drop {
        quote_fee_bps: u64,
        meme_fee_bps: u64,
    }

    struct QuoteSet has copy, drop {
        quote: 0x1::type_name::TypeName,
        allowed: bool,
    }

    struct MigrationWitnessSet has copy, drop {
        migration_witness: 0x1::type_name::TypeName,
        allowed: bool,
    }

    struct ProtocolFeeShareChanged has copy, drop {
        pos0: u64,
    }

    struct CreatorClaimSignerSet has copy, drop {
        pos0: vector<u8>,
    }

    struct TreasuryChanged has copy, drop {
        pos0: address,
    }

    struct CreationFeeChanged has copy, drop {
        pos0: u64,
    }

    struct PartnerAdded has copy, drop {
        partner_id: 0x2::object::ID,
    }

    struct PartnerRemoved has copy, drop {
        partner_id: 0x2::object::ID,
        accepted_until_ms: u64,
    }

    struct CreatorCapsClaimed has copy, drop {
        meme: 0x1::type_name::TypeName,
        curve_fee_cap_id: 0x2::object::ID,
        blast_metadata_cap_id: 0x2::object::ID,
    }

    struct CurveFeeCapReassigned has copy, drop {
        launch_id: 0x2::object::ID,
        curve_fee_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct MetadataCapReassigned has copy, drop {
        launch_id: 0x2::object::ID,
        blast_metadata_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct MemeMetadataUpdated has copy, drop {
        launch_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
    }

    struct LaunchTicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        meme: 0x1::type_name::TypeName,
        decimals: u8,
        metadata_cap_id: 0x2::object::ID,
        creator: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::creator_authority::CreatorRecipient,
        burnable: bool,
        sell_burn_bps: u64,
    }

    struct LaunchCreated has copy, drop {
        launch_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        quote: 0x1::type_name::TypeName,
        migration_witness: 0x1::type_name::TypeName,
        pool_tick_spacing: u32,
        pool_fee_rate: u64,
        lp_fee_split: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation::FeeSplit,
        virtual_quote: u64,
        graduation_target: u64,
        quote_fee_bps: u64,
        meme_fee_bps: u64,
        allocation_plan: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation::AllocationPlan,
        opening_round_ms: u64,
        creation_fee: u64,
        partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LaunchShared has copy, drop {
        launch_id: 0x2::object::ID,
        public_start_ms: u64,
    }

    struct OpeningRoundJoined has copy, drop {
        launch_id: 0x2::object::ID,
        quote: u64,
        bids: u64,
    }

    struct OpeningRoundSettled has copy, drop {
        launch_id: 0x2::object::ID,
        bids: u64,
        meme: u64,
        quote: u64,
    }

    struct OpeningRoundDelivered has copy, drop {
        launch_id: 0x2::object::ID,
        bidder: address,
        bid: u64,
        meme: u64,
        quote: u64,
    }

    struct Bought has copy, drop {
        launch_id: 0x2::object::ID,
        quote_in: u64,
        meme_out_gross: u64,
        meme_out_net: u64,
        quote_refund: u64,
        protocol_meme_fee: u64,
        creator_meme_fee: u64,
        protocol_quote_fee: u64,
        creator_quote_fee: u64,
        meme_reserve: u64,
        real_quote_reserve: u64,
    }

    struct Sold has copy, drop {
        launch_id: 0x2::object::ID,
        meme_in_gross: u64,
        pending_burn: u64,
        quote_out_gross: u64,
        protocol_meme_fee: u64,
        creator_meme_fee: u64,
        protocol_quote_fee: u64,
        creator_quote_fee: u64,
        meme_reserve: u64,
        real_quote_reserve: u64,
    }

    struct MigrationAllocationPaid has copy, drop {
        launch_id: 0x2::object::ID,
        destination: address,
        meme: u64,
        quote: u64,
    }

    struct Migrated has copy, drop {
        launch_id: 0x2::object::ID,
        meme: u64,
        quote: u64,
        disposed_meme: u64,
        total_supply_after: u64,
    }

    struct CreatorFeesClaimed has copy, drop {
        launch_id: 0x2::object::ID,
        meme_amount: u64,
        quote_amount: u64,
    }

    struct ProtocolFeesClaimed has copy, drop {
        launch_id: 0x2::object::ID,
        treasury: address,
        meme_amount: u64,
        quote_amount: u64,
        sui_amount: u64,
        partner_meme_amount: u64,
        partner_quote_amount: u64,
        partner_sui_amount: u64,
    }

    struct ProtocolFeesAccrued has copy, drop {
        launch_id: 0x2::object::ID,
        meme_amount: u64,
        quote_amount: u64,
    }

    public(friend) fun bought(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = Bought{
            launch_id          : arg0,
            quote_in           : arg1,
            meme_out_gross     : arg2,
            meme_out_net       : arg3,
            quote_refund       : arg4,
            protocol_meme_fee  : arg5,
            creator_meme_fee   : arg6,
            protocol_quote_fee : arg7,
            creator_quote_fee  : arg8,
            meme_reserve       : arg9,
            real_quote_reserve : arg10,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<Bought>(v0);
    }

    public(friend) fun creation_fee_changed(arg0: u64) {
        let v0 = CreationFeeChanged{pos0: arg0};
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<CreationFeeChanged>(v0);
    }

    public(friend) fun creator_caps_claimed<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreatorCapsClaimed{
            meme                  : 0x1::type_name::with_original_ids<T0>(),
            curve_fee_cap_id      : arg0,
            blast_metadata_cap_id : arg1,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<CreatorCapsClaimed>(v0);
    }

    public(friend) fun creator_claim_signer_set(arg0: vector<u8>) {
        let v0 = CreatorClaimSignerSet{pos0: arg0};
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<CreatorClaimSignerSet>(v0);
    }

    public(friend) fun creator_fees_claimed(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = CreatorFeesClaimed{
            launch_id    : arg0,
            meme_amount  : arg1,
            quote_amount : arg2,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<CreatorFeesClaimed>(v0);
    }

    public(friend) fun curve_fee_cap_reassigned(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = CurveFeeCapReassigned{
            launch_id        : arg0,
            curve_fee_cap_id : arg1,
            recipient        : arg2,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<CurveFeeCapReassigned>(v0);
    }

    public(friend) fun launch_created<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u32, arg4: u64, arg5: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation::FeeSplit, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::allocation::AllocationPlan, arg11: u64, arg12: u64, arg13: 0x1::option::Option<0x2::object::ID>) {
        let v0 = LaunchCreated{
            launch_id         : arg0,
            ticket_id         : arg1,
            quote             : 0x1::type_name::with_original_ids<T0>(),
            migration_witness : arg2,
            pool_tick_spacing : arg3,
            pool_fee_rate     : arg4,
            lp_fee_split      : arg5,
            virtual_quote     : arg6,
            graduation_target : arg7,
            quote_fee_bps     : arg8,
            meme_fee_bps      : arg9,
            allocation_plan   : arg10,
            opening_round_ms  : arg11,
            creation_fee      : arg12,
            partner_id        : arg13,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<LaunchCreated>(v0);
    }

    public(friend) fun launch_shared(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LaunchShared{
            launch_id       : arg0,
            public_start_ms : arg1,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<LaunchShared>(v0);
    }

    public(friend) fun launch_ticket_created<T0>(arg0: 0x2::object::ID, arg1: u8, arg2: 0x2::object::ID, arg3: 0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::creator_authority::CreatorRecipient, arg4: bool, arg5: u64) {
        let v0 = LaunchTicketCreated{
            ticket_id       : arg0,
            meme            : 0x1::type_name::with_original_ids<T0>(),
            decimals        : arg1,
            metadata_cap_id : arg2,
            creator         : arg3,
            burnable        : arg4,
            sell_burn_bps   : arg5,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<LaunchTicketCreated>(v0);
    }

    public(friend) fun launch_trade_fees_changed(arg0: u64, arg1: u64) {
        let v0 = LaunchTradeFeesChanged{
            quote_fee_bps : arg0,
            meme_fee_bps  : arg1,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<LaunchTradeFeesChanged>(v0);
    }

    public(friend) fun meme_decimals_set(arg0: u8, arg1: bool) {
        let v0 = MemeDecimalsSet{
            decimals : arg0,
            allowed  : arg1,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<MemeDecimalsSet>(v0);
    }

    public(friend) fun meme_metadata_updated(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = MemeMetadataUpdated{
            launch_id   : arg0,
            name        : arg1,
            description : arg2,
            icon_url    : arg3,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<MemeMetadataUpdated>(v0);
    }

    public(friend) fun metadata_cap_reassigned(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = MetadataCapReassigned{
            launch_id             : arg0,
            blast_metadata_cap_id : arg1,
            recipient             : arg2,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<MetadataCapReassigned>(v0);
    }

    public(friend) fun migrated(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = Migrated{
            launch_id          : arg0,
            meme               : arg1,
            quote              : arg2,
            disposed_meme      : arg3,
            total_supply_after : arg4,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<Migrated>(v0);
    }

    public(friend) fun migration_allocation_paid(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = MigrationAllocationPaid{
            launch_id   : arg0,
            destination : arg1,
            meme        : arg2,
            quote       : arg3,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<MigrationAllocationPaid>(v0);
    }

    public(friend) fun migration_witness_set<T0>(arg0: bool) {
        let v0 = MigrationWitnessSet{
            migration_witness : 0x1::type_name::with_original_ids<T0>(),
            allowed           : arg0,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<MigrationWitnessSet>(v0);
    }

    public(friend) fun opening_round_delivered(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = OpeningRoundDelivered{
            launch_id : arg0,
            bidder    : arg1,
            bid       : arg2,
            meme      : arg3,
            quote     : arg4,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<OpeningRoundDelivered>(v0);
    }

    public(friend) fun opening_round_joined(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = OpeningRoundJoined{
            launch_id : arg0,
            quote     : arg1,
            bids      : arg2,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<OpeningRoundJoined>(v0);
    }

    public(friend) fun opening_round_settled(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = OpeningRoundSettled{
            launch_id : arg0,
            bids      : arg1,
            meme      : arg2,
            quote     : arg3,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<OpeningRoundSettled>(v0);
    }

    public(friend) fun partner_added(arg0: 0x2::object::ID) {
        let v0 = PartnerAdded{partner_id: arg0};
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<PartnerAdded>(v0);
    }

    public(friend) fun partner_removed(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = PartnerRemoved{
            partner_id        : arg0,
            accepted_until_ms : arg1,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<PartnerRemoved>(v0);
    }

    public(friend) fun protocol_allocation_set(arg0: u64, arg1: u64) {
        let v0 = ProtocolAllocationSet{
            meme_bps  : arg0,
            quote_bps : arg1,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<ProtocolAllocationSet>(v0);
    }

    public(friend) fun protocol_fee_share_changed(arg0: u64) {
        let v0 = ProtocolFeeShareChanged{pos0: arg0};
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<ProtocolFeeShareChanged>(v0);
    }

    public(friend) fun protocol_fees_accrued(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ProtocolFeesAccrued{
            launch_id    : arg0,
            meme_amount  : arg1,
            quote_amount : arg2,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<ProtocolFeesAccrued>(v0);
    }

    public(friend) fun protocol_fees_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = ProtocolFeesClaimed{
            launch_id            : arg0,
            treasury             : arg1,
            meme_amount          : arg2,
            quote_amount         : arg3,
            sui_amount           : arg4,
            partner_meme_amount  : arg5,
            partner_quote_amount : arg6,
            partner_sui_amount   : arg7,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<ProtocolFeesClaimed>(v0);
    }

    public(friend) fun quote_set<T0>(arg0: bool) {
        let v0 = QuoteSet{
            quote   : 0x1::type_name::with_original_ids<T0>(),
            allowed : arg0,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<QuoteSet>(v0);
    }

    public(friend) fun sold(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = Sold{
            launch_id          : arg0,
            meme_in_gross      : arg1,
            pending_burn       : arg2,
            quote_out_gross    : arg3,
            protocol_meme_fee  : arg4,
            creator_meme_fee   : arg5,
            protocol_quote_fee : arg6,
            creator_quote_fee  : arg7,
            meme_reserve       : arg8,
            real_quote_reserve : arg9,
        };
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<Sold>(v0);
    }

    public(friend) fun treasury_changed(arg0: address) {
        let v0 = TreasuryChanged{pos0: arg0};
        0x827e04933699da94c23d9ea529f184656738cacdb7962f03be791fd715b76743::blast_events::emit_event<TreasuryChanged>(v0);
    }

    // decompiled from Move bytecode v7
}

