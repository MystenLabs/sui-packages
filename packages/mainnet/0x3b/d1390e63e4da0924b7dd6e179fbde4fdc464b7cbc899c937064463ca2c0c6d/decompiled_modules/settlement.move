module 0x3bd1390e63e4da0924b7dd6e179fbde4fdc464b7cbc899c937064463ca2c0c6d::settlement {
    struct SETTLEMENT has drop {
        dummy_field: bool,
    }

    struct SwapOrder has drop, store {
        cctp_nonce: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
        fulfilled: bool,
        created_at: u64,
    }

    struct FulfillReceipt {
        cctp_nonce: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
    }

    struct SettlementState has key {
        id: 0x2::object::UID,
        oapp_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        orders: 0x2::table::Table<u64, SwapOrder>,
        admin: address,
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x2::bcs::to_bytes<address>(&arg0)
    }

    public entry fun admin_inject_order(arg0: &mut SettlementState, arg1: u64, arg2: address, arg3: u64, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 9);
        assert!(!0x2::table::contains<u64, SwapOrder>(&arg0.orders, arg1), 0);
        let v0 = SwapOrder{
            cctp_nonce   : arg1,
            output_token : arg2,
            min_output   : arg3,
            recipient    : arg4,
            fulfilled    : false,
            created_at   : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::table::add<u64, SwapOrder>(&mut arg0.orders, arg1, v0);
        0x3bd1390e63e4da0924b7dd6e179fbde4fdc464b7cbc899c937064463ca2c0c6d::events::emit_swap_order_received(arg1, arg2, arg3, arg4);
    }

    public fun complete_fulfill<T0: drop>(arg0: &mut SettlementState, arg1: FulfillReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        let FulfillReceipt {
            cctp_nonce   : v0,
            output_token : v1,
            min_output   : v2,
            recipient    : v3,
        } = arg1;
        let v4 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        assert!(0x2::hash::blake2b256(&v4) == address_to_bytes(v1), 6);
        let v5 = 0x2::coin::value<T0>(&arg2);
        assert!(v5 >= v2, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v3);
        0x2::table::borrow_mut<u64, SwapOrder>(&mut arg0.orders, v0).fulfilled = true;
        0x3bd1390e63e4da0924b7dd6e179fbde4fdc464b7cbc899c937064463ca2c0c6d::events::emit_order_fulfilled(v0, 0, v5, v1, v3, 0x2::tx_context::sender(arg3));
    }

    public fun create_fulfill_receipt(arg0: &SettlementState, arg1: u64) : FulfillReceipt {
        assert!(0x2::table::contains<u64, SwapOrder>(&arg0.orders, arg1), 1);
        let v0 = 0x2::table::borrow<u64, SwapOrder>(&arg0.orders, arg1);
        assert!(!v0.fulfilled, 2);
        FulfillReceipt{
            cctp_nonce   : v0.cctp_nonce,
            output_token : v0.output_token,
            min_output   : v0.min_output,
            recipient    : v0.recipient,
        }
    }

    fun decode_swap_order(arg0: &vector<u8>) : (u64, address, u64, address) {
        assert!(0x1::vector::length<u8>(arg0) == 80, 7);
        (read_u64_le(arg0, 0), read_address(arg0, 8), read_u64_le(arg0, 40), read_address(arg0, 48))
    }

    public fun get_order_min_output(arg0: &SettlementState, arg1: u64) : u64 {
        0x2::table::borrow<u64, SwapOrder>(&arg0.orders, arg1).min_output
    }

    public fun get_order_output_token(arg0: &SettlementState, arg1: u64) : address {
        0x2::table::borrow<u64, SwapOrder>(&arg0.orders, arg1).output_token
    }

    public fun get_order_recipient(arg0: &SettlementState, arg1: u64) : address {
        0x2::table::borrow<u64, SwapOrder>(&arg0.orders, arg1).recipient
    }

    fun init(arg0: SETTLEMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<SETTLEMENT>(&arg0, arg1);
        let v3 = SettlementState{
            id       : 0x2::object::new(arg1),
            oapp_cap : v0,
            orders   : 0x2::table::new<u64, SwapOrder>(arg1),
            admin    : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<SettlementState>(v3);
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun is_order_fulfilled(arg0: &SettlementState, arg1: u64) : bool {
        if (!0x2::table::contains<u64, SwapOrder>(&arg0.orders, arg1)) {
            return false
        };
        0x2::table::borrow<u64, SwapOrder>(&arg0.orders, arg1).fulfilled
    }

    public fun is_order_received(arg0: &SettlementState, arg1: u64) : bool {
        0x2::table::contains<u64, SwapOrder>(&arg0.orders, arg1)
    }

    public fun lz_receive(arg0: &mut SettlementState, arg1: &mut 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: u32, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert!(arg2 == 30108, 8);
        let (v0, v1, v2, v3) = decode_swap_order(&arg3);
        assert!(!0x2::table::contains<u64, SwapOrder>(&arg0.orders, v0), 0);
        let v4 = SwapOrder{
            cctp_nonce   : v0,
            output_token : v1,
            min_output   : v2,
            recipient    : v3,
            fulfilled    : false,
            created_at   : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::table::add<u64, SwapOrder>(&mut arg0.orders, v0, v4);
        0x3bd1390e63e4da0924b7dd6e179fbde4fdc464b7cbc899c937064463ca2c0c6d::events::emit_swap_order_received(v0, v1, v2, v3);
    }

    fun read_address(arg0: &vector<u8>, arg1: u64) : address {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1 + v1));
            v1 = v1 + 1;
        };
        0x2::address::from_bytes(v0)
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u64) << (v1 as u8) * 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun receive_coin<T0: store + key>(arg0: &mut SettlementState, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        0x2::transfer::public_receive<T0>(&mut arg0.id, arg1)
    }

    public fun withdraw_fallback<T0: drop>(arg0: &mut SettlementState, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, SwapOrder>(&arg0.orders, arg1), 1);
        let v0 = 0x2::table::borrow<u64, SwapOrder>(&arg0.orders, arg1);
        assert!(!v0.fulfilled, 2);
        assert!(0x2::tx_context::sender(arg4) == v0.recipient, 5);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.created_at + 86400000, 4);
        let v1 = v0.recipient;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v1);
        0x2::table::borrow_mut<u64, SwapOrder>(&mut arg0.orders, arg1).fulfilled = true;
        0x3bd1390e63e4da0924b7dd6e179fbde4fdc464b7cbc899c937064463ca2c0c6d::events::emit_fallback_withdrawn(arg1, 0x2::coin::value<T0>(&arg2), v1);
    }

    // decompiled from Move bytecode v6
}

