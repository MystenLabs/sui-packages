module 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::events {
    struct MemeDecimalsAllowed has copy, drop {
        decimals: u8,
        allowed: bool,
    }

    struct QuoteAllowed<phantom T0> has copy, drop {
        allowed: bool,
    }

    struct CreatorCapsClaimed<phantom T0, phantom T1> has copy, drop {
        curve_fee_cap_id: 0x2::object::ID,
        creator_metadata_cap_id: 0x2::object::ID,
    }

    struct CurveFeeCapReassigned<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        curve_fee_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct CreatorMetadataCapReassigned<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        creator_metadata_cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct MemeMetadataUpdated<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
    }

    struct LaunchTicketCreated<phantom T0> has copy, drop {
        ticket_id: 0x2::object::ID,
        decimals: u8,
        metadata_cap_id: 0x2::object::ID,
        creator: 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::creator_authority::CreatorRecipient,
        burnable: bool,
        sell_burn_bps: u64,
    }

    struct LaunchCreated<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        ticket_id: 0x2::object::ID,
        venue: 0x1::type_name::TypeName,
        lp_fee_split: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::fee_split::FeeSplit,
        virtual_quote: u64,
        graduation_target: u64,
        quote_fee_bps: u64,
        meme_fee_bps: u64,
        allocation_plan: 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::AllocationPlan,
        opening_round_ms: u64,
        creation_fee: u64,
        partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct LaunchShared<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        public_start_ms: u64,
    }

    struct OpeningRoundJoined<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        quote_amount: u64,
        bids: u64,
    }

    struct OpeningRoundSettled<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        bids: u64,
        meme_amount: u64,
        quote_amount: u64,
    }

    struct OpeningRoundDelivered<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        bidder: address,
        bid: u64,
        meme_amount: u64,
        quote_amount: u64,
    }

    struct Bought<phantom T0, phantom T1> has copy, drop {
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

    struct Sold<phantom T0, phantom T1> has copy, drop {
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

    struct MigrationAllocationPaid<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        destination: address,
        meme_amount: u64,
        quote_amount: u64,
        meme_vesting_id: 0x1::option::Option<0x2::object::ID>,
        quote_vesting_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Migrated<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        meme_amount: u64,
        quote_amount: u64,
        disposed_meme: u64,
        total_supply_after: u64,
    }

    struct CreatorFeesClaimed<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        meme_amount: u64,
        quote_amount: u64,
    }

    struct ProtocolFeesAccrued<phantom T0, phantom T1> has copy, drop {
        launch_id: 0x2::object::ID,
        meme_amount: u64,
        quote_amount: u64,
    }

    public(friend) fun bought<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = Bought<T0, T1>{
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
        0x2::event::emit<Bought<T0, T1>>(v0);
    }

    public(friend) fun creator_caps_claimed<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = CreatorCapsClaimed<T0, T1>{
            curve_fee_cap_id        : arg0,
            creator_metadata_cap_id : arg1,
        };
        0x2::event::emit<CreatorCapsClaimed<T0, T1>>(v0);
    }

    public(friend) fun creator_fees_claimed<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = CreatorFeesClaimed<T0, T1>{
            launch_id    : arg0,
            meme_amount  : arg1,
            quote_amount : arg2,
        };
        0x2::event::emit<CreatorFeesClaimed<T0, T1>>(v0);
    }

    public(friend) fun creator_metadata_cap_reassigned<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = CreatorMetadataCapReassigned<T0, T1>{
            launch_id               : arg0,
            creator_metadata_cap_id : arg1,
            recipient               : arg2,
        };
        0x2::event::emit<CreatorMetadataCapReassigned<T0, T1>>(v0);
    }

    public(friend) fun curve_fee_cap_reassigned<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address) {
        let v0 = CurveFeeCapReassigned<T0, T1>{
            launch_id        : arg0,
            curve_fee_cap_id : arg1,
            recipient        : arg2,
        };
        0x2::event::emit<CurveFeeCapReassigned<T0, T1>>(v0);
    }

    public(friend) fun launch_created<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0xdbbf98f13531972697c48a2fca51c508b24c63bc2b47b06af8bdf033416bbb50::fee_split::FeeSplit, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::allocation::AllocationPlan, arg9: u64, arg10: u64, arg11: 0x1::option::Option<0x2::object::ID>) {
        let v0 = LaunchCreated<T0, T1>{
            launch_id         : arg0,
            ticket_id         : arg1,
            venue             : arg2,
            lp_fee_split      : arg3,
            virtual_quote     : arg4,
            graduation_target : arg5,
            quote_fee_bps     : arg6,
            meme_fee_bps      : arg7,
            allocation_plan   : arg8,
            opening_round_ms  : arg9,
            creation_fee      : arg10,
            partner_id        : arg11,
        };
        0x2::event::emit<LaunchCreated<T0, T1>>(v0);
    }

    public(friend) fun launch_shared<T0, T1>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = LaunchShared<T0, T1>{
            launch_id       : arg0,
            public_start_ms : arg1,
        };
        0x2::event::emit<LaunchShared<T0, T1>>(v0);
    }

    public(friend) fun launch_ticket_created<T0>(arg0: 0x2::object::ID, arg1: u8, arg2: 0x2::object::ID, arg3: 0x9712da9bb61d0d4485b791761420e890c4269d104af0d18b15ac3a4999c7997b::creator_authority::CreatorRecipient, arg4: bool, arg5: u64) {
        let v0 = LaunchTicketCreated<T0>{
            ticket_id       : arg0,
            decimals        : arg1,
            metadata_cap_id : arg2,
            creator         : arg3,
            burnable        : arg4,
            sell_burn_bps   : arg5,
        };
        0x2::event::emit<LaunchTicketCreated<T0>>(v0);
    }

    public(friend) fun meme_decimals_allowed(arg0: u8, arg1: bool) {
        let v0 = MemeDecimalsAllowed{
            decimals : arg0,
            allowed  : arg1,
        };
        0x2::event::emit<MemeDecimalsAllowed>(v0);
    }

    public(friend) fun meme_metadata_updated<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = MemeMetadataUpdated<T0, T1>{
            launch_id   : arg0,
            name        : arg1,
            description : arg2,
            icon_url    : arg3,
        };
        0x2::event::emit<MemeMetadataUpdated<T0, T1>>(v0);
    }

    public(friend) fun migrated<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = Migrated<T0, T1>{
            launch_id          : arg0,
            meme_amount        : arg1,
            quote_amount       : arg2,
            disposed_meme      : arg3,
            total_supply_after : arg4,
        };
        0x2::event::emit<Migrated<T0, T1>>(v0);
    }

    public(friend) fun migration_allocation_paid<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<0x2::object::ID>) {
        let v0 = MigrationAllocationPaid<T0, T1>{
            launch_id        : arg0,
            destination      : arg1,
            meme_amount      : arg2,
            quote_amount     : arg3,
            meme_vesting_id  : arg4,
            quote_vesting_id : arg5,
        };
        0x2::event::emit<MigrationAllocationPaid<T0, T1>>(v0);
    }

    public(friend) fun opening_round_delivered<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = OpeningRoundDelivered<T0, T1>{
            launch_id    : arg0,
            bidder       : arg1,
            bid          : arg2,
            meme_amount  : arg3,
            quote_amount : arg4,
        };
        0x2::event::emit<OpeningRoundDelivered<T0, T1>>(v0);
    }

    public(friend) fun opening_round_joined<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = OpeningRoundJoined<T0, T1>{
            launch_id    : arg0,
            quote_amount : arg1,
            bids         : arg2,
        };
        0x2::event::emit<OpeningRoundJoined<T0, T1>>(v0);
    }

    public(friend) fun opening_round_settled<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = OpeningRoundSettled<T0, T1>{
            launch_id    : arg0,
            bids         : arg1,
            meme_amount  : arg2,
            quote_amount : arg3,
        };
        0x2::event::emit<OpeningRoundSettled<T0, T1>>(v0);
    }

    public(friend) fun protocol_fees_accrued<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = ProtocolFeesAccrued<T0, T1>{
            launch_id    : arg0,
            meme_amount  : arg1,
            quote_amount : arg2,
        };
        0x2::event::emit<ProtocolFeesAccrued<T0, T1>>(v0);
    }

    public(friend) fun quote_allowed<T0>(arg0: bool) {
        let v0 = QuoteAllowed<T0>{allowed: arg0};
        0x2::event::emit<QuoteAllowed<T0>>(v0);
    }

    public(friend) fun sold<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = Sold<T0, T1>{
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
        0x2::event::emit<Sold<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v7
}

