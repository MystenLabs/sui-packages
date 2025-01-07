module 0x62b17dfd28694728d5747577bf10bc69e8fd395af56d32ce0d38d97ca5aa381f::demo {
    struct Demo<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        claims: 0x2::table::Table<0x1::string::String, Claim>,
    }

    struct Claim has store {
        amount: u64,
        claimed: bool,
    }

    public fun new<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : Demo<T0, T1> {
        Demo<T0, T1>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
            claims  : 0x2::table::new<0x1::string::String, Claim>(arg0),
        }
    }

    public fun demo_add<T0, T1>(arg0: &mut Demo<T0, T1>, arg1: vector<u8>, arg2: u64) {
        let v0 = Claim{
            amount  : arg2,
            claimed : false,
        };
        0x2::table::add<0x1::string::String, Claim>(&mut arg0.claims, 0x1::string::utf8(arg1), v0);
    }

    public fun demo_claim<T0, T1>(arg0: &mut Demo<T0, T1>, arg1: &0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::SuiLink<T1>) {
        let v0 = 0xf857fa9df5811e6df2a0240a1029d365db24b5026896776ddd1c3c70803bccd3::suilink::network_address<T1>(arg1);
        assert!(0x2::table::contains<0x1::string::String, Claim>(&arg0.claims, v0), 3000);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, Claim>(&mut arg0.claims, v0);
        assert!(!v1.claimed, 3001);
        v1.claimed = true;
    }

    // decompiled from Move bytecode v6
}

