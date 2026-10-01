module 0xfbd410c49c061bf78b8553280a7606fb0e727757530795ee779629d61aef4112::para_bridge {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Bridge has key {
        id: 0x2::object::UID,
        admin: address,
        relayer: address,
        paused: bool,
        nonce: u64,
        vaults: 0x2::bag::Bag,
        allowed: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        released: 0x2::table::Table<u64, bool>,
    }

    struct DepositEvent has copy, drop {
        nonce: u64,
        coin_type: 0x1::string::String,
        from: address,
        amount: u64,
        ao_recipient: 0x1::string::String,
    }

    struct ReleasedEvent has copy, drop {
        withdrawal_id: u64,
        coin_type: 0x1::string::String,
        to: address,
        amount: u64,
    }

    public fun admin(arg0: &Bridge) : address {
        arg0.admin
    }

    public fun allow_token<T0>(arg0: &AdminCap, arg1: &mut Bridge) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.allowed, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.allowed, v0);
        };
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg1.vaults, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.vaults, v0, 0x2::balance::zero<T0>());
        };
    }

    fun assert_relayer(arg0: &Bridge, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.relayer, 0);
    }

    fun coin_type_string(arg0: 0x1::type_name::TypeName) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x1::string::from_ascii(0x1::type_name::into_string(arg0)));
        v0
    }

    public fun deposit<T0>(arg0: &mut Bridge, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 1);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.allowed, &v0), 2);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 3);
        assert!(is_ao_address(&arg2), 4);
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vaults, v0), 0x2::coin::into_balance<T0>(arg1));
        arg0.nonce = arg0.nonce + 1;
        let v2 = DepositEvent{
            nonce        : arg0.nonce,
            coin_type    : coin_type_string(v0),
            from         : 0x2::tx_context::sender(arg3),
            amount       : v1,
            ao_recipient : arg2,
        };
        0x2::event::emit<DepositEvent>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Bridge{
            id       : 0x2::object::new(arg0),
            admin    : v0,
            relayer  : v0,
            paused   : false,
            nonce    : 0,
            vaults   : 0x2::bag::new(arg0),
            allowed  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            released : 0x2::table::new<u64, bool>(arg0),
        };
        0x2::transfer::share_object<Bridge>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    fun is_ao_address(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::length<u8>(v0) != 43) {
            return false
        };
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v3 = *0x1::vector::borrow<u8>(v0, v1);
            let v4 = if (v3 >= 65 && v3 <= 90) {
                true
            } else if (v3 >= 97 && v3 <= 122) {
                true
            } else if (v3 >= 48 && v3 <= 57) {
                true
            } else if (v3 == 45) {
                true
            } else {
                v3 == 95
            };
            if (!v4) {
                v2 = false;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = true;
        v2
    }

    public fun is_released(arg0: &Bridge, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.released, arg1)
    }

    public fun nonce(arg0: &Bridge) : u64 {
        arg0.nonce
    }

    public fun paused(arg0: &Bridge) : bool {
        arg0.paused
    }

    public fun relayer(arg0: &Bridge) : address {
        arg0.relayer
    }

    public fun release<T0>(arg0: &mut Bridge, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_relayer(arg0, arg4);
        assert!(!arg0.paused, 1);
        assert!(!0x2::table::contains<u64, bool>(&arg0.released, arg1), 5);
        assert!(arg2 > 0, 3);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vaults, v0), 6);
        0x2::table::add<u64, bool>(&mut arg0.released, arg1, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.vaults, v0), arg2), arg4), arg3);
        let v1 = ReleasedEvent{
            withdrawal_id : arg1,
            coin_type     : coin_type_string(v0),
            to            : arg3,
            amount        : arg2,
        };
        0x2::event::emit<ReleasedEvent>(v1);
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Bridge, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_relayer(arg0: &AdminCap, arg1: &mut Bridge, arg2: address) {
        arg1.relayer = arg2;
    }

    public fun vault_balance<T0>(arg0: &Bridge) : u64 {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.vaults, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.vaults, v0))
    }

    // decompiled from Move bytecode v7
}

