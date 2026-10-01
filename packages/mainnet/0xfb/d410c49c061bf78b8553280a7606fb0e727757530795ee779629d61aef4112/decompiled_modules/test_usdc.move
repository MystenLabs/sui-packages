module 0xfbd410c49c061bf78b8553280a7606fb0e727757530795ee779629d61aef4112::test_usdc {
    struct TEST_USDC has drop {
        dummy_field: bool,
    }

    struct Claim has drop, store {
        day: u64,
        claimed: u64,
    }

    struct Faucet has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<TEST_USDC>,
        claims: 0x2::table::Table<address, Claim>,
    }

    struct FaucetEvent has copy, drop {
        to: address,
        amount: u64,
        day: u64,
    }

    public fun total_supply(arg0: &Faucet) : u64 {
        0x2::coin::total_supply<TEST_USDC>(&arg0.cap)
    }

    public fun admin_mint(arg0: &mut Faucet, arg1: &0xfbd410c49c061bf78b8553280a7606fb0e727757530795ee779629d61aef4112::para_bridge::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_USDC> {
        0x2::coin::mint<TEST_USDC>(&mut arg0.cap, arg2, arg3)
    }

    public fun claimed_today(arg0: &Faucet, arg1: address, arg2: &0x2::clock::Clock) : u64 {
        if (!0x2::table::contains<address, Claim>(&arg0.claims, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, Claim>(&arg0.claims, arg1);
        if (v0.day == 0x2::clock::timestamp_ms(arg2) / 86400000) {
            v0.claimed
        } else {
            0
        }
    }

    public fun faucet(arg0: &mut Faucet, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 86400000;
        if (!0x2::table::contains<address, Claim>(&arg0.claims, v0)) {
            let v2 = Claim{
                day     : v1,
                claimed : 0,
            };
            0x2::table::add<address, Claim>(&mut arg0.claims, v0, v2);
        };
        let v3 = 0x2::table::borrow_mut<address, Claim>(&mut arg0.claims, v0);
        if (v3.day != v1) {
            v3.day = v1;
            v3.claimed = 0;
        };
        assert!(arg1 <= 100000000 - v3.claimed, 0);
        v3.claimed = v3.claimed + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_USDC>>(0x2::coin::mint<TEST_USDC>(&mut arg0.cap, arg1, arg3), v0);
        let v4 = FaucetEvent{
            to     : v0,
            amount : arg1,
            day    : v1,
        };
        0x2::event::emit<FaucetEvent>(v4);
    }

    fun init(arg0: TEST_USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST_USDC>(arg0, 6, 0x1::string::utf8(b"TEST-USDC"), 0x1::string::utf8(b"TEST-USD Coin"), 0x1::string::utf8(b"Test-only USD coin for the PUSD bridge. Not real money."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST_USDC>>(0x2::coin_registry::finalize<TEST_USDC>(v0, arg1), 0x2::tx_context::sender(arg1));
        let v2 = Faucet{
            id     : 0x2::object::new(arg1),
            cap    : v1,
            claims : 0x2::table::new<address, Claim>(arg1),
        };
        0x2::transfer::share_object<Faucet>(v2);
    }

    // decompiled from Move bytecode v7
}

