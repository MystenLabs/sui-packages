module 0xd7de1dd1a63b2ed1eef7d5eeda3a5f7d8ce3ce36c6407886c3070a96e49271b6::xdrop {
    struct XDROP has drop {
        dummy_field: bool,
    }

    struct XDrop<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        admin: address,
        status: u8,
        balance: 0x2::balance::Balance<T0>,
        claims: 0x2::table::Table<0x1::string::String, Claim>,
        stats: Stats,
    }

    struct Claim has store {
        amount: u64,
        claimed: bool,
    }

    struct Stats has store {
        addrs_claimed: u64,
        addrs_unclaimed: u64,
        amount_claimed: u64,
        amount_unclaimed: u64,
    }

    struct EligibleStatus has copy, drop, store {
        eligible: bool,
        amount: u64,
        claimed: bool,
    }

    struct CleanerCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventShare has copy, drop {
        id: address,
        type_coin: 0x1::ascii::String,
        type_network: 0x1::ascii::String,
    }

    struct EventOpen has copy, drop {
        id: address,
        type_coin: 0x1::ascii::String,
        type_network: 0x1::ascii::String,
    }

    struct EventPause has copy, drop {
        id: address,
        type_coin: 0x1::ascii::String,
        type_network: 0x1::ascii::String,
    }

    struct EventEnd has copy, drop {
        id: address,
        type_coin: 0x1::ascii::String,
        type_network: 0x1::ascii::String,
    }

    struct EventClaim has copy, drop {
        id: address,
        type_coin: 0x1::ascii::String,
        type_network: 0x1::ascii::String,
        foreign_addr: 0x1::string::String,
        amount: u64,
    }

    public fun value<T0, T1>(arg0: &XDrop<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun new<T0, T1>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : XDrop<T0, T1> {
        let v0 = Stats{
            addrs_claimed    : 0,
            addrs_unclaimed  : 0,
            amount_claimed   : 0,
            amount_unclaimed : 0,
        };
        XDrop<T0, T1>{
            id      : 0x2::object::new(arg1),
            admin   : 0x2::tx_context::sender(arg1),
            status  : 0,
            balance : 0x2::balance::zero<T0>(),
            claims  : 0x2::table::new<0x1::string::String, Claim>(arg1),
            stats   : v0,
        }
    }

    public fun addrs_claimed(arg0: &Stats) : u64 {
        arg0.addrs_claimed
    }

    public fun addrs_unclaimed(arg0: &Stats) : u64 {
        arg0.addrs_unclaimed
    }

    public fun admin<T0, T1>(arg0: &XDrop<T0, T1>) : address {
        arg0.admin
    }

    public fun admin_adds_claims<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: vector<vector<u8>>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 3002);
        assert!(!is_ended<T0, T1>(arg0), 3008);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<u64>(&arg3), 3003);
        assert!(0x1::vector::length<vector<u8>>(&arg2) > 0, 3006);
        let v0 = 0;
        while (0x1::vector::length<vector<u8>>(&arg2) > 0) {
            let v1 = 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg2));
            assert!(0x1::string::length(&v1) > 0, 3012);
            assert!(!0x2::table::contains<0x1::string::String, Claim>(&arg0.claims, v1), 3004);
            let v2 = 0x1::vector::pop_back<u64>(&mut arg3);
            assert!(v2 > 0, 3005);
            v0 = v0 + v2;
            let v3 = Claim{
                amount  : v2,
                claimed : false,
            };
            0x2::table::add<0x1::string::String, Claim>(&mut arg0.claims, v1, v3);
        };
        assert!(v0 == 0x2::coin::value<T0>(&arg1), 3007);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
        arg0.stats.addrs_unclaimed = arg0.stats.addrs_unclaimed + 0x1::vector::length<vector<u8>>(&arg2);
        arg0.stats.amount_unclaimed = arg0.stats.amount_unclaimed + v0;
    }

    public fun admin_ends_xdrop<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3002);
        assert!(!is_ended<T0, T1>(arg0), 3008);
        arg0.status = 2;
        let v0 = EventEnd{
            id           : 0x2::object::uid_to_address(&arg0.id),
            type_coin    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            type_network : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<EventEnd>(v0);
    }

    public fun admin_opens_xdrop<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3002);
        assert!(is_paused<T0, T1>(arg0), 3011);
        arg0.status = 1;
        let v0 = EventOpen{
            id           : 0x2::object::uid_to_address(&arg0.id),
            type_coin    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            type_network : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<EventOpen>(v0);
    }

    public fun admin_pauses_xdrop<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3002);
        assert!(is_open<T0, T1>(arg0), 3010);
        arg0.status = 0;
        let v0 = EventPause{
            id           : 0x2::object::uid_to_address(&arg0.id),
            type_coin    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            type_network : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<EventPause>(v0);
    }

    public fun admin_reclaims_balance<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3002);
        assert!(is_ended<T0, T1>(arg0), 3009);
        0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance), arg1)
    }

    public fun admin_sets_admin_address<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3002);
        assert!(!is_ended<T0, T1>(arg0), 3008);
        arg0.admin = arg1;
    }

    public fun amount(arg0: &EligibleStatus) : u64 {
        arg0.amount
    }

    public fun amount_claimed(arg0: &Stats) : u64 {
        arg0.amount_claimed
    }

    public fun amount_unclaimed(arg0: &Stats) : u64 {
        arg0.amount_unclaimed
    }

    public fun claim_amount(arg0: &Claim) : u64 {
        arg0.amount
    }

    public fun claim_claimed(arg0: &Claim) : bool {
        arg0.claimed
    }

    public fun claimed(arg0: &EligibleStatus) : bool {
        arg0.claimed
    }

    public fun claims<T0, T1>(arg0: &XDrop<T0, T1>) : &0x2::table::Table<0x1::string::String, Claim> {
        &arg0.claims
    }

    public fun cleaner_creates_cleaner_cap(arg0: &CleanerCap, arg1: &mut 0x2::tx_context::TxContext) : CleanerCap {
        CleanerCap{id: 0x2::object::new(arg1)}
    }

    public fun cleaner_deletes_claims<T0, T1>(arg0: &CleanerCap, arg1: &mut XDrop<T0, T1>, arg2: vector<vector<u8>>) {
        assert!(is_ended<T0, T1>(arg1), 3009);
        while (0x1::vector::length<vector<u8>>(&arg2) > 0) {
            let Claim {
                amount  : _,
                claimed : _,
            } = 0x2::table::remove<0x1::string::String, Claim>(&mut arg1.claims, 0x1::string::utf8(0x1::vector::pop_back<vector<u8>>(&mut arg2)));
        };
    }

    public fun cleaner_destroys_cleaner_cap(arg0: CleanerCap) {
        let CleanerCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun eligible(arg0: &EligibleStatus) : bool {
        arg0.eligible
    }

    public fun get_eligible_statuses<T0, T1>(arg0: &XDrop<T0, T1>, arg1: vector<vector<u8>>) : vector<EligibleStatus> {
        let v0 = 0x1::vector::empty<EligibleStatus>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, v1));
            if (!0x2::table::contains<0x1::string::String, Claim>(&arg0.claims, v2)) {
                let v3 = EligibleStatus{
                    eligible : false,
                    amount   : 0,
                    claimed  : false,
                };
                0x1::vector::push_back<EligibleStatus>(&mut v0, v3);
            } else {
                let v4 = 0x2::table::borrow<0x1::string::String, Claim>(&arg0.claims, v2);
                let v5 = EligibleStatus{
                    eligible : true,
                    amount   : v4.amount,
                    claimed  : v4.claimed,
                };
                0x1::vector::push_back<EligibleStatus>(&mut v0, v5);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: XDROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<XDROP>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = CleanerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CleanerCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_ended<T0, T1>(arg0: &XDrop<T0, T1>) : bool {
        arg0.status == 2
    }

    public fun is_open<T0, T1>(arg0: &XDrop<T0, T1>) : bool {
        arg0.status == 1
    }

    public fun is_paused<T0, T1>(arg0: &XDrop<T0, T1>) : bool {
        arg0.status == 0
    }

    public fun share<T0, T1>(arg0: XDrop<T0, T1>) {
        let v0 = EventShare{
            id           : 0x2::object::uid_to_address(&arg0.id),
            type_coin    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            type_network : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<EventShare>(v0);
        0x2::transfer::share_object<XDrop<T0, T1>>(arg0);
    }

    public fun stats<T0, T1>(arg0: &XDrop<T0, T1>) : &Stats {
        &arg0.stats
    }

    public fun status<T0, T1>(arg0: &XDrop<T0, T1>) : u8 {
        arg0.status
    }

    public fun user_claims<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: &0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::SuiLink<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_open<T0, T1>(arg0), 3010);
        let v0 = 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::network_address<T1>(arg1);
        assert!(0x2::table::contains<0x1::string::String, Claim>(&arg0.claims, v0), 3000);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Claim>(&mut arg0.claims, v0);
        assert!(!v1.claimed, 3001);
        v1.claimed = true;
        arg0.stats.addrs_claimed = arg0.stats.addrs_claimed + 1;
        arg0.stats.addrs_unclaimed = arg0.stats.addrs_unclaimed - 1;
        arg0.stats.amount_claimed = arg0.stats.amount_claimed + v1.amount;
        arg0.stats.amount_unclaimed = arg0.stats.amount_unclaimed - v1.amount;
        let v2 = EventClaim{
            id           : 0x2::object::uid_to_address(&arg0.id),
            type_coin    : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            type_network : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            foreign_addr : v0,
            amount       : v1.amount,
        };
        0x2::event::emit<EventClaim>(v2);
        0x2::coin::take<T0>(&mut arg0.balance, v1.amount, arg2)
    }

    // decompiled from Move bytecode v6
}

