module 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::center {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct BiglottoCenter<phantom T0> has key {
        id: 0x2::object::UID,
        versions: 0x2::vec_set::VecSet<u64>,
        jackpot: 0x2::balance::Balance<T0>,
        reserve: 0x2::balance::Balance<T0>,
        managers: 0x2::vec_set::VecSet<address>,
        payment_config: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::payment::PaymentConfig,
        draw_config: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::draw::DrawConfig,
        payouts_config: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::payouts::PayoutsConfig,
        jackpot_combination: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::combination::Combination,
        bls_pub_key: vector<u8>,
        current_round_id: u64,
    }

    public fun id<T0>(arg0: &BiglottoCenter<T0>) : 0x2::object::ID {
        0x2::object::id<BiglottoCenter<T0>>(arg0)
    }

    public fun add_manager<T0>(arg0: &AdminCap, arg1: &mut BiglottoCenter<T0>, arg2: address) {
        assert_valid_package_version<T0>(arg1);
        0x2::vec_set::insert<address>(&mut arg1.managers, arg2);
    }

    public fun add_version<T0>(arg0: &AdminCap, arg1: &mut BiglottoCenter<T0>, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.versions, arg2);
    }

    public fun assert_sender_is_manager<T0>(arg0: &BiglottoCenter<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    public fun assert_valid_package_version<T0>(arg0: &BiglottoCenter<T0>) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(&arg0.versions, &v0)) {
            err_invalid_package_version();
        };
    }

    public fun bls_pub_key<T0>(arg0: &BiglottoCenter<T0>) : &vector<u8> {
        &arg0.bls_pub_key
    }

    public fun create<T0>(arg0: &AdminCap, arg1: vector<address>, arg2: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::payment::PaymentConfig, arg3: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::draw::DrawConfig, arg4: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::payouts::PayoutsConfig, arg5: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::combination::Combination, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = BiglottoCenter<T0>{
            id                  : 0x2::object::new(arg7),
            versions            : 0x2::vec_set::singleton<u64>(package_version()),
            jackpot             : 0x2::balance::zero<T0>(),
            reserve             : 0x2::balance::zero<T0>(),
            managers            : 0x2::vec_set::from_keys<address>(arg1),
            payment_config      : arg2,
            draw_config         : arg3,
            payouts_config      : arg4,
            jackpot_combination : arg5,
            bls_pub_key         : arg6,
            current_round_id    : 0,
        };
        0x2::transfer::share_object<BiglottoCenter<T0>>(v0);
    }

    public fun deposit_to_jackpot<T0>(arg0: &mut BiglottoCenter<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert_valid_package_version<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.jackpot, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit_to_reserve<T0>(arg0: &mut BiglottoCenter<T0>, arg1: 0x2::coin::Coin<T0>) {
        assert_valid_package_version<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun draw_config<T0>(arg0: &BiglottoCenter<T0>) : &0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::draw::DrawConfig {
        &arg0.draw_config
    }

    fun err_invalid_package_version() {
        abort 0
    }

    fun err_not_enough_to_withdraw() {
        abort 1
    }

    fun err_sender_is_not_manager() {
        abort 2
    }

    public(friend) fun get_current_round_id<T0>(arg0: &mut BiglottoCenter<T0>) : u64 {
        assert_valid_package_version<T0>(arg0);
        arg0.current_round_id = arg0.current_round_id + 1;
        arg0.current_round_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun jackpot_combination<T0>(arg0: &BiglottoCenter<T0>) : 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::combination::Combination {
        arg0.jackpot_combination
    }

    public fun package_version() : u64 {
        1
    }

    public fun payment_config<T0>(arg0: &BiglottoCenter<T0>) : &0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::payment::PaymentConfig {
        &arg0.payment_config
    }

    public fun payouts_config<T0>(arg0: &BiglottoCenter<T0>) : &0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::payouts::PayoutsConfig {
        &arg0.payouts_config
    }

    public fun remove_manager<T0>(arg0: &AdminCap, arg1: &mut BiglottoCenter<T0>, arg2: address) {
        assert_valid_package_version<T0>(arg1);
        0x2::vec_set::remove<address>(&mut arg1.managers, &arg2);
    }

    public fun remove_version<T0>(arg0: &AdminCap, arg1: &mut BiglottoCenter<T0>, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.versions, &arg2);
    }

    public fun ticket_cost<T0>(arg0: &BiglottoCenter<T0>) : u64 {
        0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::payment::ticket_cost(payment_config<T0>(arg0))
    }

    public fun update_draw_config<T0>(arg0: &AdminCap, arg1: &mut BiglottoCenter<T0>, arg2: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::draw::DrawConfig) {
        assert_valid_package_version<T0>(arg1);
        arg1.draw_config = arg2;
    }

    public fun update_payment_config<T0>(arg0: &AdminCap, arg1: &mut BiglottoCenter<T0>, arg2: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::payment::PaymentConfig) {
        assert_valid_package_version<T0>(arg1);
        arg1.payment_config = arg2;
    }

    public fun update_payouts_config<T0>(arg0: &AdminCap, arg1: &mut BiglottoCenter<T0>, arg2: 0x6ae4151ed5314f8eb8b7f21e28733491ebe3a973870c11ff729f7d3d289973cc::payouts::PayoutsConfig) {
        assert_valid_package_version<T0>(arg1);
        arg1.payouts_config = arg2;
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut BiglottoCenter<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version<T0>(arg1);
        0x2::coin::from_balance<T0>(withdraw_from_reserve<T0>(arg1, arg2), arg3)
    }

    public(friend) fun withdraw_from_jackpot<T0>(arg0: &mut BiglottoCenter<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version<T0>(arg0);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.jackpot), arg1)
    }

    public(friend) fun withdraw_from_reserve<T0>(arg0: &mut BiglottoCenter<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert_valid_package_version<T0>(arg0);
        if (0x2::balance::value<T0>(&arg0.reserve) < arg1) {
            err_not_enough_to_withdraw();
        };
        0x2::balance::split<T0>(&mut arg0.reserve, arg1)
    }

    // decompiled from Move bytecode v6
}

