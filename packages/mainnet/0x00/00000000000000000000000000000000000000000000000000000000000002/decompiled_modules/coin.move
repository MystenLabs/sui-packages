module 0x2::coin {
    struct Coin<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct CoinMetadata<phantom T0> has store, key {
        id: 0x2::object::UID,
        decimals: u8,
        name: 0x1::string::String,
        symbol: 0x1::ascii::String,
        description: 0x1::string::String,
        icon_url: 0x1::option::Option<0x2::url::Url>,
    }

    struct RegulatedCoinMetadata<phantom T0> has key {
        id: 0x2::object::UID,
        coin_metadata_object: 0x2::object::ID,
        deny_cap_object: 0x2::object::ID,
    }

    struct TreasuryCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_supply: 0x2::balance::Supply<T0>,
    }

    struct DenyCapV2<phantom T0> has store, key {
        id: 0x2::object::UID,
        allow_global_pause: bool,
    }

    struct CurrencyCreated<phantom T0> has copy, drop {
        decimals: u8,
    }

    struct DenyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun balance<T0>(arg0: &Coin<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun destroy_zero<T0>(arg0: Coin<T0>) {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public entry fun join<T0>(arg0: &mut Coin<T0>, arg1: Coin<T0>) {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::join<T0>(&mut arg0.balance, v1);
    }

    public fun redeem_funds<T0>(arg0: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg1: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        from_balance<T0>(0x2::balance::redeem_funds<T0>(arg0), arg1)
    }

    public fun send_funds<T0>(arg0: Coin<T0>, arg1: address) {
        0x2::balance::send_funds<T0>(into_balance<T0>(arg0), arg1);
    }

    public fun split<T0>(arg0: &mut Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        let v0 = &mut arg0.balance;
        take<T0>(v0, arg1, arg2)
    }

    public fun value<T0>(arg0: &Coin<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun zero<T0>(arg0: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun allow_global_pause<T0>(arg0: &DenyCapV2<T0>) : bool {
        arg0.allow_global_pause
    }

    public fun balance_mut<T0>(arg0: &mut Coin<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance
    }

    public entry fun burn<T0>(arg0: &mut TreasuryCap<T0>, arg1: Coin<T0>) : u64 {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        0x2::balance::decrease_supply<T0>(&mut arg0.total_supply, v1)
    }

    public fun create_currency<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : (TreasuryCap<T0>, CoinMetadata<T0>) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = TreasuryCap<T0>{
            id           : 0x2::object::new(arg6),
            total_supply : 0x2::balance::create_supply<T0>(arg0),
        };
        let v1 = CoinMetadata<T0>{
            id          : 0x2::object::new(arg6),
            decimals    : arg1,
            name        : 0x1::string::utf8(arg3),
            symbol      : 0x1::ascii::string(arg2),
            description : 0x1::string::utf8(arg4),
            icon_url    : arg5,
        };
        (v0, v1)
    }

    public fun create_regulated_currency<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: &mut 0x2::tx_context::TxContext) : (TreasuryCap<T0>, DenyCap<T0>, CoinMetadata<T0>) {
        let (v0, v1) = create_currency<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        let v2 = v1;
        let v3 = DenyCap<T0>{id: 0x2::object::new(arg6)};
        let v4 = RegulatedCoinMetadata<T0>{
            id                   : 0x2::object::new(arg6),
            coin_metadata_object : 0x2::object::id<CoinMetadata<T0>>(&v2),
            deny_cap_object      : 0x2::object::id<DenyCap<T0>>(&v3),
        };
        0x2::transfer::freeze_object<RegulatedCoinMetadata<T0>>(v4);
        (v0, v3, v2)
    }

    public fun create_regulated_currency_v2<T0: drop>(arg0: T0, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x1::option::Option<0x2::url::Url>, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : (TreasuryCap<T0>, DenyCapV2<T0>, CoinMetadata<T0>) {
        let (v0, v1) = create_currency<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v2 = v1;
        let v3 = DenyCapV2<T0>{
            id                 : 0x2::object::new(arg7),
            allow_global_pause : arg6,
        };
        let v4 = RegulatedCoinMetadata<T0>{
            id                   : 0x2::object::new(arg7),
            coin_metadata_object : 0x2::object::id<CoinMetadata<T0>>(&v2),
            deny_cap_object      : 0x2::object::id<DenyCapV2<T0>>(&v3),
        };
        0x2::transfer::freeze_object<RegulatedCoinMetadata<T0>>(v4);
        (v0, v3, v2)
    }

    public(friend) fun deny_cap_id<T0>(arg0: &RegulatedCoinMetadata<T0>) : 0x2::object::ID {
        arg0.deny_cap_object
    }

    public fun deny_list_add<T0>(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut DenyCap<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::deny_list::v1_add(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())), arg2);
    }

    public fun deny_list_contains<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        if (0x1::type_name::is_primitive(&v0)) {
            return false
        };
        0x2::deny_list::v1_contains(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(v0)), arg1)
    }

    public fun deny_list_remove<T0>(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut DenyCap<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::deny_list::v1_remove(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get_with_original_ids<T0>())), arg2);
    }

    public fun deny_list_v2_add<T0>(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut DenyCapV2<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::deny_list::v2_add(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())), arg2, arg3);
    }

    public fun deny_list_v2_contains_current_epoch<T0>(arg0: &0x2::deny_list::DenyList, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        0x2::deny_list::v2_contains_current_epoch(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())), arg1, arg2)
    }

    public fun deny_list_v2_contains_next_epoch<T0>(arg0: &0x2::deny_list::DenyList, arg1: address) : bool {
        0x2::deny_list::v2_contains_next_epoch(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())), arg1)
    }

    public fun deny_list_v2_disable_global_pause<T0>(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut DenyCapV2<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.allow_global_pause, 3);
        0x2::deny_list::v2_disable_global_pause(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())), arg2);
    }

    public fun deny_list_v2_enable_global_pause<T0>(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut DenyCapV2<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.allow_global_pause, 3);
        0x2::deny_list::v2_enable_global_pause(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())), arg2);
    }

    public fun deny_list_v2_is_global_pause_enabled_current_epoch<T0>(arg0: &0x2::deny_list::DenyList, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::deny_list::v2_is_global_pause_enabled_current_epoch(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())), arg1)
    }

    public fun deny_list_v2_is_global_pause_enabled_next_epoch<T0>(arg0: &0x2::deny_list::DenyList) : bool {
        0x2::deny_list::v2_is_global_pause_enabled_next_epoch(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())))
    }

    public fun deny_list_v2_remove<T0>(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut DenyCapV2<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::deny_list::v2_remove(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())), arg2, arg3);
    }

    public(friend) fun destroy_metadata<T0>(arg0: CoinMetadata<T0>) {
        let CoinMetadata {
            id          : v0,
            decimals    : _,
            name        : _,
            symbol      : _,
            description : _,
            icon_url    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun divide_into_n<T0>(arg0: &mut Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : vector<Coin<T0>> {
        assert!(arg1 > 0, 1);
        assert!(arg1 <= value<T0>(arg0), 2);
        let v0 = value<T0>(arg0) / arg1;
        let v1 = 0x1::vector::empty<Coin<T0>>();
        let v2 = 0;
        while (v2 < arg1 - 1) {
            0x1::vector::push_back<Coin<T0>>(&mut v1, split<T0>(arg0, v0, arg2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun from_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg1),
            balance : arg0,
        }
    }

    public fun get_decimals<T0>(arg0: &CoinMetadata<T0>) : u8 {
        arg0.decimals
    }

    public fun get_description<T0>(arg0: &CoinMetadata<T0>) : 0x1::string::String {
        arg0.description
    }

    public fun get_icon_url<T0>(arg0: &CoinMetadata<T0>) : 0x1::option::Option<0x2::url::Url> {
        arg0.icon_url
    }

    public fun get_name<T0>(arg0: &CoinMetadata<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_symbol<T0>(arg0: &CoinMetadata<T0>) : 0x1::ascii::String {
        arg0.symbol
    }

    public fun into_balance<T0>(arg0: Coin<T0>) : 0x2::balance::Balance<T0> {
        let Coin {
            id      : v0,
            balance : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun migrate_regulated_currency_to_v2<T0>(arg0: &mut 0x2::deny_list::DenyList, arg1: DenyCap<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : DenyCapV2<T0> {
        let DenyCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        0x2::deny_list::migrate_v1_to_v2(arg0, 0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())), arg3);
        DenyCapV2<T0>{
            id                 : 0x2::object::new(arg3),
            allow_global_pause : arg2,
        }
    }

    public fun mint<T0>(arg0: &mut TreasuryCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::increase_supply<T0>(&mut arg0.total_supply, arg1),
        }
    }

    public entry fun mint_and_transfer<T0>(arg0: &mut TreasuryCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Coin<T0>>(mint<T0>(arg0, arg1, arg3), arg2);
    }

    public fun mint_balance<T0>(arg0: &mut TreasuryCap<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::increase_supply<T0>(&mut arg0.total_supply, arg1)
    }

    public(friend) fun new_coin_metadata<T0>(arg0: u8, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: 0x1::ascii::String, arg5: &mut 0x2::tx_context::TxContext) : CoinMetadata<T0> {
        CoinMetadata<T0>{
            id          : 0x2::object::new(arg5),
            decimals    : arg0,
            name        : arg1,
            symbol      : arg2,
            description : arg3,
            icon_url    : 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(arg4)),
        }
    }

    public(friend) fun new_deny_cap_v2<T0>(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) : DenyCapV2<T0> {
        DenyCapV2<T0>{
            id                 : 0x2::object::new(arg1),
            allow_global_pause : arg0,
        }
    }

    public(friend) fun new_treasury_cap<T0>(arg0: &mut 0x2::tx_context::TxContext) : TreasuryCap<T0> {
        TreasuryCap<T0>{
            id           : 0x2::object::new(arg0),
            total_supply : 0x2::balance::create_supply_internal<T0>(),
        }
    }

    public fun put<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: Coin<T0>) {
        0x2::balance::join<T0>(arg0, into_balance<T0>(arg1));
    }

    public fun supply<T0>(arg0: &mut TreasuryCap<T0>) : &0x2::balance::Supply<T0> {
        &arg0.total_supply
    }

    public fun supply_immut<T0>(arg0: &TreasuryCap<T0>) : &0x2::balance::Supply<T0> {
        &arg0.total_supply
    }

    public fun supply_mut<T0>(arg0: &mut TreasuryCap<T0>) : &mut 0x2::balance::Supply<T0> {
        &mut arg0.total_supply
    }

    public fun take<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Coin<T0> {
        Coin<T0>{
            id      : 0x2::object::new(arg2),
            balance : 0x2::balance::split<T0>(arg0, arg1),
        }
    }

    public fun total_supply<T0>(arg0: &TreasuryCap<T0>) : u64 {
        0x2::balance::supply_value<T0>(&arg0.total_supply)
    }

    public fun treasury_into_supply<T0>(arg0: TreasuryCap<T0>) : 0x2::balance::Supply<T0> {
        let TreasuryCap {
            id           : v0,
            total_supply : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public(friend) fun update_coin_metadata<T0>(arg0: &mut CoinMetadata<T0>, arg1: 0x1::string::String, arg2: 0x1::ascii::String, arg3: 0x1::string::String, arg4: 0x1::ascii::String) {
        arg0.name = arg1;
        arg0.symbol = arg2;
        arg0.description = arg3;
        arg0.icon_url = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(arg4));
    }

    public entry fun update_description<T0>(arg0: &TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>, arg2: 0x1::string::String) {
        arg1.description = arg2;
    }

    public entry fun update_icon_url<T0>(arg0: &TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        arg1.icon_url = 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(arg2));
    }

    public entry fun update_name<T0>(arg0: &TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public entry fun update_symbol<T0>(arg0: &TreasuryCap<T0>, arg1: &mut CoinMetadata<T0>, arg2: 0x1::ascii::String) {
        arg1.symbol = arg2;
    }

    // decompiled from Move bytecode v6
}

