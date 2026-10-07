module 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::identity {
    struct IdentityBook has key {
        id: 0x2::object::UID,
        vaults: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
        version: u64,
    }

    struct IdentityVault has key {
        id: 0x2::object::UID,
        provider: 0x1::string::String,
        subject: 0x1::string::String,
        bound: 0x1::option::Option<address>,
        pending: 0x1::option::Option<address>,
        ready_ms: u64,
    }

    struct RedirectKey has copy, drop, store {
        curve_id: 0x2::object::ID,
    }

    struct Redirect has copy, drop, store {
        to: address,
        ready_ms: u64,
    }

    struct RedirectSeqKey has copy, drop, store {
        curve_id: 0x2::object::ID,
    }

    struct BookCreated has copy, drop {
        book_id: 0x2::object::ID,
    }

    struct VaultOpened has copy, drop {
        vault: address,
        provider: 0x1::string::String,
        subject: 0x1::string::String,
    }

    struct PayoutAttested has copy, drop {
        vault: address,
        wallet: address,
        ready_ms: u64,
    }

    struct TransferProposed has copy, drop {
        vault: address,
        from: address,
        to: address,
    }

    struct PayoutBound has copy, drop {
        vault: address,
        wallet: address,
    }

    struct Swept has copy, drop {
        vault: address,
        to: address,
        amount: u64,
    }

    struct CurveClaimed has copy, drop {
        curve_id: 0x2::object::ID,
        vault: address,
        to: address,
    }

    struct UnclaimedRedirected has copy, drop {
        curve_id: 0x2::object::ID,
        vault: address,
        to: address,
    }

    struct RedirectProposed has copy, drop {
        curve_id: 0x2::object::ID,
        vault: address,
        to: address,
        ready_ms: u64,
    }

    struct RedirectCancelled has copy, drop {
        curve_id: 0x2::object::ID,
        vault: address,
    }

    public fun accept(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg1: &mut IdentityVault, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg0);
        assert!(arg1.pending == 0x1::option::some<address>(0x2::tx_context::sender(arg3)), 303);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.ready_ms, 307);
        arg1.pending = 0x1::option::none<address>();
        arg1.bound = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        let v0 = PayoutBound{
            vault  : 0x2::object::id_address<IdentityVault>(arg1),
            wallet : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<PayoutBound>(v0);
    }

    public fun attest(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::AdminCap, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: &mut IdentityVault, arg3: address, arg4: &0x2::clock::Clock) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(0x1::option::is_none<address>(&arg2.bound), 301);
        assert!(arg3 != @0x0, 300);
        let v0 = 0x2::clock::timestamp_ms(arg4) + 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::identity_admin_delay_ms();
        arg2.pending = 0x1::option::some<address>(arg3);
        arg2.ready_ms = v0;
        let v1 = PayoutAttested{
            vault    : 0x2::object::id_address<IdentityVault>(arg2),
            wallet   : arg3,
            ready_ms : v0,
        };
        0x2::event::emit<PayoutAttested>(v1);
    }

    public fun book_version(arg0: &IdentityBook) : u64 {
        arg0.version
    }

    public fun cancel_redirect<T0, T1>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::AdminCap, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: &mut IdentityVault, arg3: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        let v0 = RedirectKey{curve_id: 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg3)};
        assert!(0x2::dynamic_field::exists<RedirectKey>(&arg2.id, v0), 308);
        0x2::dynamic_field::remove<RedirectKey, Redirect>(&mut arg2.id, v0);
        take_seq(arg2, 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg3));
        let v1 = RedirectCancelled{
            curve_id : 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg3),
            vault    : 0x2::object::id_address<IdentityVault>(arg2),
        };
        0x2::event::emit<RedirectCancelled>(v1);
    }

    public fun claim_curve<T0, T1>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg1: &IdentityVault, arg2: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg3: &0x2::tx_context::TxContext) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg0);
        assert!(arg1.bound == 0x1::option::some<address>(0x2::tx_context::sender(arg3)), 305);
        let v0 = 0x2::object::id_address<IdentityVault>(arg1);
        assert!(0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::creator_fee_recipient<T0, T1>(arg2) == v0, 304);
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::claim_fee_recipient<T0, T1>(arg2, 0x2::tx_context::sender(arg3));
        let v1 = CurveClaimed{
            curve_id : 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg2),
            vault    : v0,
            to       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<CurveClaimed>(v1);
    }

    public fun contest_cto<T0, T1>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg1: &IdentityVault, arg2: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg0);
        assert!(arg1.bound == 0x1::option::some<address>(0x2::tx_context::sender(arg4)), 305);
        assert!(0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::creator_fee_recipient<T0, T1>(arg2) == 0x2::object::id_address<IdentityVault>(arg1), 304);
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::contest_cto_internal<T0, T1>(arg2, 0x2::tx_context::sender(arg4), 0x2::clock::timestamp_ms(arg3));
    }

    public fun create_book(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::AdminCap, arg1: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        let v0 = IdentityBook{
            id      : 0x2::object::new(arg2),
            vaults  : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg2),
            version : 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::package_version(),
        };
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::register_identity_book(arg1, 0x2::object::id<IdentityBook>(&v0));
        let v1 = BookCreated{book_id: 0x2::object::id<IdentityBook>(&v0)};
        0x2::event::emit<BookCreated>(v1);
        0x2::transfer::share_object<IdentityBook>(v0);
    }

    fun identity_key(arg0: &0x1::string::String, arg1: &0x1::string::String) : vector<u8> {
        let v0 = *0x1::string::as_bytes(arg0);
        assert!(v0 == b"x" || v0 == b"github", 300);
        let v1 = *0x1::string::as_bytes(arg1);
        let v2 = 0x1::vector::length<u8>(&v1);
        assert!(v2 > 0 && v2 <= 32, 300);
        let v3 = 0;
        while (v3 < v2) {
            assert!(*0x1::vector::borrow<u8>(&v1, v3) >= 48 && *0x1::vector::borrow<u8>(&v1, v3) <= 57, 300);
            v3 = v3 + 1;
        };
        assert!(v2 == 1 || *0x1::vector::borrow<u8>(&v1, 0) != 48, 300);
        0x1::vector::push_back<u8>(&mut v0, 58);
        0x1::vector::append<u8>(&mut v0, v1);
        v0
    }

    public fun migrate_book(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::AdminCap, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: &mut IdentityBook) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(arg2.version < 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::package_version(), 310);
        arg2.version = 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::package_version();
    }

    public fun open_farm<T0, T1>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg1: &IdentityVault, arg2: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg0);
        assert!(arg1.bound == 0x1::option::some<address>(0x2::tx_context::sender(arg9)), 305);
        assert!(0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::creator_fee_recipient<T0, T1>(arg2) == 0x2::object::id_address<IdentityVault>(arg1), 304);
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::farm::create_internal<T0, T1>(arg2, 0x2::coin::into_balance<T0>(arg3), arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8), arg9)
    }

    public fun pending_redirect<T0, T1>(arg0: &IdentityVault, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>) : 0x1::option::Option<Redirect> {
        let v0 = RedirectKey{curve_id: 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg1)};
        if (0x2::dynamic_field::exists<RedirectKey>(&arg0.id, v0)) {
            0x1::option::some<Redirect>(*0x2::dynamic_field::borrow<RedirectKey, Redirect>(&arg0.id, v0))
        } else {
            0x1::option::none<Redirect>()
        }
    }

    public fun propose_redirect<T0, T1>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::AdminCap, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: &mut IdentityVault, arg3: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg4: address, arg5: &0x2::clock::Clock) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(0x1::option::is_none<address>(&arg2.bound), 301);
        assert!(arg4 != @0x0, 300);
        let v0 = 0x2::object::id_address<IdentityVault>(arg2);
        assert!(0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::creator_fee_recipient<T0, T1>(arg3) == v0, 304);
        let v1 = RedirectKey{curve_id: 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg3)};
        let v2 = 0x2::clock::timestamp_ms(arg5) + 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::identity_admin_delay_ms();
        if (0x2::dynamic_field::exists<RedirectKey>(&arg2.id, v1)) {
            0x2::dynamic_field::remove<RedirectKey, Redirect>(&mut arg2.id, v1);
        };
        let v3 = Redirect{
            to       : arg4,
            ready_ms : v2,
        };
        0x2::dynamic_field::add<RedirectKey, Redirect>(&mut arg2.id, v1, v3);
        let v4 = RedirectSeqKey{curve_id: 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg3)};
        if (0x2::dynamic_field::exists<RedirectSeqKey>(&arg2.id, v4)) {
            0x2::dynamic_field::remove<RedirectSeqKey, u64>(&mut arg2.id, v4);
        };
        0x2::dynamic_field::add<RedirectSeqKey, u64>(&mut arg2.id, v4, 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::recipient_changes<T0, T1>(arg3));
        let v5 = RedirectProposed{
            curve_id : 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg3),
            vault    : v0,
            to       : arg4,
            ready_ms : v2,
        };
        0x2::event::emit<RedirectProposed>(v5);
    }

    public fun propose_transfer(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg1: &mut IdentityVault, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg0);
        assert!(arg1.bound == 0x1::option::some<address>(0x2::tx_context::sender(arg3)), 305);
        assert!(arg2 != @0x0, 300);
        arg1.pending = 0x1::option::some<address>(arg2);
        arg1.ready_ms = 0;
        let v0 = TransferProposed{
            vault : 0x2::object::id_address<IdentityVault>(arg1),
            from  : 0x2::tx_context::sender(arg3),
            to    : arg2,
        };
        0x2::event::emit<TransferProposed>(v0);
    }

    public fun redirect_info(arg0: &Redirect) : (address, u64) {
        (arg0.to, arg0.ready_ms)
    }

    public fun redirect_is_current<T0, T1>(arg0: &IdentityVault, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>) : bool {
        let v0 = RedirectSeqKey{curve_id: 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg1)};
        let v1 = if (0x2::dynamic_field::exists<RedirectSeqKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<RedirectSeqKey, u64>(&arg0.id, v0)
        } else {
            0
        };
        let v2 = RedirectKey{curve_id: 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg1)};
        0x2::dynamic_field::exists<RedirectKey>(&arg0.id, v2) && v1 == 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::recipient_changes<T0, T1>(arg1)
    }

    public fun redirect_unclaimed<T0, T1>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::AdminCap, arg1: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg2: &mut IdentityVault, arg3: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg4: &0x2::clock::Clock) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg1);
        assert!(0x1::option::is_none<address>(&arg2.bound), 301);
        let v0 = 0x2::object::id_address<IdentityVault>(arg2);
        assert!(0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::creator_fee_recipient<T0, T1>(arg3) == v0, 304);
        let v1 = RedirectKey{curve_id: 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg3)};
        assert!(0x2::dynamic_field::exists<RedirectKey>(&arg2.id, v1), 308);
        let Redirect {
            to       : v2,
            ready_ms : v3,
        } = 0x2::dynamic_field::remove<RedirectKey, Redirect>(&mut arg2.id, v1);
        assert!(take_seq(arg2, 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg3)) == 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::recipient_changes<T0, T1>(arg3), 309);
        assert!(0x2::clock::timestamp_ms(arg4) >= v3, 307);
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::redirect_fee_recipient<T0, T1>(arg3, v2);
        let v4 = UnclaimedRedirected{
            curve_id : 0x2::object::id<0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>>(arg3),
            vault    : v0,
            to       : v2,
        };
        0x2::event::emit<UnclaimedRedirected>(v4);
    }

    public fun replace_farm<T0, T1>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg1: &IdentityVault, arg2: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Curve<T0, T1>, arg3: &mut 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::farm::Farm<T0>, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg0);
        assert!(arg1.bound == 0x1::option::some<address>(0x2::tx_context::sender(arg10)), 305);
        assert!(0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::creator_fee_recipient<T0, T1>(arg2) == 0x2::object::id_address<IdentityVault>(arg1), 304);
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::farm::replace_internal<T0, T1>(arg2, arg3, 0x2::coin::into_balance<T0>(arg4), arg5, arg6, arg7, arg8, 0x2::clock::timestamp_ms(arg9), arg10)
    }

    public fun sweep<T0>(arg0: &0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::Config, arg1: &mut IdentityVault, arg2: u64) {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::assert_version(arg0);
        assert!(0x1::option::is_some<address>(&arg1.bound), 302);
        assert!(arg2 > 0, 306);
        let v0 = *0x1::option::borrow<address>(&arg1.bound);
        let v1 = Swept{
            vault  : 0x2::object::id_address<IdentityVault>(arg1),
            to     : v0,
            amount : arg2,
        };
        0x2::event::emit<Swept>(v1);
        0x2::balance::send_funds<T0>(0x2::balance::redeem_funds<T0>(0x2::balance::withdraw_funds_from_object<T0>(&mut arg1.id, arg2)), v0);
    }

    fun take_seq(arg0: &mut IdentityVault, arg1: 0x2::object::ID) : u64 {
        let v0 = RedirectSeqKey{curve_id: arg1};
        if (0x2::dynamic_field::exists<RedirectSeqKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<RedirectSeqKey, u64>(&mut arg0.id, v0)
        } else {
            0
        }
    }

    public fun vault_bound(arg0: &IdentityVault) : 0x1::option::Option<address> {
        arg0.bound
    }

    public fun vault_for(arg0: &mut IdentityBook, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg0.version == 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::curve::package_version(), 310);
        let v0 = identity_key(&arg1, &arg2);
        if (0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.vaults, v0)) {
            return 0x2::object::id_to_address(0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.vaults, v0))
        };
        let v1 = IdentityVault{
            id       : 0x2::object::new(arg3),
            provider : arg1,
            subject  : arg2,
            bound    : 0x1::option::none<address>(),
            pending  : 0x1::option::none<address>(),
            ready_ms : 0,
        };
        let v2 = 0x2::object::id_address<IdentityVault>(&v1);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.vaults, v0, 0x2::object::id<IdentityVault>(&v1));
        let v3 = VaultOpened{
            vault    : v2,
            provider : v1.provider,
            subject  : v1.subject,
        };
        0x2::event::emit<VaultOpened>(v3);
        0x2::transfer::share_object<IdentityVault>(v1);
        v2
    }

    public fun vault_identity(arg0: &IdentityVault) : (0x1::string::String, 0x1::string::String) {
        (arg0.provider, arg0.subject)
    }

    public fun vault_of(arg0: &IdentityBook, arg1: 0x1::string::String, arg2: 0x1::string::String) : 0x1::option::Option<address> {
        let v0 = identity_key(&arg1, &arg2);
        if (0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.vaults, v0)) {
            0x1::option::some<address>(0x2::object::id_to_address(0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.vaults, v0)))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun vault_pending(arg0: &IdentityVault) : 0x1::option::Option<address> {
        arg0.pending
    }

    public fun vault_ready_ms(arg0: &IdentityVault) : u64 {
        arg0.ready_ms
    }

    // decompiled from Move bytecode v7
}

