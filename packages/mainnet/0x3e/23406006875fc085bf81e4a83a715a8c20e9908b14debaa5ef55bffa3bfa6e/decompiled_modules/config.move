module 0x3e23406006875fc085bf81e4a83a715a8c20e9908b14debaa5ef55bffa3bfa6e::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        interest_share_bps: u64,
        default_fee_bps: u64,
        fee_recipient: address,
        min_term_ms: u64,
        max_term_ms: u64,
        grace_ms: u64,
        penalty_x: u64,
        max_listing_ms: u64,
        paused: bool,
        allowed_loan: vector<0x1::string::String>,
        keepers: vector<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Migrated has copy, drop {
        from: u64,
        to: u64,
    }

    struct ParamsChanged has copy, drop {
        fee_bps: u64,
        interest_share_bps: u64,
        default_fee_bps: u64,
        fee_recipient: address,
        min_term_ms: u64,
        max_term_ms: u64,
        grace_ms: u64,
        penalty_x: u64,
        max_listing_ms: u64,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    struct LoanCoinsChanged has copy, drop {
        allowed_loan: vector<0x1::string::String>,
    }

    struct KeepersChanged has copy, drop {
        keepers: vector<address>,
    }

    public fun allowed_loan(arg0: &Config) : vector<0x1::string::String> {
        arg0.allowed_loan
    }

    public fun assert_loan_allowed<T0>(arg0: &Config) {
        assert!(is_loan_allowed<T0>(arg0), 13864332243134578697);
    }

    public fun assert_open(arg0: &Config) {
        assert_version(arg0);
        assert!(!arg0.paused, 13864050561999306759);
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 13863206111298977793);
    }

    public fun default_fee_bps(arg0: &Config) : u64 {
        arg0.default_fee_bps
    }

    public fun fee_bps(arg0: &Config) : u64 {
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &Config) : address {
        arg0.fee_recipient
    }

    public fun grace_ms(arg0: &Config) : u64 {
        arg0.grace_ms
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = new_config(v0, arg0);
        0x2::transfer::share_object<Config>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun interest_share_bps(arg0: &Config) : u64 {
        arg0.interest_share_bps
    }

    public fun is_keeper(arg0: &Config, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.keepers, &arg1)
    }

    public fun is_loan_allowed<T0>(arg0: &Config) : bool {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        0x1::vector::contains<0x1::string::String>(&arg0.allowed_loan, &v0)
    }

    public fun keepers(arg0: &Config) : vector<address> {
        arg0.keepers
    }

    public fun max_fee_bps() : u64 {
        100
    }

    public fun max_listing_ms(arg0: &Config) : u64 {
        arg0.max_listing_ms
    }

    public fun max_term_ms(arg0: &Config) : u64 {
        arg0.max_term_ms
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Config) {
        assert!(arg1.version < 1, 13863487629225492483);
        let v0 = Migrated{
            from : arg1.version,
            to   : 1,
        };
        0x2::event::emit<Migrated>(v0);
        arg1.version = 1;
    }

    public fun min_term_ms(arg0: &Config) : u64 {
        arg0.min_term_ms
    }

    fun new_config(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : Config {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"));
        Config{
            id                 : 0x2::object::new(arg1),
            version            : 1,
            fee_bps            : 30,
            interest_share_bps : 1000,
            default_fee_bps    : 30,
            fee_recipient      : arg0,
            min_term_ms        : 86400000,
            max_term_ms        : 2592000000,
            grace_ms           : 3600000,
            penalty_x          : 2,
            max_listing_ms     : 604800000,
            paused             : false,
            allowed_loan       : v0,
            keepers            : vector[],
        }
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun penalty_x(arg0: &Config) : u64 {
        arg0.penalty_x
    }

    public fun set_keepers(arg0: &AdminCap, arg1: &mut Config, arg2: vector<address>) {
        arg1.keepers = arg2;
        let v0 = KeepersChanged{keepers: arg2};
        0x2::event::emit<KeepersChanged>(v0);
    }

    public fun set_loan_coins(arg0: &AdminCap, arg1: &mut Config, arg2: vector<0x1::string::String>) {
        assert!(!0x1::vector::is_empty<0x1::string::String>(&arg2), 13863769314655731717);
        arg1.allowed_loan = arg2;
        let v0 = LoanCoinsChanged{allowed_loan: arg2};
        0x2::event::emit<LoanCoinsChanged>(v0);
    }

    public fun set_params(arg0: &AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        assert!(arg2 <= 100, 13863769181511745541);
        assert!(arg3 <= 3000, 13863769185806712837);
        assert!(arg4 <= 100, 13863769190101680133);
        assert!(arg5 != @0x0, 13863769194396647429);
        assert!(arg6 >= 3600000 && arg6 <= arg7, 13863769198691614725);
        assert!(arg7 <= 31536000000, 13863769202986582021);
        assert!(arg8 <= 86400000, 13863769207281549317);
        assert!(arg9 >= 1 && arg9 <= 5, 13863769211576516613);
        assert!(arg10 > 0 && arg10 <= 2592000000, 13863769215871483909);
        arg1.fee_bps = arg2;
        arg1.interest_share_bps = arg3;
        arg1.default_fee_bps = arg4;
        arg1.fee_recipient = arg5;
        arg1.min_term_ms = arg6;
        arg1.max_term_ms = arg7;
        arg1.grace_ms = arg8;
        arg1.penalty_x = arg9;
        arg1.max_listing_ms = arg10;
        let v0 = ParamsChanged{
            fee_bps            : arg2,
            interest_share_bps : arg3,
            default_fee_bps    : arg4,
            fee_recipient      : arg5,
            min_term_ms        : arg6,
            max_term_ms        : arg7,
            grace_ms           : arg8,
            penalty_x          : arg9,
            max_listing_ms     : arg10,
        };
        0x2::event::emit<ParamsChanged>(v0);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

