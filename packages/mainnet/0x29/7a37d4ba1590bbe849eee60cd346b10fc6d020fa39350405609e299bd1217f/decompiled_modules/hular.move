module 0x297a37d4ba1590bbe849eee60cd346b10fc6d020fa39350405609e299bd1217f::hular {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Escrow has key {
        id: 0x2::object::UID,
        treasury: address,
        voucher_signers: vector<vector<u8>>,
        deposits: 0x2::bag::Bag,
        voucher_float: 0x2::bag::Bag,
        settled: 0x2::table::Table<vector<u8>, u64>,
        vouchers: 0x2::table::Table<vector<u8>, bool>,
    }

    struct Deposit has copy, drop {
        quote_hash: vector<u8>,
        coin_type: 0x1::ascii::String,
        amount: u64,
        from: address,
    }

    struct Fulfilled has copy, drop {
        quote_hash: vector<u8>,
        coin_type: 0x1::ascii::String,
        amount: u64,
        recipient: address,
        gas_drop: u64,
    }

    struct Refunded has copy, drop {
        quote_hash: vector<u8>,
        coin_type: 0x1::ascii::String,
        amount: u64,
        recipient: address,
    }

    struct Released has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct VoucherRedeemed has copy, drop {
        id: vector<u8>,
        coin_type: 0x1::ascii::String,
        referrer: address,
        amount: u64,
    }

    public fun add_voucher_signer(arg0: &AdminCap, arg1: &mut Escrow, arg2: vector<u8>) {
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        0x1::vector::push_back<vector<u8>>(&mut arg1.voucher_signers, arg2);
    }

    fun coin_type_string<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    fun credit<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
        };
    }

    fun debit<T0>(arg0: &mut 0x2::bag::Bag, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>()), arg1)
    }

    public fun defund_vouchers<T0>(arg0: &mut Escrow, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 0);
        let v0 = &mut arg0.voucher_float;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(debit<T0>(v0, arg1), arg2), arg0.treasury);
    }

    public fun deposit<T0>(arg0: &mut Escrow, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = &mut arg0.deposits;
        credit<T0>(v0, 0x2::coin::into_balance<T0>(arg2));
        let v1 = Deposit{
            quote_hash : arg1,
            coin_type  : coin_type_string<T0>(),
            amount     : 0x2::coin::value<T0>(&arg2),
            from       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Deposit>(v1);
    }

    public fun fulfill<T0>(arg0: &mut Escrow, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.treasury, 0);
        mark_settled(arg0, arg1, arg5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg4);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v1 = Fulfilled{
            quote_hash : arg1,
            coin_type  : coin_type_string<T0>(),
            amount     : 0x2::coin::value<T0>(&arg2),
            recipient  : arg4,
            gas_drop   : v0,
        };
        0x2::event::emit<Fulfilled>(v1);
    }

    public fun fund_vouchers<T0>(arg0: &mut Escrow, arg1: 0x2::coin::Coin<T0>) {
        let v0 = &mut arg0.voucher_float;
        credit<T0>(v0, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow{
            id              : 0x2::object::new(arg0),
            treasury        : 0x2::tx_context::sender(arg0),
            voucher_signers : vector[],
            deposits        : 0x2::bag::new(arg0),
            voucher_float   : 0x2::bag::new(arg0),
            settled         : 0x2::table::new<vector<u8>, u64>(arg0),
            vouchers        : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<Escrow>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun mark_settled(arg0: &mut Escrow, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.settled, arg1), 1);
        0x2::table::add<vector<u8>, u64>(&mut arg0.settled, arg1, 0x2::tx_context::epoch(arg2));
    }

    public fun prune(arg0: &mut Escrow, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg2) >= *0x2::table::borrow<vector<u8>, u64>(&arg0.settled, arg1) + 180, 5);
        0x2::table::remove<vector<u8>, u64>(&mut arg0.settled, arg1);
    }

    public fun redeem_voucher<T0>(arg0: &mut Escrow, arg1: vector<u8>, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        assert!(0x1::vector::length<u8>(&arg4) == 64, 4);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.vouchers, arg1), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.vouchers, arg1, true);
        let v0 = voucher_message<T0>(arg0, arg1, arg2, arg3);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg0.voucher_signers)) {
            if (0x2::ed25519::ed25519_verify(&arg4, 0x1::vector::borrow<vector<u8>>(&arg0.voucher_signers, v2), &v0)) {
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 3);
        let v3 = &mut arg0.voucher_float;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(debit<T0>(v3, arg3), arg5), arg2);
        let v4 = VoucherRedeemed{
            id        : arg1,
            coin_type : coin_type_string<T0>(),
            referrer  : arg2,
            amount    : arg3,
        };
        0x2::event::emit<VoucherRedeemed>(v4);
    }

    public fun refund<T0>(arg0: &mut Escrow, arg1: vector<u8>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.treasury, 0);
        mark_settled(arg0, arg1, arg4);
        let v0 = &mut arg0.deposits;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(debit<T0>(v0, arg2), arg4), arg3);
        let v1 = Refunded{
            quote_hash : arg1,
            coin_type  : coin_type_string<T0>(),
            amount     : arg2,
            recipient  : arg3,
        };
        0x2::event::emit<Refunded>(v1);
    }

    public fun release<T0>(arg0: &mut Escrow, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 0);
        let v0 = &mut arg0.deposits;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(debit<T0>(v0, arg1), arg2), arg0.treasury);
        let v1 = Released{
            coin_type : coin_type_string<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<Released>(v1);
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Escrow, arg2: address) {
        arg1.treasury = arg2;
    }

    fun voucher_message<T0>(arg0: &Escrow, arg1: vector<u8>, arg2: address, arg3: u64) : vector<u8> {
        let v0 = b"sui";
        let v1 = b"hular-voucher";
        0x1::vector::push_back<u8>(&mut v1, (0x1::vector::length<u8>(&v0) as u8));
        0x1::vector::append<u8>(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&arg0.id));
        0x1::vector::append<u8>(&mut v1, arg1);
        let v2 = 0x1::ascii::into_bytes(coin_type_string<T0>());
        let v3 = (0x1::vector::length<u8>(&v2) as u16);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u16>(&v3));
        0x1::vector::append<u8>(&mut v1, v2);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg3));
        v1
    }

    // decompiled from Move bytecode v7
}

