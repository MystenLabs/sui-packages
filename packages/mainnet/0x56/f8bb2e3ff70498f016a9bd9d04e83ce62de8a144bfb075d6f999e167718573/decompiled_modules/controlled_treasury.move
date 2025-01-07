module 0x56f8bb2e3ff70498f016a9bd9d04e83ce62de8a144bfb075d6f999e167718573::controlled_treasury {
    struct RWA_COIN has drop {
        dummy_field: bool,
    }

    struct CONTROLLED_TREASURY has drop {
        dummy_field: bool,
    }

    struct CoinMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        decimals: u8,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        currency: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
        price: u64,
    }

    struct TreasuryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
        cap: u64,
        paused: bool,
    }

    struct GlobalCap<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        roles: 0x2::vec_map::VecMap<address, 0x2::vec_set::VecSet<u8>>,
        treasury_cap: TreasuryCap<T0>,
        metadata_id: address,
        balances: 0x2::vec_map::VecMap<address, u64>,
    }

    struct AuthEvent<phantom T0> has copy, drop {
        name: 0x1::string::String,
        sender: address,
        owner: address,
        role: u8,
    }

    public(friend) fun decrease_supply<T0>(arg0: &mut GlobalCap<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::decrease_supply<T0>(&mut arg0.treasury_cap.total_supply, arg1)
    }

    public(friend) fun increase_supply<T0>(arg0: &mut GlobalCap<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::supply_value<T0>(&arg0.treasury_cap.total_supply) + arg1 <= arg0.treasury_cap.cap, 9223373359705358347);
        0x2::balance::increase_supply<T0>(&mut arg0.treasury_cap.total_supply, arg1)
    }

    public(friend) fun new<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_map::empty<address, 0x2::vec_set::VecSet<u8>>();
        0x2::vec_map::insert<address, 0x2::vec_set::VecSet<u8>>(&mut v0, 0x2::tx_context::sender(arg9), 0x2::vec_set::singleton<u8>(1));
        let v1 = TreasuryCap<T0>{
            id           : 0x2::object::new(arg9),
            total_supply : 0x2::balance::create_supply<T0>(arg0),
            cap          : arg7,
            paused       : false,
        };
        let v2 = CoinMetadata<T0>{
            id          : 0x2::object::new(arg9),
            decimals    : arg1,
            name        : 0x1::string::utf8(arg4),
            symbol      : 0x1::ascii::string(arg2),
            currency    : 0x1::ascii::string(arg3),
            description : 0x1::string::utf8(arg5),
            icon_url    : to_url(arg6),
            price       : arg8,
        };
        let v3 = GlobalCap<T0>{
            id           : 0x2::object::new(arg9),
            version      : 1,
            roles        : v0,
            treasury_cap : v1,
            metadata_id  : 0x2::object::id_address<CoinMetadata<T0>>(&v2),
            balances     : 0x2::vec_map::empty<address, u64>(),
        };
        0x2::transfer::share_object<GlobalCap<T0>>(v3);
        0x2::transfer::share_object<CoinMetadata<T0>>(v2);
    }

    public entry fun auth<T0>(arg0: &mut GlobalCap<T0>, arg1: address, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        check_upgrade<T0>(arg0);
        check_paused<T0>(arg0);
        check_admin<T0>(arg0, arg3);
        let v0 = AuthEvent<T0>{
            name   : 0x1::string::utf8(b"auth"),
            sender : 0x2::tx_context::sender(arg3),
            owner  : arg1,
            role   : arg2,
        };
        0x2::event::emit<AuthEvent<T0>>(v0);
        if (!0x2::vec_map::contains<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, &arg1)) {
            0x2::vec_map::insert<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, arg1, 0x2::vec_set::singleton<u8>(arg2));
        } else {
            let v1 = 0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, &arg1);
            assert!(!0x2::vec_set::contains<u8>(v1, &arg2), 9223372891553529861);
            0x2::vec_set::insert<u8>(v1, arg2);
        };
    }

    public fun check_admin<T0>(arg0: &GlobalCap<T0>, arg1: &0x2::tx_context::TxContext) {
        assert!(is_admin<T0>(arg0, arg1), 9223373170726535175);
    }

    public fun check_paused<T0>(arg0: &GlobalCap<T0>) {
        assert!(!arg0.treasury_cap.paused, 9223373192201764877);
    }

    public fun check_upgrade<T0>(arg0: &GlobalCap<T0>) {
        assert!(arg0.version == 1, 9223373213676732431);
    }

    public fun get_balance<T0>(arg0: &GlobalCap<T0>, arg1: address) : 0x1::option::Option<u64> {
        0x2::vec_map::try_get<address, u64>(&arg0.balances, &arg1)
    }

    public fun get_investor_balances<T0>(arg0: &GlobalCap<T0>, arg1: &0x2::tx_context::TxContext) : (vector<address>, vector<u64>) {
        check_admin<T0>(arg0, arg1);
        0x2::vec_map::into_keys_values<address, u64>(arg0.balances)
    }

    public fun has_role<T0>(arg0: &GlobalCap<T0>, arg1: u8, arg2: &0x2::tx_context::TxContext) : bool {
        has_role_by_address<T0>(arg0, 0x2::tx_context::sender(arg2), arg1)
    }

    public fun has_role_by_address<T0>(arg0: &GlobalCap<T0>, arg1: address, arg2: u8) : bool {
        has_role_by_address_internal<T0>(arg0, arg1, arg2)
    }

    fun has_role_by_address_internal<T0>(arg0: &GlobalCap<T0>, arg1: address, arg2: u8) : bool {
        let v0 = 0x2::vec_map::try_get<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, &arg1);
        0x1::option::is_some<0x2::vec_set::VecSet<u8>>(&v0) && 0x2::vec_set::contains<u8>(0x1::option::borrow<0x2::vec_set::VecSet<u8>>(&v0), &arg2)
    }

    fun init(arg0: CONTROLLED_TREASURY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CONTROLLED_TREASURY>(arg0, arg1);
    }

    public fun is_admin<T0>(arg0: &GlobalCap<T0>, arg1: &0x2::tx_context::TxContext) : bool {
        has_role<T0>(arg0, 1, arg1)
    }

    public fun is_admin_or<T0>(arg0: &GlobalCap<T0>, arg1: u8, arg2: &0x2::tx_context::TxContext) : bool {
        is_admin<T0>(arg0, arg2) || has_role<T0>(arg0, arg1, arg2)
    }

    public fun is_paused<T0>(arg0: &GlobalCap<T0>) : bool {
        arg0.treasury_cap.paused
    }

    entry fun migrate<T0>(arg0: &0x2::package::Publisher, arg1: &mut GlobalCap<T0>) {
        assert!(0x2::package::from_package<RWA_COIN>(arg0), 9223372496416407555);
        assert!(arg1.version < 1, 9223372500712292369);
        arg1.version = 1;
    }

    public entry fun pause<T0>(arg0: &mut GlobalCap<T0>, arg1: &0x2::tx_context::TxContext) {
        check_upgrade<T0>(arg0);
        check_admin<T0>(arg0, arg1);
        arg0.treasury_cap.paused = true;
    }

    public(friend) fun set_balance<T0>(arg0: &mut GlobalCap<T0>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.balances, &arg1);
        } else if (0x2::vec_map::contains<address, u64>(&arg0.balances, &arg1)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.balances, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.balances, arg1, arg2);
        };
    }

    public entry fun setup(arg0: &0x2::package::Publisher, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<RWA_COIN>(arg0), 9223372569430851587);
        let v0 = RWA_COIN{dummy_field: false};
        new<RWA_COIN>(v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    fun to_url(arg0: vector<u8>) : 0x1::option::Option<0x2::url::Url> {
        if (0x1::vector::is_empty<u8>(&arg0)) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(arg0))
        }
    }

    public entry fun unauth<T0>(arg0: &mut GlobalCap<T0>, arg1: address, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        check_upgrade<T0>(arg0);
        check_paused<T0>(arg0);
        check_admin<T0>(arg0, arg3);
        let v0 = AuthEvent<T0>{
            name   : 0x1::string::utf8(b"unauth"),
            sender : 0x2::tx_context::sender(arg3),
            owner  : arg1,
            role   : arg2,
        };
        0x2::event::emit<AuthEvent<T0>>(v0);
        let v1 = 0x2::vec_map::try_get<address, 0x2::vec_set::VecSet<u8>>(&arg0.roles, &arg1);
        assert!(0x1::option::is_some<0x2::vec_set::VecSet<u8>>(&v1), 9223372986043072521);
        assert!(0x2::vec_set::contains<u8>(0x1::option::borrow<0x2::vec_set::VecSet<u8>>(&v1), &arg2), 9223372990338039817);
        let v2 = 0x2::vec_map::get_mut<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, &arg1);
        0x2::vec_set::remove<u8>(v2, &arg2);
        if (0x2::vec_set::is_empty<u8>(v2)) {
            let (_, _) = 0x2::vec_map::remove<address, 0x2::vec_set::VecSet<u8>>(&mut arg0.roles, &arg1);
        };
    }

    public entry fun unpause<T0>(arg0: &mut GlobalCap<T0>, arg1: &0x2::tx_context::TxContext) {
        check_upgrade<T0>(arg0);
        assert!(has_role_by_address_internal<T0>(arg0, 0x2::tx_context::sender(arg1), 1), 9223373080532221959);
        arg0.treasury_cap.paused = false;
    }

    // decompiled from Move bytecode v6
}

