module 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::x_up {
    struct NewXUPEvent has copy, drop {
        nft_id: 0x2::object::ID,
        start_time_ms: u64,
        duration_ms: u64,
        amount: u64,
        owner: address,
    }

    struct ReleaseXUPEvent has copy, drop {
        nft_id: 0x2::object::ID,
        amount: u64,
        owner: address,
    }

    struct X_UP has drop {
        dummy_field: bool,
    }

    struct XUP has key {
        id: 0x2::object::UID,
        start_time_ms: u64,
        duration_ms: u64,
        claimed_amount: u64,
        amount: u64,
    }

    struct UPTreasury has store, key {
        id: 0x2::object::UID,
        up_balance: 0x2::balance::Balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>,
        xup_circulating: u64,
        claiming_allowed: bool,
    }

    struct UnlockXUPCost<phantom T0> has store {
        coin_type: 0x1::type_name::TypeName,
        coin_balance: 0x2::balance::Balance<T0>,
        conversion_rate: u64,
    }

    public fun destroy_empty(arg0: XUP) {
        let XUP {
            id             : v0,
            start_time_ms  : _,
            duration_ms    : _,
            claimed_amount : _,
            amount         : v4,
        } = arg0;
        if (v4 > 0) {
            err_cannot_destroy_non_empty_lock();
        };
        0x2::object::delete(v0);
    }

    public fun new(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_sender_is_manager(arg1, arg6);
        let v0 = new_helper(arg0, arg2, arg3, arg4, arg6);
        let v1 = NewXUPEvent{
            nft_id        : 0x2::object::id<XUP>(&v0),
            start_time_ms : arg2,
            duration_ms   : arg3,
            amount        : arg4,
            owner         : arg5,
        };
        0x2::event::emit<NewXUPEvent>(v1);
        0x2::transfer::transfer<XUP>(v0, arg5);
    }

    public fun add_unlock_type<T0>(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_sender_is_manager(arg1, arg3);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = UnlockXUPCost<T0>{
            coin_type       : v0,
            coin_balance    : 0x2::balance::zero<T0>(),
            conversion_rate : arg2,
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, UnlockXUPCost<T0>>(&mut arg0.id, v0, v1);
    }

    public fun amount(arg0: &XUP) : u64 {
        arg0.amount
    }

    public fun amount_unclaimed(arg0: &XUP) : u64 {
        amount(arg0) - claimed_amount(arg0)
    }

    public fun assert_claim_enabled(arg0: &UPTreasury) {
        if (!arg0.claiming_allowed) {
            err_claim_not_enabled();
        };
    }

    public(friend) fun borrow_balance_mut(arg0: &mut UPTreasury) : &mut 0x2::balance::Balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP> {
        &mut arg0.up_balance
    }

    public fun claim_all(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: XUP, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP> {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        assert_claim_enabled(arg0);
        if (0x2::clock::timestamp_ms(arg3) < end_time_ms(&arg2)) {
            err_not_vested();
        };
        let XUP {
            id             : v0,
            start_time_ms  : _,
            duration_ms    : _,
            claimed_amount : v3,
            amount         : v4,
        } = arg2;
        0x2::object::delete(v0);
        let v5 = v4 - v3;
        decrease_xup_circulating(arg0, v5);
        0x2::coin::from_balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(0x2::balance::split<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&mut arg0.up_balance, v5), arg4)
    }

    public fun claimed_amount(arg0: &XUP) : u64 {
        arg0.claimed_amount
    }

    public fun compute_vested_amount(arg0: &XUP, arg1: u64) : u64 {
        if (arg1 < start_time_ms(arg0)) {
            0
        } else if (arg1 >= end_time_ms(arg0)) {
            amount(arg0)
        } else {
            0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::ceil(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::mul(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::div(0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(arg1 - start_time_ms(arg0)), 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(arg0.duration_ms)), 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::decimal::from(amount(arg0))))
        }
    }

    fun decrease_xup_circulating(arg0: &mut UPTreasury, arg1: u64) {
        arg0.xup_circulating = arg0.xup_circulating - arg1;
    }

    public fun duration(arg0: &XUP) : u64 {
        arg0.duration_ms
    }

    public fun enable_claiming(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: &0x2::tx_context::TxContext) {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_sender_is_manager(arg1, arg2);
        arg0.claiming_allowed = true;
    }

    public fun end_time_ms(arg0: &XUP) : u64 {
        arg0.start_time_ms + arg0.duration_ms
    }

    fun err_cannot_destroy_non_empty_lock() {
        abort 4
    }

    fun err_claim_not_enabled() {
        abort 0
    }

    fun err_invalid_amount() {
        abort 5
    }

    fun err_invalid_duration() {
        abort 1
    }

    fun err_not_enough_up() {
        abort 2
    }

    fun err_not_vested() {
        abort 6
    }

    fun err_zero_releaseable_amount() {
        abort 3
    }

    public fun immediate_claim(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: XUP, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP> {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        assert_claim_enabled(arg0);
        let XUP {
            id             : v0,
            start_time_ms  : _,
            duration_ms    : _,
            claimed_amount : v3,
            amount         : v4,
        } = arg2;
        0x2::object::delete(v0);
        let v5 = (v4 - v3) * 4 / 10;
        decrease_xup_circulating(arg0, v5);
        0x2::coin::from_balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(0x2::balance::split<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&mut arg0.up_balance, v5), arg3)
    }

    fun increase_xup_circulating(arg0: &mut UPTreasury, arg1: u64) {
        if (0x2::balance::value<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&arg0.up_balance) < arg1 + arg0.xup_circulating) {
            err_not_enough_up();
        };
        arg0.xup_circulating = arg0.xup_circulating + arg1;
    }

    fun init(arg0: X_UP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<X_UP>(arg0, arg1);
        let v1 = 0x2::display::new<XUP>(&v0, arg1);
        0x2::display::add<XUP>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"UP Airdrop Allocation NFT"));
        0x2::display::add<XUP>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://svgenerator.doubleupdata.store/convert?amount={amount}&denom=UP"));
        0x2::display::add<XUP>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"An NFT representing an allocation of UP tokens."));
        0x2::display::update_version<XUP>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<XUP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = UPTreasury{
            id               : 0x2::object::new(arg1),
            up_balance       : 0x2::balance::zero<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(),
            xup_circulating  : 0,
            claiming_allowed : false,
        };
        0x2::transfer::public_share_object<UPTreasury>(v2);
    }

    public fun new_external<T0: drop>(arg0: &mut UPTreasury, arg1: &mut 0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: T0, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_package_is_allowed<T0>(arg1, arg2);
        let v0 = new_helper(arg0, arg3, arg4, arg5, arg7);
        let v1 = NewXUPEvent{
            nft_id        : 0x2::object::id<XUP>(&v0),
            start_time_ms : arg3,
            duration_ms   : arg4,
            amount        : arg5,
            owner         : arg6,
        };
        0x2::event::emit<NewXUPEvent>(v1);
        0x2::transfer::transfer<XUP>(v0, arg6);
    }

    fun new_helper(arg0: &mut UPTreasury, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : XUP {
        if (arg2 == 0) {
            err_invalid_duration();
        };
        if (arg3 == 0) {
            err_invalid_amount();
        };
        increase_xup_circulating(arg0, arg3);
        XUP{
            id             : 0x2::object::new(arg4),
            start_time_ms  : arg1,
            duration_ms    : arg2,
            claimed_amount : 0,
            amount         : arg3,
        }
    }

    public(friend) fun new_internal(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        let v0 = new_helper(arg0, arg2, arg3, arg4, arg6);
        let v1 = NewXUPEvent{
            nft_id        : 0x2::object::id<XUP>(&v0),
            start_time_ms : arg2,
            duration_ms   : arg3,
            amount        : arg4,
            owner         : arg5,
        };
        0x2::event::emit<NewXUPEvent>(v1);
        0x2::transfer::transfer<XUP>(v0, arg5);
    }

    public fun releasable_amount(arg0: &XUP, arg1: &0x2::clock::Clock) : u64 {
        let v0 = compute_vested_amount(arg0, 0x2::clock::timestamp_ms(arg1));
        let v1 = claimed_amount(arg0);
        if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun release(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: &mut XUP, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP> {
        abort 0
    }

    public fun remove_unlock_type<T0>(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_sender_is_manager(arg1, arg2);
        let UnlockXUPCost {
            coin_type       : _,
            coin_balance    : v1,
            conversion_rate : _,
        } = 0x2::dynamic_field::remove<0x1::type_name::TypeName, UnlockXUPCost<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public fun remove_up(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP> {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_sender_is_manager(arg1, arg3);
        if (0x2::balance::value<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&arg0.up_balance) - arg2 < arg0.xup_circulating) {
            err_not_enough_up();
        };
        0x2::coin::from_balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(0x2::balance::split<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&mut arg0.up_balance, arg2), arg3)
    }

    public(friend) fun set_amount(arg0: &mut XUP, arg1: u64) {
        arg0.amount = arg1;
    }

    public fun set_amount_external<T0: drop>(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: T0, arg3: &mut XUP, arg4: u64) {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_package_is_allowed<T0>(arg1, arg2);
        if (arg4 > arg3.amount) {
            increase_xup_circulating(arg0, arg4 - arg3.amount);
        } else {
            decrease_xup_circulating(arg0, arg3.amount - arg4);
        };
        arg3.amount = arg4;
    }

    public fun start_time_ms(arg0: &XUP) : u64 {
        arg0.start_time_ms
    }

    public fun top_up(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: 0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>, arg3: &0x2::tx_context::TxContext) {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_sender_is_manager(arg1, arg3);
        0x2::balance::join<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&mut arg0.up_balance, 0x2::coin::into_balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(arg2));
    }

    public fun unlock_faster<T0>(arg0: &mut UPTreasury, arg1: &0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UpAdmin, arg2: &mut XUP, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP> {
        0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::assert_valid_version(arg1);
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, UnlockXUPCost<T0>>(&mut arg0.id, 0x1::type_name::get<T0>());
        let v1 = 0x2::coin::value<T0>(&arg3) * v0.conversion_rate;
        if (v1 > arg2.amount - arg2.claimed_amount) {
            err_not_enough_up();
        };
        arg2.amount = arg2.amount - v1;
        0x2::balance::join<T0>(&mut v0.coin_balance, 0x2::coin::into_balance<T0>(arg3));
        let v2 = ReleaseXUPEvent{
            nft_id : 0x2::object::uid_to_inner(&arg2.id),
            amount : v1,
            owner  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ReleaseXUPEvent>(v2);
        decrease_xup_circulating(arg0, v1);
        0x2::coin::from_balance<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(0x2::balance::split<0x87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP>(&mut arg0.up_balance, v1), arg4)
    }

    // decompiled from Move bytecode v6
}

