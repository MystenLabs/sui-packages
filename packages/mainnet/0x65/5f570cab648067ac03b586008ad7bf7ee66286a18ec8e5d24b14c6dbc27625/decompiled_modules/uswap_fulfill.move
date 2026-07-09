module 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::uswap_fulfill {
    struct FulfillRegistry has key {
        id: 0x2::object::UID,
        escrows: 0x2::object_table::ObjectTable<vector<u8>, Escrow>,
    }

    struct Escrow has store, key {
        id: 0x2::object::UID,
    }

    struct FulfillReceipt {
        intent_id: vector<u8>,
        dst_token_hash: vector<u8>,
        dst_recipient: address,
        min_final_out: u64,
        usdc_in: u64,
    }

    struct EdgeFulfilled has copy, drop {
        intent_id: vector<u8>,
        usdc_in: u64,
        dst_out: u64,
        recipient: address,
    }

    struct EdgeUsdcDelivered has copy, drop {
        intent_id: vector<u8>,
        amount: u64,
        recipient: address,
    }

    fun assert_is_usdc<T0>() {
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())) == b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC", 7);
    }

    public fun begin_fulfill<T0>(arg0: &mut FulfillRegistry, arg1: vector<u8>, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: &0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, FulfillReceipt) {
        assert!(0x2::tx_context::sender(arg3) == @0x5277da683470070641e630e37a67fc6971a9941f74e8a271ccd905099eff8dde, 10);
        assert_is_usdc<T0>();
        begin_fulfill_inner<T0>(arg0, arg1, arg2)
    }

    fun begin_fulfill_inner<T0>(arg0: &mut FulfillRegistry, arg1: vector<u8>, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) : (0x2::coin::Coin<T0>, FulfillReceipt) {
        let v0 = 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::parse(arg1);
        assert!(0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::dst_chain_id(&v0) == 101, 1);
        let v1 = 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::intent_id(&v0);
        let v2 = receive_all<T0>(arg0, v1, arg2);
        let v3 = 0x2::coin::value<T0>(&v2);
        assert!(v3 > 0, 3);
        let v4 = FulfillReceipt{
            intent_id      : v1,
            dst_token_hash : 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::dst_token_hash(&v0),
            dst_recipient  : 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::dst_recipient(&v0),
            min_final_out  : 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::min_final_out(&v0),
            usdc_in        : v3,
        };
        (v2, v4)
    }

    fun borrow_escrow_mut(arg0: &mut FulfillRegistry, arg1: vector<u8>) : &mut 0x2::object::UID {
        if (!0x2::object_table::contains<vector<u8>, Escrow>(&arg0.escrows, arg1)) {
            let v0 = Escrow{id: 0x2::derived_object::claim<vector<u8>>(&mut arg0.id, arg1)};
            0x2::object_table::add<vector<u8>, Escrow>(&mut arg0.escrows, arg1, v0);
        };
        &mut 0x2::object_table::borrow_mut<vector<u8>, Escrow>(&mut arg0.escrows, arg1).id
    }

    fun decode_hex32(arg0: &vector<u8>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, hex_val(*0x1::vector::borrow<u8>(arg0, v1 * 2)) * 16 + hex_val(*0x1::vector::borrow<u8>(arg0, v1 * 2 + 1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun deliver_usdc<T0>(arg0: &mut FulfillRegistry, arg1: vector<u8>, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_is_usdc<T0>();
        deliver_usdc_inner<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    fun deliver_usdc_inner<T0>(arg0: &mut FulfillRegistry, arg1: vector<u8>, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::parse(arg1);
        assert!(0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::dst_chain_id(&v0) == 101, 1);
        let v1 = 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::dst_recipient(&v0);
        let v2 = 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::intent_id(&v0);
        if (0x2::tx_context::sender(arg4) != v1) {
            assert!(0x2::clock::timestamp_ms(arg3) > 0x655f570cab648067ac03b586008ad7bf7ee66286a18ec8e5d24b14c6dbc27625::blob::deadline(&v0) * 1000 + 600000, 6);
        };
        let v3 = receive_all<T0>(arg0, v2, arg2);
        let v4 = 0x2::coin::value<T0>(&v3);
        assert!(v4 > 0, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v1);
        let v5 = EdgeUsdcDelivered{
            intent_id : v2,
            amount    : v4,
            recipient : v1,
        };
        0x2::event::emit<EdgeUsdcDelivered>(v5);
    }

    public fun escrow_address(arg0: 0x2::object::ID, arg1: vector<u8>) : address {
        0x2::derived_object::derive_address<vector<u8>>(arg0, arg1)
    }

    public fun finish_fulfill<T0>(arg0: FulfillReceipt, arg1: 0x2::coin::Coin<T0>) {
        let FulfillReceipt {
            intent_id      : v0,
            dst_token_hash : v1,
            dst_recipient  : v2,
            min_final_out  : v3,
            usdc_in        : v4,
        } = arg0;
        assert!(payload_hash_of_type(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()))) == v1, 4);
        let v5 = 0x2::coin::value<T0>(&arg1);
        assert!(v5 >= v3, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
        let v6 = EdgeFulfilled{
            intent_id : v0,
            usdc_in   : v4,
            dst_out   : v5,
            recipient : v2,
        };
        0x2::event::emit<EdgeFulfilled>(v6);
    }

    fun hex_val(arg0: u8) : u8 {
        if (arg0 >= 48 && arg0 <= 57) {
            arg0 - 48
        } else if (arg0 >= 97 && arg0 <= 102) {
            arg0 - 97 + 10
        } else {
            assert!(arg0 >= 65 && arg0 <= 70, 9);
            arg0 - 65 + 10
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FulfillRegistry{
            id      : 0x2::object::new(arg0),
            escrows : 0x2::object_table::new<vector<u8>, Escrow>(arg0),
        };
        0x2::transfer::share_object<FulfillRegistry>(v0);
    }

    public fun payload_hash_of_type(arg0: vector<u8>) : vector<u8> {
        let v0 = decode_hex32(&arg0);
        let v1 = 64;
        while (v1 < 0x1::vector::length<u8>(&arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        0x1::hash::sha2_256(v0)
    }

    fun receive_all<T0>(arg0: &mut FulfillRegistry, arg1: vector<u8>, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>) : 0x2::coin::Coin<T0> {
        assert!(!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2), 8);
        let v0 = borrow_escrow_mut(arg0, arg1);
        let v1 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(v0, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg2));
        while (!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2)) {
            0x2::coin::join<T0>(&mut v1, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(v0, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg2)));
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg2);
        v1
    }

    // decompiled from Move bytecode v7
}

