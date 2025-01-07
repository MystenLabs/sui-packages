module 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::controlled_treasury {
    struct CONTROLLED_TREASURY has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct CoinMetadataWrapper<phantom T0> has store, key {
        id: 0x2::object::UID,
        metadata: 0x2::object::ID,
        currency: 0x1::ascii::String,
        price: u64,
    }

    struct GlobalCap<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        cap: u64,
        paused: bool,
        balances: 0x2::table::Table<address, 0x2::balance::Balance<T0>>,
        roles: 0x2::table::Table<address, vector<u8>>,
    }

    struct AuthEvent<phantom T0> has copy, drop {
        name: 0x1::ascii::String,
        sender: address,
        account: address,
        role: u8,
    }

    struct UpgradeEvent<phantom T0> has copy, drop {
        version: u64,
        cap_id: 0x2::object::ID,
    }

    struct PauseEvent<phantom T0> has copy, drop {
        sender: address,
        cap_id: 0x2::object::ID,
    }

    struct UnpauseEvent<phantom T0> has copy, drop {
        sender: address,
        cap_id: 0x2::object::ID,
    }

    struct PublishEvent<phantom T0> has copy, drop {
        name: 0x1::ascii::String,
        sender: address,
        cap_id: 0x2::object::ID,
    }

    struct PriceChangeEvent<phantom T0> has copy, drop {
        sender: address,
        cap_id: 0x2::object::ID,
        price: u64,
    }

    public(friend) fun decrease_supply<T0>(arg0: &mut GlobalCap<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(treasury_cap_mut<T0>(arg0)), arg1)
    }

    public(friend) fun increase_supply<T0>(arg0: &mut GlobalCap<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = treasury_cap_mut<T0>(arg0);
        assert!(0x2::balance::supply_value<T0>(0x2::coin::supply<T0>(v0)) + arg1 <= arg0.cap, 9223373681827708936);
        0x2::balance::increase_supply<T0>(0x2::coin::supply_mut<T0>(treasury_cap_mut<T0>(arg0)), arg1)
    }

    public(friend) fun join<T0>(arg0: &mut GlobalCap<T0>, arg1: address, arg2: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::join<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, arg1), arg2)
    }

    public(friend) fun split<T0>(arg0: &mut GlobalCap<T0>, arg1: address, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.balances, arg1), 9223373647468625938);
        0x2::balance::split<T0>(0x2::table::borrow_mut<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, arg1), arg2)
    }

    public fun total_supply<T0>(arg0: &GlobalCap<T0>) : u64 {
        0x2::coin::total_supply<T0>(treasury_cap<T0>(arg0))
    }

    public(friend) fun new<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: vector<u8>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::CoinMetadata<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        let v2 = v1;
        let v3 = CoinMetadataWrapper<T0>{
            id       : 0x2::object::new(arg9),
            metadata : 0x2::object::id<0x2::coin::CoinMetadata<T0>>(&v2),
            currency : 0x1::ascii::string(arg6),
            price    : arg8,
        };
        let v4 = 0x2::object::new(arg9);
        0x2::dynamic_field::add<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(&mut v4, treasury_cap_key(), v0);
        0x2::dynamic_field::add<0x1::ascii::String, CoinMetadataWrapper<T0>>(&mut v4, metadata_key(), v3);
        let v5 = 0x2::table::new<address, vector<u8>>(arg9);
        0x2::table::add<address, vector<u8>>(&mut v5, 0x2::tx_context::sender(arg9), 0x1::vector::singleton<u8>(0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::roles::role_admin()));
        let v6 = 0x2::table::new<address, 0x2::balance::Balance<T0>>(arg9);
        0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut v6, 0x2::tx_context::sender(arg9), 0x2::balance::zero<T0>());
        let v7 = PublishEvent<T0>{
            name   : 0x1::ascii::string(arg3),
            sender : 0x2::tx_context::sender(arg9),
            cap_id : 0x2::object::uid_to_inner(&v4),
        };
        0x2::event::emit<PublishEvent<T0>>(v7);
        let v8 = GlobalCap<T0>{
            id       : v4,
            version  : 1,
            cap      : arg7,
            paused   : false,
            balances : v6,
            roles    : v5,
        };
        0x2::transfer::share_object<GlobalCap<T0>>(v8);
        v2
    }

    public entry fun auth<T0>(arg0: &mut GlobalCap<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        check<T0>(arg0);
        check_admin<T0>(arg0, arg3);
        let v0 = AuthEvent<T0>{
            name    : auth_event_name(),
            sender  : 0x2::tx_context::sender(arg3),
            account : arg1,
            role    : arg2,
        };
        0x2::event::emit<AuthEvent<T0>>(v0);
        if (!0x2::table::contains<address, vector<u8>>(&arg0.roles, arg1)) {
            0x2::table::add<address, vector<u8>>(&mut arg0.roles, arg1, 0x1::vector::singleton<u8>(arg2));
            0x2::table::add<address, 0x2::balance::Balance<T0>>(&mut arg0.balances, arg1, 0x2::balance::zero<T0>());
        } else {
            let v1 = 0x2::table::borrow_mut<address, vector<u8>>(&mut arg0.roles, arg1);
            assert!(!0x1::vector::contains<u8>(v1, &arg2), 9223373153546338306);
            0x1::vector::push_back<u8>(v1, arg2);
        };
    }

    fun auth_event_name() : 0x1::ascii::String {
        0x1::ascii::string(b"auth")
    }

    public fun check<T0>(arg0: &GlobalCap<T0>) {
        check_upgrade<T0>(arg0);
        check_paused<T0>(arg0);
    }

    public fun check_admin<T0>(arg0: &GlobalCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin<T0>(arg0, arg1), 9223373522913656836);
    }

    fun check_paused<T0>(arg0: &GlobalCap<T0>) {
        assert!(!arg0.paused, 9223373733367447562);
    }

    fun check_upgrade<T0>(arg0: &GlobalCap<T0>) {
        assert!(arg0.version == 1, 9223373754842546190);
    }

    public fun has_role<T0>(arg0: &GlobalCap<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : bool {
        has_role_by_address<T0>(arg0, 0x2::tx_context::sender(arg2), arg1)
    }

    public fun has_role_by_address<T0>(arg0: &GlobalCap<T0>, arg1: address, arg2: u8) : bool {
        has_role_by_address_internal<T0>(arg0, arg1, arg2)
    }

    fun has_role_by_address_internal<T0>(arg0: &GlobalCap<T0>, arg1: address, arg2: u8) : bool {
        0x2::table::contains<address, vector<u8>>(&arg0.roles, arg1) && 0x1::vector::contains<u8>(0x2::table::borrow<address, vector<u8>>(&arg0.roles, arg1), &arg2)
    }

    fun init(arg0: CONTROLLED_TREASURY, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<CONTROLLED_TREASURY>(&arg0), 9223372689691050004);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_admin<T0>(arg0: &GlobalCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : bool {
        has_role<T0>(arg0, 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::roles::role_admin(), arg1)
    }

    public fun is_paused<T0>(arg0: &GlobalCap<T0>) : bool {
        arg0.paused
    }

    public fun is_role<T0>(arg0: &GlobalCap<T0>, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : bool {
        is_admin<T0>(arg0, arg2) || has_role<T0>(arg0, arg1, arg2)
    }

    public fun is_role_by_address<T0>(arg0: &GlobalCap<T0>, arg1: address, arg2: u8) : bool {
        has_role_by_address<T0>(arg0, arg1, 0xa6247cdfd2d9b2a71143b8013612b5b42d0a08592cac64d4b8a9f0b9e604c074::roles::role_admin()) || has_role_by_address<T0>(arg0, arg1, arg2)
    }

    fun metadata<T0>(arg0: &GlobalCap<T0>) : &CoinMetadataWrapper<T0> {
        0x2::dynamic_field::borrow<0x1::ascii::String, CoinMetadataWrapper<T0>>(&arg0.id, metadata_key())
    }

    fun metadata_key() : 0x1::ascii::String {
        0x1::ascii::string(b"metadata")
    }

    fun metadata_mut<T0>(arg0: &mut GlobalCap<T0>) : &mut CoinMetadataWrapper<T0> {
        0x2::dynamic_field::borrow_mut<0x1::ascii::String, CoinMetadataWrapper<T0>>(&mut arg0.id, metadata_key())
    }

    entry fun migrate<T0>(arg0: &AdminCap, arg1: &mut GlobalCap<T0>) {
        assert!(arg1.version < 1, 9223372736935428112);
        arg1.version = 1;
        let v0 = UpgradeEvent<T0>{
            version : 1,
            cap_id  : 0x2::object::id<GlobalCap<T0>>(arg1),
        };
        0x2::event::emit<UpgradeEvent<T0>>(v0);
    }

    public entry fun pause<T0>(arg0: &mut GlobalCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        check<T0>(arg0);
        check_admin<T0>(arg0, arg1);
        arg0.paused = true;
        let v0 = PauseEvent<T0>{
            sender : 0x2::tx_context::sender(arg1),
            cap_id : 0x2::object::id<GlobalCap<T0>>(arg0),
        };
        0x2::event::emit<PauseEvent<T0>>(v0);
    }

    public fun price<T0>(arg0: &GlobalCap<T0>) : u64 {
        metadata<T0>(arg0).price
    }

    public fun token_value<T0>(arg0: &GlobalCap<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, 0x2::balance::Balance<T0>>(&arg0.balances, arg1)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::table::borrow<address, 0x2::balance::Balance<T0>>(&arg0.balances, arg1))
        }
    }

    fun treasury_cap<T0>(arg0: &GlobalCap<T0>) : &0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_field::borrow<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(&arg0.id, treasury_cap_key())
    }

    fun treasury_cap_key() : 0x1::ascii::String {
        0x1::ascii::string(b"treasury_cap")
    }

    fun treasury_cap_mut<T0>(arg0: &mut GlobalCap<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, treasury_cap_key())
    }

    public entry fun unauth<T0>(arg0: &mut GlobalCap<T0>, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        check<T0>(arg0);
        check_admin<T0>(arg0, arg3);
        let v0 = AuthEvent<T0>{
            name    : unauth_event_name(),
            sender  : 0x2::tx_context::sender(arg3),
            account : arg1,
            role    : arg2,
        };
        0x2::event::emit<AuthEvent<T0>>(v0);
        assert!(0x2::table::contains<address, vector<u8>>(&arg0.roles, arg1), 9223373239445946374);
        let v1 = 0x2::table::borrow_mut<address, vector<u8>>(&mut arg0.roles, arg1);
        let (v2, v3) = 0x1::vector::index_of<u8>(v1, &arg2);
        assert!(v2, 9223373252330848262);
        0x1::vector::remove<u8>(v1, v3);
    }

    fun unauth_event_name() : 0x1::ascii::String {
        0x1::ascii::string(b"unauth")
    }

    public entry fun unpause<T0>(arg0: &mut GlobalCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        check_upgrade<T0>(arg0);
        check_admin<T0>(arg0, arg1);
        assert!(arg0.paused, 9223373359705423884);
        arg0.paused = false;
        let v0 = UnpauseEvent<T0>{
            sender : 0x2::tx_context::sender(arg1),
            cap_id : 0x2::object::id<GlobalCap<T0>>(arg0),
        };
        0x2::event::emit<UnpauseEvent<T0>>(v0);
    }

    public entry fun update_price<T0>(arg0: &mut GlobalCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check<T0>(arg0);
        check_admin<T0>(arg0, arg2);
        let v0 = metadata_mut<T0>(arg0);
        v0.price = arg1;
        let v1 = PriceChangeEvent<T0>{
            sender : 0x2::tx_context::sender(arg2),
            cap_id : 0x2::object::id<GlobalCap<T0>>(arg0),
            price  : arg1,
        };
        0x2::event::emit<PriceChangeEvent<T0>>(v1);
    }

    // decompiled from Move bytecode v6
}

