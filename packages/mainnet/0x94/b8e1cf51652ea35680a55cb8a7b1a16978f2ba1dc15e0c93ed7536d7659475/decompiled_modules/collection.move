module 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::collection {
    struct CreatorCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        collection: 0x2::object::ID,
    }

    struct Supply has copy, drop, store {
        max: u64,
        ends_ms: u64,
        reserve: u64,
        random: bool,
    }

    struct Art has copy, drop, store {
        placeholder: 0x1::string::String,
        base_uri: 0x1::string::String,
        ext: 0x1::string::String,
        metadata_root: 0x1::option::Option<vector<u8>>,
        provenance: 0x1::option::Option<vector<u8>>,
    }

    struct Royalty has copy, drop, store {
        bps: u16,
        min: u64,
        recipient: address,
        lock: bool,
        personal: bool,
    }

    struct Payee has copy, drop, store {
        to: address,
        bps: u16,
    }

    struct Phase has copy, drop, store {
        name: 0x1::string::String,
        start_ms: u64,
        end_ms: u64,
        price: u64,
        coin: 0x1::type_name::TypeName,
        per_wallet: u64,
        cap: u64,
        minted: u64,
        root: 0x1::option::Option<vector<u8>>,
    }

    struct WalletKey has copy, drop, store {
        phase: u64,
        who: address,
    }

    struct TillKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Till<phantom T0> has store {
        proceeds: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
    }

    struct Collection<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        project_url: 0x1::string::String,
        creator: address,
        max_supply: u64,
        ends_ms: u64,
        reserve: u64,
        reserved: u64,
        minted: u64,
        random: bool,
        stocked: u64,
        pool: 0x2::table::Table<u64, vector<u64>>,
        phases: vector<Phase>,
        wallets: 0x2::table::Table<WalletKey, u64>,
        payees: vector<Payee>,
        policy: 0x2::object::ID,
        policy_cap: 0x1::option::Option<0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>,
        royalty_recipient: address,
        display: 0x1::option::Option<0x2::display::Display<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>,
        placeholder: 0x1::string::String,
        base_uri: 0x1::string::String,
        ext: 0x1::string::String,
        metadata_root: 0x1::option::Option<vector<u8>>,
        provenance: 0x1::option::Option<vector<u8>>,
        revealed: bool,
        paused: bool,
        blocked: bool,
    }

    fun fill(arg0: &mut 0x2::table::Table<u64, vector<u64>>, arg1: u64, arg2: u64) {
        while (arg1 < arg2) {
            let v0 = arg1 / 64;
            if (arg1 % 64 == 0) {
                0x2::table::add<u64, vector<u64>>(arg0, v0, vector[]);
            };
            let v1 = 0x2::table::borrow_mut<u64, vector<u64>>(arg0, v0);
            while (arg1 < arg2 && 0x1::vector::length<u64>(v1) < 64) {
                0x1::vector::push_back<u64>(v1, arg1);
                arg1 = arg1 + 1;
            };
        };
    }

    public fun withdraw<T0, T1>(arg0: &mut Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TillKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<TillKey<T1>>(&arg0.id, v0)) {
            return
        };
        let v1 = arg0.payees;
        let v2 = TillKey<T1>{dummy_field: false};
        let v3 = 0x2::dynamic_field::borrow_mut<TillKey<T1>, Till<T1>>(&mut arg0.id, v2);
        let v4 = 0x2::balance::value<T1>(&v3.proceeds);
        let v5 = 0x2::balance::value<T1>(&v3.fees);
        if (v4 == 0 && v5 == 0) {
            return
        };
        let v6 = 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::treasury(arg1);
        let v7 = vector[];
        let v8 = vector[];
        let v9 = 0x1::vector::length<Payee>(&v1);
        let v10 = 0;
        while (v10 < v9) {
            let v11 = *0x1::vector::borrow<Payee>(&v1, v10);
            let v12 = if (v10 + 1 == v9) {
                v4
            } else {
                0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::portion(v4, v11.bps)
            };
            v4 = v4 - v12;
            send<T1>(0x2::balance::split<T1>(&mut v3.proceeds, v12), v11.to, arg2);
            0x1::vector::push_back<address>(&mut v7, v11.to);
            0x1::vector::push_back<u64>(&mut v8, v12);
            v10 = v10 + 1;
        };
        send<T1>(0x2::balance::withdraw_all<T1>(&mut v3.fees), v6, arg2);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::withdrawn(0x2::object::id<Collection<T0>>(arg0), 0x1::type_name::with_original_ids<T1>(), v4, v5, v6, v7, v8);
    }

    public fun add_phase<T0, T1>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<vector<u8>>) : u64 {
        assert_creator<T0>(arg0, arg1);
        assert!(0x1::vector::length<Phase>(&arg1.phases) < 16, 208);
        0x1::vector::push_back<Phase>(&mut arg1.phases, new_phase<T1>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, 0));
        let v0 = 0x1::vector::length<Phase>(&arg1.phases) - 1;
        emit_phase<T0>(arg1, v0);
        v0
    }

    public(friend) fun admit<T0, T1>(arg0: &mut Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u64, arg4: u64, arg5: u64, arg6: &vector<vector<u8>>, arg7: &mut 0x2::coin::Coin<T1>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) : u64 {
        gate<T0>(arg0, arg1, arg2, arg4);
        let v0 = 0x2::clock::timestamp_ms(arg9);
        assert!(arg3 < 0x1::vector::length<Phase>(&arg0.phases), 212);
        let v1 = *0x1::vector::borrow<Phase>(&arg0.phases, arg3);
        assert!(v0 >= v1.start_ms, 213);
        assert!(v0 < v1.end_ms, 214);
        assert!(0x1::type_name::with_original_ids<T1>() == v1.coin, 215);
        assert!(v1.price <= arg8, 216);
        assert!(v1.cap == 0 || v1.minted + arg4 <= v1.cap, 217);
        if (arg0.max_supply > 0) {
            assert!(arg0.minted - arg0.reserved + arg4 <= arg0.max_supply - arg0.reserve, 218);
        } else {
            assert!(v0 < arg0.ends_ms, 219);
        };
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = 0x1::option::is_some<vector<u8>>(&v1.root);
        if (v3) {
            assert!(0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::merkle::verify(0x1::option::borrow<vector<u8>>(&v1.root), 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::merkle::allow_leaf(v2, arg5), arg6), 220);
        };
        if (v3 || v1.per_wallet > 0) {
            let v4 = if (!v3) {
                v1.per_wallet
            } else if (v1.per_wallet > 0 && v1.per_wallet < arg5) {
                v1.per_wallet
            } else {
                arg5
            };
            let v5 = WalletKey{
                phase : arg3,
                who   : v2,
            };
            if (!0x2::table::contains<WalletKey, u64>(&arg0.wallets, v5)) {
                0x2::table::add<WalletKey, u64>(&mut arg0.wallets, v5, 0);
            };
            let v6 = 0x2::table::borrow_mut<WalletKey, u64>(&mut arg0.wallets, v5);
            assert!(*v6 + arg4 <= v4, 221);
            *v6 = *v6 + arg4;
        };
        let v7 = (((v1.price as u128) * (arg4 as u128)) as u64);
        if (v7 > 0) {
            let v8 = 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg7), v7);
            let v9 = TillKey<T1>{dummy_field: false};
            if (!0x2::dynamic_field::exists<TillKey<T1>>(&arg0.id, v9)) {
                let v10 = TillKey<T1>{dummy_field: false};
                let v11 = Till<T1>{
                    proceeds : 0x2::balance::zero<T1>(),
                    fees     : 0x2::balance::zero<T1>(),
                };
                0x2::dynamic_field::add<TillKey<T1>, Till<T1>>(&mut arg0.id, v10, v11);
            };
            let v12 = TillKey<T1>{dummy_field: false};
            let v13 = 0x2::dynamic_field::borrow_mut<TillKey<T1>, Till<T1>>(&mut arg0.id, v12);
            0x2::balance::join<T1>(&mut v13.fees, 0x2::balance::split<T1>(&mut v8, 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::portion(v7, 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::fee_bps(arg1))));
            0x2::balance::join<T1>(&mut v13.proceeds, v8);
        };
        0x1::vector::borrow_mut<Phase>(&mut arg0.phases, arg3).minted = v1.minted + arg4;
        v1.price
    }

    public(friend) fun admit_reserve<T0>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg3: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_creator<T0>(arg0, arg1);
        gate<T0>(arg1, arg2, arg3, arg4);
        assert!(arg1.reserved + arg4 <= arg1.reserve, 222);
        if (arg1.max_supply == 0) {
            assert!(0x2::clock::timestamp_ms(arg5) < arg1.ends_ms, 219);
        };
        arg1.reserved = arg1.reserved + arg4;
    }

    fun assert_creator<T0>(arg0: &CreatorCap<T0>, arg1: &Collection<T0>) {
        assert!(arg0.collection == 0x2::object::id<Collection<T0>>(arg1), 207);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::assert_object(arg1.version);
    }

    public fun attach<T0>(arg0: &Collection<T0>, arg1: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<vector<u8>>) {
        assert!(0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::collection<T0>(arg1) == 0x2::object::id<Collection<T0>>(arg0), 234);
        assert!(0x1::option::is_some<vector<u8>>(&arg0.metadata_root), 232);
        assert!(0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::merkle::verify(0x1::option::borrow<vector<u8>>(&arg0.metadata_root), 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::merkle::token_leaf(0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::n<T0>(arg1), &arg2, &arg3), &arg4), 233);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::set_attributes<T0>(arg1, arg2, arg3);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::traits_attached(0x2::object::id<Collection<T0>>(arg0), 0x2::object::id<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg1), 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::n<T0>(arg1));
    }

    public fun attach_in_kiosk<T0>(arg0: &Collection<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<vector<u8>>) {
        let v0 = 0x2::kiosk::borrow_mut<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg1, arg2, arg3);
        attach<T0>(arg0, v0, arg4, arg5, arg6);
    }

    public fun base_uri<T0>(arg0: &Collection<T0>) : 0x1::string::String {
        arg0.base_uri
    }

    public fun block<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::AdminCap, arg1: &mut Collection<T0>, arg2: bool) {
        arg1.blocked = arg2;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::collection_paused(0x2::object::id<Collection<T0>>(arg1), arg2, true);
    }

    fun build_payees(arg0: vector<address>, arg1: vector<u16>) : vector<Payee> {
        let v0 = 0x1::vector::length<address>(&arg0);
        let v1 = if (v0 > 0) {
            if (v0 <= 10) {
                v0 == 0x1::vector::length<u16>(&arg1)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 203);
        let v2 = 0x1::vector::empty<Payee>();
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            assert!(*0x1::vector::borrow<address>(&arg0, v4) != @0x0 && *0x1::vector::borrow<u16>(&arg1, v4) > 0, 203);
            v3 = v3 + (*0x1::vector::borrow<u16>(&arg1, v4) as u64);
            let v5 = Payee{
                to  : *0x1::vector::borrow<address>(&arg0, v4),
                bps : *0x1::vector::borrow<u16>(&arg1, v4),
            };
            0x1::vector::push_back<Payee>(&mut v2, v5);
            v4 = v4 + 1;
        };
        assert!(v3 == 10000, 203);
        v2
    }

    public fun cap_collection<T0>(arg0: &CreatorCap<T0>) : 0x2::object::ID {
        arg0.collection
    }

    public fun capped(arg0: u64, arg1: u64, arg2: bool) : Supply {
        assert!(arg0 > 0 && arg1 <= arg0, 202);
        Supply{
            max     : arg0,
            ends_ms : 0,
            reserve : arg1,
            random  : arg2,
        }
    }

    fun check_plain(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = 0x1::vector::borrow<u8>(v0, v1);
            let v3 = if (*v2 != 123) {
                if (*v2 != 125) {
                    *v2 != 92
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v3, 204);
            v1 = v1 + 1;
        };
    }

    fun check_root(arg0: &0x1::option::Option<vector<u8>>) {
        if (0x1::option::is_some<vector<u8>>(arg0)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(arg0)) == 32, 205);
        };
    }

    public fun claim_royalties<T0>(arg0: &Collection<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(arg1) == arg0.policy, 225);
        assert!(0x1::option::is_some<0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&arg0.policy_cap), 240);
        sweep_royalties<T0>(arg0, arg1, arg2)
    }

    public fun create<T0>(arg0: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::registry::Registry, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::package::Publisher, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: Supply, arg8: Art, arg9: Royalty, arg10: vector<address>, arg11: vector<u16>, arg12: &mut 0x2::tx_context::TxContext) : (Collection<T0>, CreatorCap<T0>) {
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::assert_open(arg1);
        assert!(0x2::package::from_module<T0>(arg2), 201);
        assert!(!0x1::string::is_empty(&arg3), 204);
        check_plain(&arg3);
        check_plain(&arg5);
        check_plain(&arg6);
        check_plain(&arg8.placeholder);
        check_plain(&arg8.base_uri);
        check_plain(&arg8.ext);
        let (v0, v1) = 0x2::transfer_policy::new<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::registry::publisher(arg0), arg12);
        let v2 = v1;
        let v3 = v0;
        if (arg9.bps > 0 || arg9.min > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v3, &v2, arg9.bps, arg9.min);
        };
        if (arg9.lock) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v3, &v2);
        };
        if (arg9.personal) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v3, &v2);
        };
        let v4 = 0x2::object::id<0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(v3);
        let v5 = !0x1::string::is_empty(&arg8.base_uri);
        let v6 = if (v5) {
            image_template(arg8.base_uri, arg8.ext)
        } else {
            arg8.placeholder
        };
        let v7 = 0x2::display::new<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::registry::publisher(arg0), arg12);
        0x1::string::append(&mut arg3, 0x1::string::utf8(b" #{n}"));
        0x2::display::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v7, 0x1::string::utf8(b"name"), arg3);
        0x2::display::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v7, 0x1::string::utf8(b"description"), arg5);
        0x2::display::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v7, 0x1::string::utf8(b"image_url"), v6);
        0x2::display::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v7, 0x1::string::utf8(b"thumbnail_url"), v6);
        if (!0x1::string::is_empty(&arg6)) {
            0x2::display::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v7, 0x1::string::utf8(b"project_url"), arg6);
        };
        0x2::display::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v7, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v7);
        let v8 = 0x2::object::new(arg12);
        let v9 = 0x2::object::uid_to_inner(&v8);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::registry::claim_kind<T0>(arg0, v9);
        let v10 = Collection<T0>{
            id                : v8,
            version           : 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::current(),
            name              : arg3,
            symbol            : arg4,
            description       : arg5,
            project_url       : arg6,
            creator           : 0x2::tx_context::sender(arg12),
            max_supply        : arg7.max,
            ends_ms           : arg7.ends_ms,
            reserve           : arg7.reserve,
            reserved          : 0,
            minted            : 0,
            random            : arg7.random,
            stocked           : 0,
            pool              : 0x2::table::new<u64, vector<u64>>(arg12),
            phases            : 0x1::vector::empty<Phase>(),
            wallets           : 0x2::table::new<WalletKey, u64>(arg12),
            payees            : build_payees(arg10, arg11),
            policy            : v4,
            policy_cap        : 0x1::option::some<0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(v2),
            royalty_recipient : arg9.recipient,
            display           : 0x1::option::none<0x2::display::Display<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(),
            placeholder       : arg8.placeholder,
            base_uri          : arg8.base_uri,
            ext               : arg8.ext,
            metadata_root     : arg8.metadata_root,
            provenance        : arg8.provenance,
            revealed          : v5,
            paused            : false,
            blocked           : false,
        };
        if (v5) {
            0x2::transfer::public_freeze_object<0x2::display::Display<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(v7);
        } else {
            0x1::option::fill<0x2::display::Display<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&mut v10.display, v7);
        };
        if (arg7.random) {
            let v11 = vector[];
            let v12 = 0;
            while (v12 < 64) {
                0x1::vector::push_back<u64>(&mut v11, 0);
                v12 = v12 + 1;
            };
            0x2::table::add<u64, vector<u64>>(&mut v10.pool, 18446744073709551615, v11);
        };
        let (v13, v14) = payee_vectors(&v10.payees);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::collection_created(v9, 0x1::type_name::with_original_ids<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(), v10.creator, v10.name, v10.symbol, v10.max_supply, v10.ends_ms, v10.reserve, v10.random, v4, arg9.bps, arg9.min, arg9.recipient, arg9.lock, arg9.personal, v5, v10.metadata_root, v10.provenance, v13, v14);
        let v15 = CreatorCap<T0>{
            id         : 0x2::object::new(arg12),
            collection : v9,
        };
        (v10, v15)
    }

    public fun creator<T0>(arg0: &Collection<T0>) : address {
        arg0.creator
    }

    public fun edit_phase<T0, T1>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x1::option::Option<vector<u8>>) {
        assert_creator<T0>(arg0, arg1);
        assert!(arg2 < 0x1::vector::length<Phase>(&arg1.phases), 212);
        *0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2) = new_phase<T1>(arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x1::vector::borrow<Phase>(&arg1.phases, arg2).minted);
        emit_phase<T0>(arg1, arg2);
    }

    fun emit_phase<T0>(arg0: &Collection<T0>, arg1: u64) {
        let v0 = 0x1::vector::borrow<Phase>(&arg0.phases, arg1);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::phase_set(0x2::object::id<Collection<T0>>(arg0), arg1, v0.name, v0.start_ms, v0.end_ms, v0.price, v0.coin, v0.per_wallet, v0.cap, v0.root);
    }

    public fun ends_ms<T0>(arg0: &Collection<T0>) : u64 {
        arg0.ends_ms
    }

    public fun feature<T0>(arg0: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::AdminCap, arg1: &mut 0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::registry::Registry, arg2: &Collection<T0>, arg3: 0x1::string::String) {
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::registry::add_featured(arg1, 0x1::type_name::with_original_ids<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(), arg2.name, arg3, arg2.creator, 0x1::option::some<0x2::object::ID>(0x2::object::id<Collection<T0>>(arg2)));
    }

    fun gate<T0>(arg0: &Collection<T0>, arg1: &0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::Config, arg2: &0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u64) {
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::assert_open(arg1);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::platform::assert_object(arg0.version);
        assert!(!arg0.paused && !arg0.blocked, 210);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(arg2) == arg0.policy, 225);
        assert!(arg3 > 0 && arg3 <= 100, 211);
        if (arg0.random) {
            assert!(arg0.stocked == arg0.max_supply, 224);
        };
    }

    public fun has_policy_cap<T0>(arg0: &Collection<T0>) : bool {
        0x1::option::is_some<0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&arg0.policy_cap)
    }

    public fun hidden_art(arg0: 0x1::string::String, arg1: 0x1::option::Option<vector<u8>>) : Art {
        assert!(!0x1::string::is_empty(&arg0), 206);
        check_root(&arg1);
        Art{
            placeholder   : arg0,
            base_uri      : 0x1::string::utf8(b""),
            ext           : 0x1::string::utf8(b""),
            metadata_root : 0x1::option::none<vector<u8>>(),
            provenance    : arg1,
        }
    }

    fun image_template(arg0: 0x1::string::String, arg1: 0x1::string::String) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"/{n}."));
        0x1::string::append(&mut arg0, arg1);
        arg0
    }

    public fun is_blocked<T0>(arg0: &Collection<T0>) : bool {
        arg0.blocked
    }

    public fun is_paused<T0>(arg0: &Collection<T0>) : bool {
        arg0.paused
    }

    public fun is_random<T0>(arg0: &Collection<T0>) : bool {
        arg0.random
    }

    public fun is_revealed<T0>(arg0: &Collection<T0>) : bool {
        arg0.revealed
    }

    public fun max_supply<T0>(arg0: &Collection<T0>) : u64 {
        arg0.max_supply
    }

    public fun metadata_root<T0>(arg0: &Collection<T0>) : 0x1::option::Option<vector<u8>> {
        arg0.metadata_root
    }

    public fun minted<T0>(arg0: &Collection<T0>) : u64 {
        arg0.minted
    }

    public fun minted_by<T0>(arg0: &Collection<T0>, arg1: u64, arg2: address) : u64 {
        let v0 = WalletKey{
            phase : arg1,
            who   : arg2,
        };
        if (0x2::table::contains<WalletKey, u64>(&arg0.wallets, v0)) {
            *0x2::table::borrow<WalletKey, u64>(&arg0.wallets, v0)
        } else {
            0
        }
    }

    public fun name<T0>(arg0: &Collection<T0>) : 0x1::string::String {
        arg0.name
    }

    fun new_phase<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<vector<u8>>, arg7: u64) : Phase {
        assert!(arg1 < arg2, 209);
        check_root(&arg6);
        Phase{
            name       : arg0,
            start_ms   : arg1,
            end_ms     : arg2,
            price      : arg3,
            coin       : 0x1::type_name::with_original_ids<T0>(),
            per_wallet : arg4,
            cap        : arg5,
            minted     : arg7,
            root       : arg6,
        }
    }

    public(friend) fun next_at_random<T0>(arg0: &mut Collection<T0>, arg1: &mut 0x2::random::RandomGenerator) : u64 {
        assert!(arg0.random, 223);
        let v0 = arg0.max_supply - arg0.minted;
        let v1 = &mut arg0.pool;
        arg0.minted = arg0.minted + 1;
        take(v1, v0, ((0x2::random::generate_u128(arg1) % (v0 as u128)) as u64)) + 1
    }

    public(friend) fun next_in_order<T0>(arg0: &mut Collection<T0>) : u64 {
        assert!(!arg0.random, 223);
        arg0.minted = arg0.minted + 1;
        arg0.minted
    }

    public fun open_edition(arg0: u64, arg1: u64) : Supply {
        assert!(arg0 > 0, 202);
        Supply{
            max     : 0,
            ends_ms : arg0,
            reserve : arg1,
            random  : false,
        }
    }

    fun payee_vectors(arg0: &vector<Payee>) : (vector<address>, vector<u64>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Payee>(arg0)) {
            let v3 = 0x1::vector::borrow<Payee>(arg0, v2);
            0x1::vector::push_back<address>(&mut v0, v3.to);
            0x1::vector::push_back<u64>(&mut v1, (v3.bps as u64));
            v2 = v2 + 1;
        };
        (v0, v1)
    }

    public fun payees<T0>(arg0: &Collection<T0>) : (vector<address>, vector<u64>) {
        payee_vectors(&arg0.payees)
    }

    public fun phase<T0>(arg0: &Collection<T0>, arg1: u64) : Phase {
        *0x1::vector::borrow<Phase>(&arg0.phases, arg1)
    }

    public fun phase_coin(arg0: &Phase) : 0x1::type_name::TypeName {
        arg0.coin
    }

    public fun phase_count<T0>(arg0: &Collection<T0>) : u64 {
        0x1::vector::length<Phase>(&arg0.phases)
    }

    public fun phase_minted(arg0: &Phase) : u64 {
        arg0.minted
    }

    public fun phase_price(arg0: &Phase) : u64 {
        arg0.price
    }

    public fun phase_window(arg0: &Phase) : (u64, u64) {
        (arg0.start_ms, arg0.end_ms)
    }

    public fun policy<T0>(arg0: &Collection<T0>) : 0x2::object::ID {
        arg0.policy
    }

    public(friend) fun policy_id<T0>(arg0: &Collection<T0>) : 0x2::object::ID {
        arg0.policy
    }

    public fun provenance<T0>(arg0: &Collection<T0>) : 0x1::option::Option<vector<u8>> {
        arg0.provenance
    }

    public fun release_policy_cap<T0>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: &mut 0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>> {
        assert_creator<T0>(arg0, arg1);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(arg2) == arg1.policy, 225);
        assert!(0x1::option::is_some<0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&arg1.policy_cap), 240);
        sweep_royalties<T0>(arg1, arg2, arg3);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::policy_cap_released(0x2::object::id<Collection<T0>>(arg1));
        0x1::option::extract<0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&mut arg1.policy_cap)
    }

    public fun reserve<T0>(arg0: &Collection<T0>) : u64 {
        arg0.reserve
    }

    public fun reserved<T0>(arg0: &Collection<T0>) : u64 {
        arg0.reserved
    }

    public fun reveal<T0>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::option::Option<vector<u8>>) {
        assert_creator<T0>(arg0, arg1);
        assert!(!arg1.revealed, 230);
        assert!(!0x1::string::is_empty(&arg2) && !0x1::string::is_empty(&arg3), 206);
        check_plain(&arg2);
        check_plain(&arg3);
        check_root(&arg4);
        if (0x1::option::is_some<vector<u8>>(&arg1.provenance)) {
            assert!(0x1::option::is_some<vector<u8>>(&arg4), 231);
            assert!(0x2::hash::blake2b256(0x1::option::borrow<vector<u8>>(&arg4)) == *0x1::option::borrow<vector<u8>>(&arg1.provenance), 231);
        };
        let v0 = image_template(arg2, arg3);
        let v1 = 0x1::option::extract<0x2::display::Display<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&mut arg1.display);
        0x2::display::edit<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v1, 0x1::string::utf8(b"image_url"), v0);
        0x2::display::edit<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v1, 0x1::string::utf8(b"thumbnail_url"), v0);
        0x2::display::update_version<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(&mut v1);
        0x2::transfer::public_freeze_object<0x2::display::Display<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(v1);
        arg1.base_uri = arg2;
        arg1.ext = arg3;
        arg1.metadata_root = arg4;
        arg1.revealed = true;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::revealed(0x2::object::id<Collection<T0>>(arg1), arg2, arg3, arg4);
    }

    public fun revealed_art(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::option::Option<vector<u8>>) : Art {
        assert!(!0x1::string::is_empty(&arg0) && !0x1::string::is_empty(&arg1), 206);
        check_root(&arg2);
        Art{
            placeholder   : arg0,
            base_uri      : arg0,
            ext           : arg1,
            metadata_root : arg2,
            provenance    : 0x1::option::none<vector<u8>>(),
        }
    }

    public fun royalty(arg0: u16, arg1: u64, arg2: address, arg3: bool, arg4: bool) : Royalty {
        assert!(arg0 <= (10000 as u16), 203);
        Royalty{
            bps       : arg0,
            min       : arg1,
            recipient : arg2,
            lock      : arg3,
            personal  : arg4,
        }
    }

    public fun royalty_recipient<T0>(arg0: &Collection<T0>) : address {
        arg0.royalty_recipient
    }

    fun send<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    public fun set_paused<T0>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: bool) {
        assert_creator<T0>(arg0, arg1);
        arg1.paused = arg2;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::collection_paused(0x2::object::id<Collection<T0>>(arg1), arg2, false);
    }

    public fun set_payees<T0>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: vector<address>, arg3: vector<u16>) {
        assert_creator<T0>(arg0, arg1);
        assert!(arg1.minted == arg1.reserved, 241);
        arg1.payees = build_payees(arg2, arg3);
        let (v0, v1) = payee_vectors(&arg1.payees);
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::payees_set(0x2::object::id<Collection<T0>>(arg1), v0, v1);
    }

    public fun set_royalty<T0>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: &mut 0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg3: u16, arg4: u64) {
        assert_creator<T0>(arg0, arg1);
        assert!(0x2::object::id<0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(arg2) == arg1.policy, 225);
        assert!(0x1::option::is_some<0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&arg1.policy_cap), 240);
        let v0 = 0x1::option::borrow<0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&arg1.policy_cap);
        if (0x2::transfer_policy::has_rule<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg2)) {
            0x2::transfer_policy::remove_rule<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Config>(arg2, v0);
        };
        if (arg3 > 0 || arg4 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg2, v0, arg3, arg4);
        };
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::royalty_set(0x2::object::id<Collection<T0>>(arg1), 0x1::option::some<u16>(arg3), 0x1::option::some<u64>(arg4), arg1.royalty_recipient);
    }

    public fun set_royalty_recipient<T0>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: address) {
        assert_creator<T0>(arg0, arg1);
        arg1.royalty_recipient = arg2;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::royalty_set(0x2::object::id<Collection<T0>>(arg1), 0x1::option::none<u16>(), 0x1::option::none<u64>(), arg2);
    }

    public fun share<T0>(arg0: Collection<T0>) {
        0x2::transfer::share_object<Collection<T0>>(arg0);
    }

    public fun stock<T0>(arg0: &CreatorCap<T0>, arg1: &mut Collection<T0>, arg2: u64) {
        assert_creator<T0>(arg0, arg1);
        assert!(arg1.random, 223);
        assert!(arg1.stocked < arg1.max_supply, 226);
        let v0 = if (arg2 > 16384) {
            16384
        } else {
            arg2
        };
        let v1 = if (arg1.stocked + v0 > arg1.max_supply) {
            arg1.max_supply
        } else {
            arg1.stocked + v0
        };
        let v2 = &mut arg1.pool;
        fill(v2, arg1.stocked, v1);
        arg1.stocked = v1;
        0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::stocked(0x2::object::id<Collection<T0>>(arg1), arg1.stocked, arg1.max_supply);
    }

    public fun stocked<T0>(arg0: &Collection<T0>) : u64 {
        arg0.stocked
    }

    fun sweep_royalties<T0>(arg0: &Collection<T0>, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::transfer_policy::withdraw<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>(arg1, 0x1::option::borrow<0x2::transfer_policy::TransferPolicyCap<0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::nft::Nft<T0>>>(&arg0.policy_cap), 0x1::option::none<u64>(), arg2);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        if (v1 == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.royalty_recipient);
            0x94b8e1cf51652ea35680a55cb8a7b1a16978f2ba1dc15e0c93ed7536d7659475::events::royalties_claimed(0x2::object::id<Collection<T0>>(arg0), v1, arg0.royalty_recipient);
        };
        v1
    }

    public fun symbol<T0>(arg0: &Collection<T0>) : 0x1::string::String {
        arg0.symbol
    }

    public(friend) fun take(arg0: &mut 0x2::table::Table<u64, vector<u64>>, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1 - 1;
        let v1 = v0 / 64;
        let v2 = v0 % 64;
        let v3 = arg2 / 64;
        let v4 = arg2 % 64;
        let v5 = ((((v1 - v3) as u128) + 18446744073709551615 >> 64) as u64);
        let v6 = 1 - v5;
        let v7 = 0x2::table::borrow_mut<u64, vector<u64>>(arg0, v1);
        let v8 = *0x1::vector::borrow<u64>(v7, v2);
        let v9 = v4 * v6 + v2 * v5;
        let v10 = *0x1::vector::borrow<u64>(v7, v9);
        *0x1::vector::borrow_mut<u64>(v7, v9) = v8;
        0x1::vector::pop_back<u64>(v7);
        let v11 = 0x2::table::borrow_mut<u64, vector<u64>>(arg0, v3 * v5 + 18446744073709551615 * v6);
        let v12 = v4 * v5;
        let v13 = *0x1::vector::borrow<u64>(v11, v12);
        *0x1::vector::borrow_mut<u64>(v11, v12) = v8 * v5 + (v13 + 1) * v6;
        if (v2 == 0) {
            0x1::vector::destroy_empty<u64>(0x2::table::remove<u64, vector<u64>>(arg0, v1));
        };
        v10 * v6 + v13 * v5
    }

    public fun till<T0, T1>(arg0: &Collection<T0>) : (u64, u64) {
        let v0 = TillKey<T1>{dummy_field: false};
        if (!0x2::dynamic_field::exists<TillKey<T1>>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = TillKey<T1>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<TillKey<T1>, Till<T1>>(&arg0.id, v1);
        (0x2::balance::value<T1>(&v2.proceeds), 0x2::balance::value<T1>(&v2.fees))
    }

    // decompiled from Move bytecode v7
}

