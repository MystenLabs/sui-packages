module 0x257a2e2574ba118fb25ee2bb110db032a827a70e2b621dfc0005c8cffbc24a48::withdrawal_queue {
    struct WithdrawQueue has drop {
        dummy_field: bool,
    }

    struct WormholeRoute has copy, drop, store {
        evm_destination_chain: u16,
        evm_recipient: vector<u8>,
        evm_token: vector<u8>,
    }

    struct NativeRoute has copy, drop, store {
        asset_type: 0x1::type_name::TypeName,
        min_output: u64,
    }

    struct Entry<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        account_id: 0x2::object::ID,
        recipient: address,
        extra_data: vector<u8>,
    }

    struct Queue<phantom T0> has key {
        id: 0x2::object::UID,
        next_key: u64,
        entries: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::LinkedTable<u64, Entry<T0>>,
        executors: 0x2::vec_set::VecSet<address>,
        allowed_versions: 0x2::vec_set::VecSet<u16>,
    }

    struct Enqueued<phantom T0> has copy, drop {
        key: u64,
        account_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        route_tag: u8,
    }

    struct ExecutedWormhole<phantom T0> has copy, drop {
        key: u64,
        evm_destination_chain: u16,
        amount: u64,
    }

    struct ExecutedNative<phantom T0, phantom T1> has copy, drop {
        key: u64,
        recipient: address,
        amount: u64,
    }

    struct EntryCancelled<phantom T0> has copy, drop {
        key: u64,
        account_id: 0x2::object::ID,
        amount: u64,
        route_tag: u8,
    }

    struct ExecutorUpdated<phantom T0> has copy, drop {
        executor: address,
        added: bool,
    }

    public fun length<T0>(arg0: &Queue<T0>) : u64 {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::length<u64, Entry<T0>>(&arg0.entries)
    }

    public fun contains<T0>(arg0: &Queue<T0>, arg1: u64) : bool {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::contains<u64, Entry<T0>>(&arg0.entries, arg1)
    }

    public fun add_executor<T0>(arg0: &mut Queue<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: address) {
        assert_valid_package_version<T0>(arg0);
        if (0x2::vec_set::contains<address>(&arg0.executors, &arg2)) {
            return
        };
        0x2::vec_set::insert<address>(&mut arg0.executors, arg2);
        let v0 = ExecutorUpdated<T0>{
            executor : arg2,
            added    : true,
        };
        0x2::event::emit<ExecutorUpdated<T0>>(v0);
    }

    public fun add_version<T0>(arg0: &mut Queue<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        if (0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            return
        };
        0x2::vec_set::insert<u16>(&mut arg0.allowed_versions, arg2);
    }

    fun assert_valid_package_version<T0>(arg0: &Queue<T0>) {
        let v0 = 1;
        assert!(0x2::vec_set::contains<u16>(&arg0.allowed_versions, &v0), 13906836077014745102);
    }

    public fun cancel_entry<T0>(arg0: &mut Queue<T0>, arg1: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_valid_package_version<T0>(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg2);
        if (!0x2::vec_set::contains<address>(&arg0.executors, &v0) && !0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::is_account_authorized(arg1, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, Entry<T0>>(&arg0.entries, arg3).account_id, v0, 0x2::clock::timestamp_ms(arg4))) {
            abort 13906835475719192588
        };
        let Entry {
            balance    : v1,
            account_id : v2,
            recipient  : _,
            extra_data : v4,
        } = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::remove<u64, Entry<T0>>(&mut arg0.entries, arg3);
        let v5 = v4;
        let v6 = v1;
        let v7 = if (0x1::vector::length<u8>(&v5) > 0) {
            *0x1::vector::borrow<u8>(&v5, 0)
        } else {
            1
        };
        0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::put<T0, WithdrawQueue>(arg1, v2, v6, witness());
        let v8 = EntryCancelled<T0>{
            key        : arg3,
            account_id : v2,
            amount     : 0x2::balance::value<T0>(&v6),
            route_tag  : v7,
        };
        0x2::event::emit<EntryCancelled<T0>>(v8);
    }

    public fun create_queue<T0>(arg0: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Queue<T0>{
            id               : 0x2::object::new(arg1),
            next_key         : 0,
            entries          : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::new<u64, Entry<T0>>(arg1),
            executors        : 0x2::vec_set::empty<address>(),
            allowed_versions : 0x2::vec_set::singleton<u16>(1),
        };
        0x2::transfer::share_object<Queue<T0>>(v0);
    }

    fun decode_native_route<T0>(arg0: &vector<u8>) : u64 {
        assert!(0x1::vector::length<u8>(arg0) > 0, 13906836235927879684);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 1, 13906836240222846980);
        let v0 = b"";
        let v1 = 1;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::bcs::new(v0);
        let v3 = 0x2::bcs::into_remainder_bytes(v2);
        assert!(0x1::vector::length<u8>(&v3) == 0, 13906836296057421828);
        assert!(0x2::bcs::peel_vec_u8(&mut v2) == 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())), 13906836304647356420);
        0x2::bcs::peel_u64(&mut v2)
    }

    fun decode_wormhole_route(arg0: &vector<u8>) : WormholeRoute {
        assert!(0x1::vector::length<u8>(arg0) > 0, 13906836124258729988);
        assert!(*0x1::vector::borrow<u8>(arg0, 0) == 0, 13906836128553697284);
        let v0 = b"";
        let v1 = 1;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1));
            v1 = v1 + 1;
        };
        let v2 = 0x2::bcs::new(v0);
        let v3 = 0x2::bcs::into_remainder_bytes(v2);
        assert!(0x1::vector::length<u8>(&v3) == 0, 13906836192978206724);
        WormholeRoute{
            evm_destination_chain : 0x2::bcs::peel_u16(&mut v2),
            evm_recipient         : 0x2::bcs::peel_vec_u8(&mut v2),
            evm_token             : 0x2::bcs::peel_vec_u8(&mut v2),
        }
    }

    public fun enqueue<T0>(arg0: &mut Queue<T0>, arg1: &mut 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AccountRegistry, arg2: 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::WithdrawRequest<T0>) : u64 {
        assert_valid_package_version<T0>(arg0);
        let (v0, v1, v2, v3) = 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::consume_withdraw<T0, WithdrawQueue>(arg1, arg2, witness());
        let v4 = v3;
        let v5 = v1;
        let v6 = arg0.next_key;
        arg0.next_key = arg0.next_key + 1;
        let v7 = Entry<T0>{
            balance    : v5,
            account_id : v0,
            recipient  : v2,
            extra_data : v4,
        };
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::push_back<u64, Entry<T0>>(&mut arg0.entries, v6, v7);
        let v8 = Enqueued<T0>{
            key        : v6,
            account_id : v0,
            recipient  : v2,
            amount     : 0x2::balance::value<T0>(&v5),
            route_tag  : peek_route_tag(&v4),
        };
        0x2::event::emit<Enqueued<T0>>(v8);
        v6
    }

    public fun entry<T0>(arg0: &Queue<T0>, arg1: u64) : &Entry<T0> {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::borrow<u64, Entry<T0>>(&arg0.entries, arg1)
    }

    public fun entry_account_id<T0>(arg0: &Entry<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun entry_amount<T0>(arg0: &Entry<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun entry_extra_data<T0>(arg0: &Entry<T0>) : &vector<u8> {
        &arg0.extra_data
    }

    public fun entry_recipient<T0>(arg0: &Entry<T0>) : address {
        arg0.recipient
    }

    public fun execute_native<T0, T1>(arg0: &mut Queue<T1>, arg1: u64, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: &mut 0xebd4336ac8d5a12fc7d314b84f8c06a8190dcdfc3c9ef4133ffb53e0aed3c70a::custody_vault::CustodyVault<T1>, arg4: &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version<T1>(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg2);
        if (!0x2::vec_set::contains<address>(&arg0.executors, &v0)) {
            abort 13906835862266118154
        };
        let Entry {
            balance    : v1,
            account_id : v2,
            recipient  : v3,
            extra_data : v4,
        } = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::remove<u64, Entry<T1>>(&mut arg0.entries, arg1);
        let v5 = v4;
        let v6 = v1;
        let v7 = 0xebd4336ac8d5a12fc7d314b84f8c06a8190dcdfc3c9ef4133ffb53e0aed3c70a::custody_vault::burn_authorized<T0, T1, WithdrawQueue>(arg3, arg4, witness(), package_version(), v2, 0x2::coin::from_balance<T1>(v6, arg6), arg5, arg6);
        assert!(0x2::coin::value<T0>(&v7) >= decode_native_route<T0>(&v5), 13906835935280431112);
        0x2::coin::send_funds<T0>(v7, v3);
        let v8 = ExecutedNative<T1, T0>{
            key       : arg1,
            recipient : v3,
            amount    : 0x2::balance::value<T1>(&v6),
        };
        0x2::event::emit<ExecutedNative<T1, T0>>(v8);
    }

    public fun execute_wormhole<T0>(arg0: &mut Queue<T0>, arg1: u64, arg2: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg3: &mut 0xc6129ed341b014213284742d681766c48ea3cbb287f91685f0c0ccd608e17982::wormhole_bridge::Bridge, arg4: &mut 0x86e05a9f95757ed4574cf209683e69e5e1fa4ac7ce7a529c91848343a232c989::credit_registry::CreditRegistry<T0>, arg5: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version<T0>(arg0);
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg2);
        if (!0x2::vec_set::contains<address>(&arg0.executors, &v0)) {
            abort 13906835699057360906
        };
        let Entry {
            balance    : v1,
            account_id : v2,
            recipient  : _,
            extra_data : v4,
        } = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::remove<u64, Entry<T0>>(&mut arg0.entries, arg1);
        let v5 = v4;
        let v6 = v1;
        let v7 = decode_wormhole_route(&v5);
        0xc6129ed341b014213284742d681766c48ea3cbb287f91685f0c0ccd608e17982::wormhole_bridge::burn_for_withdrawal_authorized<T0, WithdrawQueue>(arg3, arg4, witness(), package_version(), v2, arg5, 0x2::coin::from_balance<T0>(v6, arg8), arg6, v7.evm_destination_chain, v7.evm_recipient, v7.evm_token, arg7);
        let v8 = ExecutedWormhole<T0>{
            key                   : arg1,
            evm_destination_chain : v7.evm_destination_chain,
            amount                : 0x2::balance::value<T0>(&v6),
        };
        0x2::event::emit<ExecutedWormhole<T0>>(v8);
    }

    public fun front<T0>(arg0: &Queue<T0>) : &0x1::option::Option<u64> {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::front<u64, Entry<T0>>(&arg0.entries)
    }

    public fun is_empty<T0>(arg0: &Queue<T0>) : bool {
        0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::linked_table::is_empty<u64, Entry<T0>>(&arg0.entries)
    }

    public fun is_executor<T0>(arg0: &Queue<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.executors, &arg1)
    }

    public fun package_version() : u16 {
        1
    }

    fun peek_route_tag(arg0: &vector<u8>) : u8 {
        assert!(0x1::vector::length<u8>(arg0) > 0, 13906836094194089990);
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        assert!(v0 == 0 || v0 == 1, 13906836102784024582);
        v0
    }

    public fun remove_executor<T0>(arg0: &mut Queue<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: address) {
        assert_valid_package_version<T0>(arg0);
        if (!0x2::vec_set::contains<address>(&arg0.executors, &arg2)) {
            return
        };
        0x2::vec_set::remove<address>(&mut arg0.executors, &arg2);
        let v0 = ExecutorUpdated<T0>{
            executor : arg2,
            added    : false,
        };
        0x2::event::emit<ExecutorUpdated<T0>>(v0);
    }

    public fun remove_version<T0>(arg0: &mut Queue<T0>, arg1: &0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::account::AdminCap, arg2: u16) {
        if (!0x2::vec_set::contains<u16>(&arg0.allowed_versions, &arg2)) {
            return
        };
        0x2::vec_set::remove<u16>(&mut arg0.allowed_versions, &arg2);
    }

    public fun route_native<T0>(arg0: u64) : vector<u8> {
        let v0 = NativeRoute{
            asset_type : 0x1::type_name::with_defining_ids<T0>(),
            min_output : arg0,
        };
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 1);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<NativeRoute>(&v0));
        v1
    }

    public fun route_tag(arg0: &vector<u8>) : u8 {
        peek_route_tag(arg0)
    }

    public fun route_wormhole(arg0: u16, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        let v0 = WormholeRoute{
            evm_destination_chain : arg0,
            evm_recipient         : arg1,
            evm_token             : arg2,
        };
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, 0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<WormholeRoute>(&v0));
        v1
    }

    public(friend) fun witness() : WithdrawQueue {
        WithdrawQueue{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

