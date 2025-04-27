module 0xafe1eaf6a7cee736aacae752ff781a4ba36bd3cc9b0df2ac65d5d7840f1b3423::sui_token {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Campaign<phantom T0> has key {
        id: 0x2::object::UID,
        cid: u256,
        admin: address,
        balance: 0x2::balance::Balance<T0>,
        amount_per_address: u256,
        total_addresses: u128,
        claimed_addresses: u128,
    }

    struct GalxeTable has key {
        id: 0x2::object::UID,
        public_key: vector<u8>,
        treasurer: address,
        has_claimed: 0x2::table::Table<u256, bool>,
        campaigns: 0x2::table::Table<u256, 0x2::object::ID>,
        paused: bool,
    }

    struct ActiveEvent has copy, drop {
        cid: u256,
        token: 0x1::ascii::String,
        sender: address,
        amount_per_address: u256,
        total_addresses: u256,
        uid: 0x2::object::ID,
    }

    struct WithdrawEvent has copy, drop {
        cid: u256,
        token: 0x1::ascii::String,
        balance: u256,
        admin: address,
    }

    struct ClaimEvent has copy, drop {
        cid: u256,
        token: 0x1::ascii::String,
        amount: u256,
        dummy_id: u256,
        claim_to: address,
        claim_fee_amount: u64,
    }

    public fun active<T0>(arg0: u256, arg1: 0x2::coin::Coin<T0>, arg2: u256, arg3: u256, arg4: &mut GalxeTable, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg4.paused, 9223372638151245841);
        assert!(arg2 > 0, 9223372646740262915);
        assert!(arg3 > 0, 9223372651035361285);
        assert!(!0x2::table::contains<u256, 0x2::object::ID>(&arg4.campaigns, arg0), 9223372655330459655);
        assert!(arg2 * arg3 <= (0x2::coin::value<T0>(&arg1) as u256), 9223372668215623691);
        let v0 = Campaign<T0>{
            id                 : 0x2::object::new(arg6),
            cid                : arg0,
            admin              : 0x2::tx_context::sender(arg6),
            balance            : 0x2::coin::into_balance<T0>(arg1),
            amount_per_address : arg2,
            total_addresses    : (arg3 as u128),
            claimed_addresses  : 0,
        };
        let v1 = 0x2::object::id<Campaign<T0>>(&v0);
        0x2::table::add<u256, 0x2::object::ID>(&mut arg4.campaigns, arg0, v1);
        0x2::transfer::share_object<Campaign<T0>>(v0);
        let v2 = ActiveEvent{
            cid                : arg0,
            token              : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            sender             : 0x2::tx_context::sender(arg6),
            amount_per_address : arg2,
            total_addresses    : arg3,
            uid                : v1,
        };
        0x2::event::emit<ActiveEvent>(v2);
    }

    public fun claim<T0, T1>(arg0: &mut GalxeTable, arg1: &mut Campaign<T0>, arg2: u256, arg3: u256, arg4: address, arg5: 0x2::coin::Coin<T1>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 9223372951683858449);
        assert!(!0x2::table::contains<u256, bool>(&arg0.has_claimed, arg2), 9223372960273530893);
        assert!(arg1.claimed_addresses < arg1.total_addresses, 9223372964568498189);
        assert!((0x2::clock::timestamp_ms(arg7) as u256) < arg3, 9223372968863596559);
        assert!(0x2::balance::value<T0>(&arg1.balance) > 0, 9223372977453269003);
        0x2::table::add<u256, bool>(&mut arg0.has_claimed, arg2, true);
        arg1.claimed_addresses = arg1.claimed_addresses + 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, (arg1.amount_per_address as u64)), arg8), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg5, arg0.treasurer);
        let v0 = ClaimEvent{
            cid              : arg1.cid,
            token            : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount           : arg1.amount_per_address,
            dummy_id         : arg2,
            claim_to         : arg4,
            claim_fee_amount : 0x2::coin::value<T1>(&arg5),
        };
        0x2::event::emit<ClaimEvent>(v0);
    }

    public fun hasClaimed(arg0: &GalxeTable, arg1: u256) : bool {
        0x2::table::contains<u256, bool>(&arg0.has_claimed, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GalxeTable{
            id          : 0x2::object::new(arg0),
            public_key  : x"a4fd923397fef56f83466cd957d34fe3ce6e8e181aecf4ea43d20c92442af6d4",
            treasurer   : @0xe39fbd818a1134f62627778852373f9889e0b5b29cd2eaa62a7f84ee16a40bc1,
            has_claimed : 0x2::table::new<u256, bool>(arg0),
            campaigns   : 0x2::table::new<u256, 0x2::object::ID>(arg0),
            paused      : false,
        };
        0x2::transfer::share_object<GalxeTable>(v1);
    }

    public fun is_paused(arg0: &GalxeTable) : bool {
        arg0.paused
    }

    public entry fun pause_contract(arg0: &AdminCap, arg1: &mut GalxeTable) {
        arg1.paused = true;
    }

    public entry fun unpause_contract(arg0: &AdminCap, arg1: &mut GalxeTable) {
        arg1.paused = false;
    }

    public entry fun update_public_key(arg0: &AdminCap, arg1: &mut GalxeTable, arg2: vector<u8>) {
        arg1.public_key = arg2;
    }

    public entry fun update_treasurer(arg0: &AdminCap, arg1: &mut GalxeTable, arg2: address) {
        arg1.treasurer = arg2;
    }

    public fun withdraw<T0>(arg0: &mut Campaign<T0>, arg1: &GalxeTable, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 9223372835719741457);
        let v0 = 0x2::balance::value<T0>(&arg0.balance);
        assert!(v0 > 0, 9223372848604250123);
        arg0.claimed_addresses = arg0.total_addresses;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg3), arg0.admin);
        let v1 = WithdrawEvent{
            cid     : arg0.cid,
            token   : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            balance : (v0 as u256),
            admin   : arg0.admin,
        };
        0x2::event::emit<WithdrawEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

