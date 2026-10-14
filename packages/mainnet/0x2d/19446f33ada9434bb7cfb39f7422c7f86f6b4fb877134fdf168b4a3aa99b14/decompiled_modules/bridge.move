module 0x2d19446f33ada9434bb7cfb39f7422c7f86f6b4fb877134fdf168b4a3aa99b14::bridge {
    struct BridgeAuth has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        keepers: 0x2::vec_set::VecSet<address>,
        fee_bps: u64,
        fees: 0x2::balance::Balance<T0>,
        cash: 0x2::balance::Balance<T0>,
        wait_ms: u64,
        transfers: 0x2::table::Table<Key, Transfer>,
        owed: u64,
    }

    struct Key has copy, drop, store {
        source: u32,
        nonce: u256,
    }

    struct Transfer has drop, store {
        id: vector<u8>,
        user: address,
        target: 0x1::ascii::String,
        min_out: u64,
        gas_usdc: u64,
        gas_min_sui: u64,
        amount: u64,
        noted_ms: u64,
        state: u8,
        out: u64,
        sui_out: u64,
        fee: u64,
    }

    struct Guard {
        vault: 0x2::object::ID,
        source: u32,
        nonce: u256,
    }

    struct Delivery<phantom T0> {
        vault: 0x2::object::ID,
        key: Key,
        user: address,
        min_out: u64,
        gas_min_sui: u64,
    }

    struct Noted has copy, drop {
        vault: 0x2::object::ID,
        source: u32,
        nonce: u256,
        id: vector<u8>,
        user: address,
        target: 0x1::ascii::String,
        amount: u64,
        min_out: u64,
        gas_usdc: u64,
        gas_min_sui: u64,
        bad_hook: bool,
    }

    struct Delivered has copy, drop {
        vault: 0x2::object::ID,
        source: u32,
        nonce: u256,
        id: vector<u8>,
        user: address,
        target: 0x1::ascii::String,
        out: u64,
        sui_out: u64,
        fee: u64,
        keeper: address,
    }

    struct UsdcSent has copy, drop {
        vault: 0x2::object::ID,
        source: u32,
        nonce: u256,
        id: vector<u8>,
        user: address,
        amount: u64,
        by: address,
    }

    struct Collected has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
    }

    struct SettingsChanged has copy, drop {
        keepers: vector<address>,
        fee_bps: u64,
        wait_ms: u64,
    }

    fun assert_version<T0>(arg0: &Vault<T0>) {
        assert!(arg0.version == 1, 1);
    }

    fun be_address(arg0: &vector<u8>, arg1: u64) : address {
        0x2::address::from_u256(be_u256(arg0, arg1))
    }

    fun be_u256(arg0: &vector<u8>, arg1: u64) : u256 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 32) {
            let v2 = v0 << 8;
            v0 = v2 | (*0x1::vector::borrow<u8>(arg0, arg1 + v1) as u256);
            v1 = v1 + 1;
        };
        v0
    }

    fun be_u32(arg0: &vector<u8>, arg1: u64) : u32 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u32) << 24 | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u32) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u32) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u32)
    }

    public fun cash<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.cash)
    }

    fun changed<T0>(arg0: &Vault<T0>) {
        let v0 = SettingsChanged{
            keepers : 0x2::vec_set::into_keys<address>(arg0.keepers),
            fee_bps : arg0.fee_bps,
            wait_ms : arg0.wait_ms,
        };
        0x2::event::emit<SettingsChanged>(v0);
    }

    public fun collect<T0>(arg0: &mut Vault<T0>, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1);
        let v1 = Collected{
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            amount : 0x2::coin::value<T0>(&v0),
        };
        0x2::event::emit<Collected>(v1);
        0x2::balance::join<T0>(&mut arg0.cash, 0x2::coin::into_balance<T0>(v0));
    }

    public fun create<T0>(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id        : 0x2::object::new(arg1),
            version   : 1,
            keepers   : 0x2::vec_set::empty<address>(),
            fee_bps   : 0,
            fees      : 0x2::balance::zero<T0>(),
            cash      : 0x2::balance::zero<T0>(),
            wait_ms   : 3600000,
            transfers : 0x2::table::new<Key, Transfer>(arg1),
            owed      : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deliver<T0, T1>(arg0: &mut Vault<T0>, arg1: Delivery<T1>, arg2: 0x2::coin::Coin<T1>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::tx_context::TxContext) {
        let Delivery {
            vault       : v0,
            key         : v1,
            user        : v2,
            min_out     : v3,
            gas_min_sui : v4,
        } = arg1;
        let v5 = v1;
        assert!(v0 == 0x2::object::id<Vault<T0>>(arg0), 6);
        assert!(0x2::coin::value<T1>(&arg2) >= v3 && 0x2::coin::value<T1>(&arg2) > 0, 4);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v4, 4);
        let v6 = 0x2::table::borrow_mut<Key, Transfer>(&mut arg0.transfers, v5);
        v6.state = 1;
        v6.out = 0x2::coin::value<T1>(&arg2);
        v6.sui_out = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v7 = Delivered{
            vault   : v0,
            source  : v5.source,
            nonce   : v5.nonce,
            id      : v6.id,
            user    : v2,
            target  : v6.target,
            out     : 0x2::coin::value<T1>(&arg2),
            sui_out : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            fee     : v6.fee,
            keeper  : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Delivered>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v2);
        if (0x2::coin::value<0x2::sui::SUI>(&arg3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v2);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
    }

    public fun destination_caller() : address {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_identifier<BridgeAuth>()
    }

    public fun fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.fee_bps
    }

    public fun fees<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    public fun give_usdc<T0>(arg0: &mut Vault<T0>, arg1: u32, arg2: u256, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = Key{
            source : arg1,
            nonce  : arg2,
        };
        assert!(0x2::table::contains<Key, Transfer>(&arg0.transfers, v0), 9);
        let v1 = 0x2::table::borrow<Key, Transfer>(&arg0.transfers, v0);
        assert!(v1.state == 0, 3);
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = if (0x2::vec_set::contains<address>(&arg0.keepers, &v2)) {
            true
        } else if (0x2::tx_context::sender(arg4) == v1.user) {
            true
        } else {
            0x2::clock::timestamp_ms(arg3) >= v1.noted_ms + arg0.wait_ms
        };
        assert!(v3, 11);
        send_usdc<T0>(arg0, v0, arg4);
    }

    public fun has_transfer<T0>(arg0: &Vault<T0>, arg1: u32, arg2: u256) : bool {
        let v0 = Key{
            source : arg1,
            nonce  : arg2,
        };
        0x2::table::contains<Key, Transfer>(&arg0.transfers, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_keeper<T0>(arg0: &Vault<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.keepers, &arg1)
    }

    fun le_u64(arg0: &vector<u8>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 8;
        while (v1 > 0) {
            let v2 = v1 - 1;
            v1 = v2;
            let v3 = v0 << 8;
            v0 = v3 | (*0x1::vector::borrow<u8>(arg0, arg1 + v2) as u64);
        };
        v0
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    public fun note<T0>(arg0: &mut Vault<T0>, arg1: Guard, arg2: 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::Receipt, arg3: &0x2::clock::Clock) : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::Receipt {
        assert_version<T0>(arg0);
        let Guard {
            vault  : v0,
            source : v1,
            nonce  : v2,
        } = arg1;
        assert!(v0 == 0x2::object::id<Vault<T0>>(arg0), 6);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::source_domain(&arg2) == v1 && 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::nonce(&arg2) == v2, 6);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::recipient(&arg2) == @0xf47842a2b5ac4483731927a7500175a9354d2eccd94312aa591ec50b9e8657e6, 7);
        let v3 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::message_body(&arg2);
        assert!(0x1::vector::length<u8>(v3) >= 228, 7);
        assert!(be_address(v3, 36) == 0x2::object::uid_to_address(&arg0.id), 7);
        let v4 = be_u256(v3, 68);
        let v5 = be_u256(v3, 164);
        assert!(v5 < v4 && v4 - v5 <= 18446744073709551615, 7);
        let v6 = ((v4 - v5) as u64);
        let v7 = Key{
            source : v1,
            nonce  : v2,
        };
        assert!(!0x2::table::contains<Key, Transfer>(&arg0.transfers, v7), 8);
        let v8 = slice(v3, 228, 0x1::vector::length<u8>(v3));
        let v9 = read_hook(&v8, v6, 0x2::clock::timestamp_ms(arg3));
        let v10 = Noted{
            vault       : v0,
            source      : v1,
            nonce       : v2,
            id          : v9.id,
            user        : v9.user,
            target      : v9.target,
            amount      : v6,
            min_out     : v9.min_out,
            gas_usdc    : v9.gas_usdc,
            gas_min_sui : v9.gas_min_sui,
            bad_hook    : v9.state == 3,
        };
        0x2::event::emit<Noted>(v10);
        arg0.owed = arg0.owed + v6;
        0x2::table::add<Key, Transfer>(&mut arg0.transfers, v7, v9);
        arg2
    }

    public fun owed<T0>(arg0: &Vault<T0>) : u64 {
        arg0.owed
    }

    fun read_hook(arg0: &vector<u8>, arg1: u64, arg2: u64) : Transfer {
        let v0 = Transfer{
            id          : b"",
            user        : @0x0,
            target      : 0x1::ascii::string(b""),
            min_out     : 0,
            gas_usdc    : 0,
            gas_min_sui : 0,
            amount      : arg1,
            noted_ms    : arg2,
            state       : 3,
            out         : 0,
            sui_out     : 0,
            fee         : 0,
        };
        if (0x1::vector::length<u8>(arg0) < 80) {
            return v0
        };
        if (slice(arg0, 0, 4) != b"PPXB" || *0x1::vector::borrow<u8>(arg0, 4) != 1) {
            return v0
        };
        let v1 = (*0x1::vector::borrow<u8>(arg0, 80 - 2) as u64) | (*0x1::vector::borrow<u8>(arg0, 80 - 1) as u64) << 8;
        if (v1 == 0 || 0x1::vector::length<u8>(arg0) != 80 + v1) {
            return v0
        };
        let v2 = 0x1::ascii::try_string(slice(arg0, 80, 80 + v1));
        if (0x1::option::is_none<0x1::ascii::String>(&v2)) {
            return v0
        };
        let v3 = be_address(arg0, 22);
        if (v3 == @0x0) {
            return v0
        };
        Transfer{
            id          : slice(arg0, 6, 22),
            user        : v3,
            target      : 0x1::option::destroy_some<0x1::ascii::String>(v2),
            min_out     : le_u64(arg0, 54),
            gas_usdc    : le_u64(arg0, 62),
            gas_min_sui : le_u64(arg0, 70),
            amount      : arg1,
            noted_ms    : arg2,
            state       : 0,
            out         : 0,
            sui_out     : 0,
            fee         : 0,
        }
    }

    public fun resolve_bad_hook<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u32, arg3: u256, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg1);
        let v0 = Key{
            source : arg2,
            nonce  : arg3,
        };
        assert!(0x2::table::contains<Key, Transfer>(&arg1.transfers, v0), 9);
        let v1 = 0x2::table::borrow_mut<Key, Transfer>(&mut arg1.transfers, v0);
        assert!(v1.state == 3, 3);
        v1.user = arg4;
        v1.state = 0;
        send_usdc<T0>(arg1, v0, arg5);
    }

    fun send_usdc<T0>(arg0: &mut Vault<T0>, arg1: Key, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<Key, Transfer>(&mut arg0.transfers, arg1);
        let v1 = v0.user;
        let v2 = v0.amount;
        assert!(0x2::balance::value<T0>(&arg0.cash) >= v2, 12);
        v0.state = 2;
        v0.out = v2;
        arg0.owed = arg0.owed - v2;
        let v3 = UsdcSent{
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            source : arg1.source,
            nonce  : arg1.nonce,
            id     : v0.id,
            user   : v1,
            amount : v2,
            by     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<UsdcSent>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.cash, v2), arg2), v1);
    }

    public fun set_fee_bps<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64) {
        assert_version<T0>(arg1);
        assert!(arg2 < 10000, 10);
        arg1.fee_bps = arg2;
        changed<T0>(arg1);
    }

    public fun set_keeper<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: address, arg3: bool) {
        assert_version<T0>(arg1);
        if (arg3 && !0x2::vec_set::contains<address>(&arg1.keepers, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.keepers, arg2);
        };
        if (!arg3 && 0x2::vec_set::contains<address>(&arg1.keepers, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.keepers, &arg2);
        };
        changed<T0>(arg1);
    }

    public fun set_wait<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: u64) {
        assert_version<T0>(arg1);
        assert!(arg2 >= 60000 && arg2 <= 604800000, 10);
        arg1.wait_ms = arg2;
        changed<T0>(arg1);
    }

    fun slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = b"";
        while (arg1 < arg2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun sweep_surplus<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg1);
        let v0 = if (0x2::balance::value<T0>(&arg1.cash) > arg1.owed) {
            0x2::balance::value<T0>(&arg1.cash) - arg1.owed
        } else {
            0
        };
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.cash, v0), arg2)
    }

    public fun take<T0, T1>(arg0: &mut Vault<T0>, arg1: u32, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T0>, Delivery<T1>) {
        assert_version<T0>(arg0);
        let v0 = Key{
            source : arg1,
            nonce  : arg2,
        };
        assert!(0x2::table::contains<Key, Transfer>(&arg0.transfers, v0), 9);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = 0x2::table::borrow_mut<Key, Transfer>(&mut arg0.transfers, v0);
        assert!(0x2::vec_set::contains<address>(&arg0.keepers, &v1) || 0x2::tx_context::sender(arg3) == v2.user, 2);
        assert!(v2.state == 0, 3);
        assert!(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()) == v2.target, 5);
        let v3 = (((v2.amount as u128) * (arg0.fee_bps as u128) / (10000 as u128)) as u64);
        let v4 = v2.amount - v3;
        let v5 = if (v2.gas_usdc <= v4) {
            v2.gas_usdc
        } else {
            0
        };
        v2.state = 4;
        v2.fee = v3;
        let v6 = if (v5 > 0) {
            v2.gas_min_sui
        } else {
            0
        };
        let v7 = v2.amount;
        assert!(0x2::balance::value<T0>(&arg0.cash) >= v7, 12);
        arg0.owed = arg0.owed - v7;
        0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut arg0.cash, v3));
        let v8 = Delivery<T1>{
            vault       : 0x2::object::id<Vault<T0>>(arg0),
            key         : v0,
            user        : v2.user,
            min_out     : v2.min_out,
            gas_min_sui : v6,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.cash, v4 - v5), arg3), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.cash, v5), arg3), v8)
    }

    public fun ticket<T0>(arg0: &Vault<T0>, arg1: vector<u8>, arg2: vector<u8>) : (0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::ReceiveMessageTicket<BridgeAuth>, Guard) {
        assert_version<T0>(arg0);
        assert!(0x1::vector::length<u8>(&arg1) > 148 + 228, 7);
        let v0 = Guard{
            vault  : 0x2::object::id<Vault<T0>>(arg0),
            source : be_u32(&arg1, 4),
            nonce  : be_u256(&arg1, 12),
        };
        let v1 = BridgeAuth{dummy_field: false};
        (0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::create_receive_message_ticket<BridgeAuth>(v1, arg1, arg2), v0)
    }

    public fun transfer_info<T0>(arg0: &Vault<T0>, arg1: u32, arg2: u256) : (address, 0x1::ascii::String, u64, u64, u64, u64, u8, u64, u64, u64) {
        let v0 = Key{
            source : arg1,
            nonce  : arg2,
        };
        let v1 = 0x2::table::borrow<Key, Transfer>(&arg0.transfers, v0);
        (v1.user, v1.target, v1.amount, v1.min_out, v1.gas_usdc, v1.gas_min_sui, v1.state, v1.out, v1.sui_out, v1.fee)
    }

    public fun wait_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.wait_ms
    }

    public fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg1);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.fees), arg2)
    }

    // decompiled from Move bytecode v7
}

