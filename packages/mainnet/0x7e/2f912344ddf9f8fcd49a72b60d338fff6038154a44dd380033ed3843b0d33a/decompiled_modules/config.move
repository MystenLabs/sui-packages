module 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::config {
    struct Config has key {
        id: 0x2::object::UID,
        creation_fee_mist: u64,
        fees: 0x2::balance::Balance<0x2::sui::SUI>,
        open_slots: 0x2::table::Table<address, bool>,
        launcher_cap: 0x1::option::Option<0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::LauncherCap>,
        starting_sqrt_price: u128,
        tick_lower: u32,
        paused: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchRequest has key {
        id: 0x2::object::UID,
        creator: address,
    }

    public(friend) fun assert_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::paused());
    }

    public(friend) fun borrow_launcher_cap(arg0: &Config) : &0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::LauncherCap {
        assert!(0x1::option::is_some<0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::LauncherCap>(&arg0.launcher_cap), 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::launcher_cap_missing());
        0x1::option::borrow<0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::LauncherCap>(&arg0.launcher_cap)
    }

    public fun cancel_request(arg0: &mut Config, arg1: LaunchRequest, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.creator, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::not_creator());
        let v0 = consume_request(arg1);
        clear_open_slot(arg0, v0);
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_launch_request_cancelled(v0);
    }

    public(friend) fun clear_open_slot(arg0: &mut Config, arg1: address) {
        assert!(has_open_slot(arg0, arg1), 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::open_slot_missing());
        0x2::table::remove<address, bool>(&mut arg0.open_slots, arg1);
    }

    public(friend) fun consume_request(arg0: LaunchRequest) : address {
        let LaunchRequest {
            id      : v0,
            creator : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun creation_fee_mist(arg0: &Config) : u64 {
        arg0.creation_fee_mist
    }

    public(friend) fun has_open_slot(arg0: &Config, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.open_slots, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                  : 0x2::object::new(arg0),
            creation_fee_mist   : 1000000000,
            fees                : 0x2::balance::zero<0x2::sui::SUI>(),
            open_slots          : 0x2::table::new<address, bool>(arg0),
            launcher_cap        : 0x1::option::none<0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::LauncherCap>(),
            starting_sqrt_price : 31911330656786346,
            tick_lower          : 4294840096,
            paused              : false,
        };
        0x2::transfer::share_object<Config>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun install_launcher_cap(arg0: &mut Config, arg1: &AdminCap, arg2: 0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::LauncherCap) {
        assert!(0x1::option::is_none<0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::LauncherCap>(&arg0.launcher_cap), 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::launcher_cap_exists());
        0x1::option::fill<0x99ad8d11a4d4886e2af7f22be2f63526a4a880835b51f5957a7dda73bee74ca7::distributor::LauncherCap>(&mut arg0.launcher_cap, arg2);
    }

    public fun max_creation_fee_mist() : u64 {
        100000000000
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun pool_fee_rate() : u64 {
        100000
    }

    public fun request_creator(arg0: &LaunchRequest) : address {
        arg0.creator
    }

    public fun request_launch(arg0: &mut Config, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_not_paused(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg0.creation_fee_mist, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::invalid_fee());
        assert!(!has_open_slot(arg0, v0), 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::open_slot_exists());
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = LaunchRequest{
            id      : 0x2::object::new(arg2),
            creator : v0,
        };
        set_open_slot(arg0, v0);
        0x2::transfer::share_object<LaunchRequest>(v1);
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_launch_requested(v0, arg0.creation_fee_mist, 0x2::object::id<LaunchRequest>(&v1));
    }

    public fun set_creation_fee(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 > 0 && arg2 <= 100000000000, 0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::errors::invalid_fee());
        arg0.creation_fee_mist = arg2;
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_creation_fee_updated(arg0.creation_fee_mist, arg2);
    }

    fun set_open_slot(arg0: &mut Config, arg1: address) {
        if (!0x2::table::contains<address, bool>(&arg0.open_slots, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.open_slots, arg1, true);
        };
    }

    public fun set_paused(arg0: &mut Config, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_pause_updated(arg2);
    }

    public fun set_starting_price(arg0: &mut Config, arg1: &AdminCap, arg2: u128, arg3: u32) {
        arg0.starting_sqrt_price = arg2;
        arg0.tick_lower = arg3;
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_starting_price_updated(arg0.starting_sqrt_price, arg2, arg0.tick_lower, arg3);
    }

    public fun starting_sqrt_price(arg0: &Config) : u128 {
        arg0.starting_sqrt_price
    }

    public fun tick_lower(arg0: &Config) : u32 {
        arg0.tick_lower
    }

    public fun tick_spacing() : u32 {
        200
    }

    public fun tick_upper() : u32 {
        443600
    }

    public fun withdraw_fees(arg0: &mut Config, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.fees);
        0x7e2f912344ddf9f8fcd49a72b60d338fff6038154a44dd380033ed3843b0d33a::events::emit_fees_withdrawn(v0, 0x2::tx_context::sender(arg2));
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.fees, v0), arg2)
    }

    // decompiled from Move bytecode v7
}

