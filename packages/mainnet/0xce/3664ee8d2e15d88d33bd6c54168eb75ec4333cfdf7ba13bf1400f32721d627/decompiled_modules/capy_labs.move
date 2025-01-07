module 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::capy_labs {
    struct CapyLabsApp has key {
        id: 0x2::object::UID,
        inner_hash: vector<u8>,
        mixing_limit: u8,
        cool_down_period: u64,
        mixing_price: u64,
        profits: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MixLimitKey has copy, drop, store {
        dummy_field: bool,
    }

    struct LastEpochMixedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ParentsKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_country_code<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut CapyLabsApp, arg2: 0x1::string::String) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::add_country_code<T0>(arg0, &mut arg1.id, arg2);
    }

    public fun add_genes<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut CapyLabsApp, arg2: vector<u8>) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::genes::add_gene_definitions<T0>(&mut arg1.id, arg2);
    }

    public fun app_set_last_epoch_mixed<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: u64) {
        assert!(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::is_authorized<T0>(arg0), 6);
        set_last_epoch_mixed<T0>(arg1, arg2);
    }

    public fun app_set_mixing_limit<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: u8) {
        assert!(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::is_authorized<T0>(arg0), 6);
        set_limit<T0>(arg1, arg2);
    }

    public fun app_set_parents<T0>(arg0: &mut 0x2::object::UID, arg1: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: vector<0x2::object::ID>) {
        assert!(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::is_authorized<T0>(arg0), 6);
        let v0 = ParentsKey{dummy_field: false};
        0x2::dynamic_field::add<ParentsKey, vector<0x2::object::ID>>(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg1), v0, arg2);
    }

    public fun authorize<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut CapyLabsApp, arg2: u32, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: vector<0x1::string::String>) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::authorize_app<T0>(arg0, &mut arg1.id, 0x1::string::utf8(b"capy_labs"), arg2, arg3, arg4, arg5, arg6);
    }

    public fun deauthorize<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut CapyLabsApp) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::revoke_auth<T0>(arg0, &mut arg1.id);
    }

    public fun derive(arg0: &vector<u8>, arg1: u8) : vector<u8> {
        let v0 = *arg0;
        0x1::vector::push_back<u8>(&mut v0, arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun get_cooldown_period(arg0: &CapyLabsApp) : u64 {
        arg0.cool_down_period
    }

    public fun get_mixing_limit(arg0: &CapyLabsApp) : u8 {
        arg0.mixing_limit
    }

    public fun get_mixing_price(arg0: &CapyLabsApp) : u64 {
        arg0.mixing_price
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_bytes(&v0);
        let v2 = CapyLabsApp{
            id               : v0,
            inner_hash       : 0x2::hash::blake2b256(&v1),
            mixing_limit     : 5,
            cool_down_period : 1,
            mixing_price     : 10000000000,
            profits          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<CapyLabsApp>(v2);
    }

    public fun last_epoch_mixed<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>) : 0x1::option::Option<u64> {
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid<T0>(arg0);
        let v1 = LastEpochMixedKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<LastEpochMixedKey>(v0, v1)) {
            0x1::option::some<u64>(*0x2::dynamic_field::borrow<LastEpochMixedKey, u64>(v0, v1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun mix<T0>(arg0: &mut CapyLabsApp, arg1: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0> {
        abort 1337
    }

    public fun mixing_limit<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>) : 0x1::option::Option<u8> {
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid<T0>(arg0);
        let v1 = MixLimitKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<MixLimitKey>(v0, v1)) {
            0x1::option::some<u8>(*0x2::dynamic_field::borrow<MixLimitKey, u8>(v0, v1))
        } else {
            0x1::option::none<u8>()
        }
    }

    public fun remove_country_code<T0>(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut CapyLabsApp, arg2: 0x1::string::String) {
        0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::remove_country_code<T0>(arg0, &mut arg1.id, arg2);
    }

    public fun set_cooldown_period(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut CapyLabsApp, arg2: u64) {
        arg1.cool_down_period = arg2;
    }

    fun set_last_epoch_mixed<T0>(arg0: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg1: u64) {
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg0);
        let v1 = LastEpochMixedKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<LastEpochMixedKey>(v0, v1)) {
            0x2::dynamic_field::remove<LastEpochMixedKey, u64>(v0, v1);
        };
        0x2::dynamic_field::add<LastEpochMixedKey, u64>(v0, v1, arg1);
    }

    fun set_limit<T0>(arg0: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg1: u8) {
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg0);
        let v1 = MixLimitKey{dummy_field: false};
        if (0x2::dynamic_field::exists_<MixLimitKey>(v0, v1)) {
            0x2::dynamic_field::remove<MixLimitKey, u8>(v0, v1);
        };
        0x2::dynamic_field::add<MixLimitKey, u8>(v0, v1, arg1);
    }

    public fun set_mixing_limit(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut CapyLabsApp, arg2: u8) {
        arg1.mixing_limit = arg2;
    }

    public fun set_mixing_price(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut CapyLabsApp, arg2: u64) {
        arg1.mixing_price = arg2;
    }

    public fun take_profits(arg0: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg1: &mut CapyLabsApp, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.profits);
        assert!(v0 > 0, 4);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.profits, v0, arg2)
    }

    // decompiled from Move bytecode v6
}

