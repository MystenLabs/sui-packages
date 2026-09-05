module 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events {
    struct LaunchRequested has copy, drop {
        creator: address,
        fee: u64,
        request_id: 0x2::object::ID,
    }

    struct LaunchRequestCancelled has copy, drop {
        creator: address,
    }

    struct PendingLaunchCancelled has copy, drop {
        creator: address,
    }

    struct CreationFeeUpdated has copy, drop {
        old_fee: u64,
        new_fee: u64,
    }

    struct StartingPriceUpdated has copy, drop {
        old_sqrt_price: u128,
        new_sqrt_price: u128,
        old_tick_lower: u32,
        new_tick_lower: u32,
    }

    struct PauseUpdated has copy, drop {
        paused: bool,
    }

    struct FeesWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TokenRegistered has copy, drop {
        creator: address,
        pending_id: 0x2::object::ID,
    }

    struct Launched has copy, drop {
        creator: address,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        locker_id: 0x2::object::ID,
        fee_config_id: 0x2::object::ID,
        fee_recipient: address,
        quote_protocol_fee_bps: u64,
        token_side_policy: 0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::TokenSidePolicy,
        supply: u64,
        sqrt_price: u128,
    }

    struct MetadataUpdated has copy, drop {
        launch_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
    }

    public(friend) fun emit_creation_fee_updated(arg0: u64, arg1: u64) {
        let v0 = CreationFeeUpdated{
            old_fee : arg0,
            new_fee : arg1,
        };
        0x2::event::emit<CreationFeeUpdated>(v0);
    }

    public(friend) fun emit_fees_withdrawn(arg0: u64, arg1: address) {
        let v0 = FeesWithdrawn{
            amount    : arg0,
            recipient : arg1,
        };
        0x2::event::emit<FeesWithdrawn>(v0);
    }

    public(friend) fun emit_launch_request_cancelled(arg0: address) {
        let v0 = LaunchRequestCancelled{creator: arg0};
        0x2::event::emit<LaunchRequestCancelled>(v0);
    }

    public(friend) fun emit_launch_requested(arg0: address, arg1: u64, arg2: 0x2::object::ID) {
        let v0 = LaunchRequested{
            creator    : arg0,
            fee        : arg1,
            request_id : arg2,
        };
        0x2::event::emit<LaunchRequested>(v0);
    }

    public(friend) fun emit_launched(arg0: address, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: address, arg6: u64, arg7: 0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::TokenSidePolicy, arg8: u64, arg9: u128) {
        let v0 = Launched{
            creator                : arg0,
            pool_id                : arg1,
            position_id            : arg2,
            locker_id              : arg3,
            fee_config_id          : arg4,
            fee_recipient          : arg5,
            quote_protocol_fee_bps : arg6,
            token_side_policy      : arg7,
            supply                 : arg8,
            sqrt_price             : arg9,
        };
        0x2::event::emit<Launched>(v0);
    }

    public(friend) fun emit_metadata_updated(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        let v0 = MetadataUpdated{
            launch_id   : arg0,
            creator     : arg1,
            name        : arg2,
            description : arg3,
            icon_url    : arg4,
        };
        0x2::event::emit<MetadataUpdated>(v0);
    }

    public(friend) fun emit_pause_updated(arg0: bool) {
        let v0 = PauseUpdated{paused: arg0};
        0x2::event::emit<PauseUpdated>(v0);
    }

    public(friend) fun emit_pending_launch_cancelled(arg0: address) {
        let v0 = PendingLaunchCancelled{creator: arg0};
        0x2::event::emit<PendingLaunchCancelled>(v0);
    }

    public(friend) fun emit_starting_price_updated(arg0: u128, arg1: u128, arg2: u32, arg3: u32) {
        let v0 = StartingPriceUpdated{
            old_sqrt_price : arg0,
            new_sqrt_price : arg1,
            old_tick_lower : arg2,
            new_tick_lower : arg3,
        };
        0x2::event::emit<StartingPriceUpdated>(v0);
    }

    public(friend) fun emit_token_registered(arg0: address, arg1: 0x2::object::ID) {
        let v0 = TokenRegistered{
            creator    : arg0,
            pending_id : arg1,
        };
        0x2::event::emit<TokenRegistered>(v0);
    }

    // decompiled from Move bytecode v7
}

