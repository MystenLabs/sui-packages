module 0x75f50a21aca30dacca617283f61bb5feea2c001cd6e3e79989601443800ef0c8::xdrop {
    struct XDROP has drop {
        dummy_field: bool,
    }

    struct XDrop<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        admin: address,
        status: u8,
        balance: 0x2::balance::Balance<T0>,
        claims: 0x2::table::Table<0x1::string::String, Claim>,
        info_json: 0x1::string::String,
    }

    struct Claim has store {
        amount: u64,
        claimed: bool,
    }

    struct ClaimStatus has copy, drop, store {
        eligible: bool,
        claimed: bool,
        amount: u64,
    }

    public fun value<T0, T1>(arg0: &XDrop<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
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
            assert!(0x1::string::length(&v1) > 0, 3011);
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
    }

    public fun admin_creates_xdrop<T0, T1>(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : XDrop<T0, T1> {
        XDrop<T0, T1>{
            id        : 0x2::object::new(arg1),
            admin     : 0x2::tx_context::sender(arg1),
            status    : 0,
            balance   : 0x2::balance::zero<T0>(),
            claims    : 0x2::table::new<0x1::string::String, Claim>(arg1),
            info_json : 0x1::string::utf8(arg0),
        }
    }

    public fun admin_ends_xdrop<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3002);
        arg0.status = 2;
    }

    public fun admin_opens_xdrop<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3002);
        assert!(!is_ended<T0, T1>(arg0), 3008);
        arg0.status = 1;
    }

    public fun admin_pauses_xdrop<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3002);
        assert!(!is_ended<T0, T1>(arg0), 3008);
        arg0.status = 0;
    }

    public fun admin_reclaims_balance<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 3002);
        assert!(is_ended<T0, T1>(arg0), 3009);
        0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance), arg1)
    }

    public fun admin_sets_admin_address<T0, T1>(arg0: &mut XDrop<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 3002);
        arg0.admin = arg1;
    }

    public fun claims<T0, T1>(arg0: &XDrop<T0, T1>) : &0x2::table::Table<0x1::string::String, Claim> {
        &arg0.claims
    }

    public fun get_claim_statuses<T0, T1>(arg0: &XDrop<T0, T1>, arg1: vector<vector<u8>>) : vector<ClaimStatus> {
        let v0 = 0x1::vector::empty<ClaimStatus>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg1)) {
            let v2 = 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, v1));
            if (!0x2::table::contains<0x1::string::String, Claim>(&arg0.claims, v2)) {
                let v3 = ClaimStatus{
                    eligible : false,
                    claimed  : false,
                    amount   : 0,
                };
                0x1::vector::push_back<ClaimStatus>(&mut v0, v3);
            } else {
                let v4 = 0x2::table::borrow<0x1::string::String, Claim>(&arg0.claims, v2);
                let v5 = ClaimStatus{
                    eligible : true,
                    claimed  : v4.claimed,
                    amount   : v4.amount,
                };
                0x1::vector::push_back<ClaimStatus>(&mut v0, v5);
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun init(arg0: XDROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<XDROP>(arg0, arg1), 0x2::tx_context::sender(arg1));
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
        0x2::coin::take<T0>(&mut arg0.balance, v1.amount, arg2)
    }

    // decompiled from Move bytecode v6
}

