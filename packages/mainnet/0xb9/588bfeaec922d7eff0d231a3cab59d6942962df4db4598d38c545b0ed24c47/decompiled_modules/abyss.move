module 0xb9588bfeaec922d7eff0d231a3cab59d6942962df4db4598d38c545b0ed24c47::abyss {
    struct Abyss has key {
        id: 0x2::object::UID,
        total_received: u64,
        total_actions: u64,
    }

    struct FeeReceived has copy, drop {
        action: vector<u8>,
        amount: u64,
        total_received: u64,
        received_at: u64,
    }

    fun deposit(arg0: &mut Abyss, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        assert!(v0 >= arg2, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg1, @0xe0117fba317d2267b8d90adca1fe79eceeec756bcf54edf04cc29ee5306ab32e);
        arg0.total_received = arg0.total_received + v0;
        arg0.total_actions = arg0.total_actions + 1;
        let v1 = FeeReceived{
            action         : arg3,
            amount         : v0,
            total_received : arg0.total_received,
            received_at    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<FeeReceived>(v1);
    }

    public fun fee_cast() : u64 {
        1000
    }

    public fun fee_dock() : u64 {
        500000
    }

    public fun fee_harbor() : u64 {
        50000
    }

    public fun fee_lh_kill() : u64 {
        1000000000000
    }

    public fun fee_lh_visit() : u64 {
        1000
    }

    public fun fee_read() : u64 {
        1000
    }

    public fun fee_siren() : u64 {
        30000
    }

    public fun fee_vessel() : u64 {
        10000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Abyss{
            id             : 0x2::object::new(arg0),
            total_received : 0,
            total_actions  : 0,
        };
        0x2::transfer::share_object<Abyss>(v0);
    }

    public fun receive_cast(arg0: &mut Abyss, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        deposit(arg0, arg1, 1000, b"cast:sound", arg2, arg3);
    }

    public fun receive_dock(arg0: &mut Abyss, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        deposit(arg0, arg1, 500000, b"dock:open", arg2, arg3);
    }

    public fun receive_harbor(arg0: &mut Abyss, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        deposit(arg0, arg1, 50000, b"harbor:open", arg2, arg3);
    }

    public fun receive_lh_kill(arg0: &mut Abyss, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        deposit(arg0, arg1, 1000000000000, b"lighthouse:kill", arg2, arg3);
    }

    public fun receive_lh_visit(arg0: &mut Abyss, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        deposit(arg0, arg1, 1000, b"lighthouse:visit", arg2, arg3);
    }

    public fun receive_read(arg0: &mut Abyss, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        deposit(arg0, arg1, 1000, b"cast:read", arg2, arg3);
    }

    public fun receive_siren(arg0: &mut Abyss, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        deposit(arg0, arg1, 30000, b"siren:sound", arg2, arg3);
    }

    public fun receive_vessel(arg0: &mut Abyss, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        deposit(arg0, arg1, 10000, b"vessel:launch", arg2, arg3);
    }

    public fun total_actions(arg0: &Abyss) : u64 {
        arg0.total_actions
    }

    public fun total_received(arg0: &Abyss) : u64 {
        arg0.total_received
    }

    // decompiled from Move bytecode v7
}

