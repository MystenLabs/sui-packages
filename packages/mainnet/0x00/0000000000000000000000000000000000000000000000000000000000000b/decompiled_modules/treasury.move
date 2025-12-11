module 0xb::treasury {
    struct BridgeTreasury has store {
        treasuries: 0x2::object_bag::ObjectBag,
        supported_tokens: 0x2::vec_map::VecMap<0x1::type_name::TypeName, BridgeTokenMetadata>,
        id_token_type_map: 0x2::vec_map::VecMap<u8, 0x1::type_name::TypeName>,
        waiting_room: 0x2::bag::Bag,
    }

    struct BridgeTokenMetadata has copy, drop, store {
        id: u8,
        decimal_multiplier: u64,
        notional_value: u64,
        native_token: bool,
    }

    struct ForeignTokenRegistration has store {
        type_name: 0x1::type_name::TypeName,
        uc: 0x2::package::UpgradeCap,
        decimal: u8,
    }

    struct UpdateTokenPriceEvent has copy, drop {
        token_id: u8,
        new_price: u64,
    }

    struct NewTokenEvent has copy, drop {
        token_id: u8,
        type_name: 0x1::type_name::TypeName,
        native_token: bool,
        decimal_multiplier: u64,
        notional_value: u64,
    }

    struct TokenRegistrationEvent has copy, drop {
        type_name: 0x1::type_name::TypeName,
        decimal: u8,
        native_token: bool,
    }

    public(friend) fun burn<T0>(arg0: &mut BridgeTreasury, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, 0x1::type_name::with_defining_ids<T0>()), arg1);
    }

    public(friend) fun mint<T0>(arg0: &mut BridgeTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, 0x1::type_name::with_defining_ids<T0>()), arg1, arg2)
    }

    public(friend) fun add_new_token(arg0: &mut BridgeTreasury, arg1: 0x1::ascii::String, arg2: u8, arg3: bool, arg4: u64) {
        if (!arg3) {
            assert!(arg4 > 0, 4);
            let ForeignTokenRegistration {
                type_name : v0,
                uc        : v1,
                decimal   : v2,
            } = 0x2::bag::remove<0x1::ascii::String, ForeignTokenRegistration>(&mut arg0.waiting_room, arg1);
            let v3 = 0x1::u64::pow(10, v2);
            let v4 = BridgeTokenMetadata{
                id                 : arg2,
                decimal_multiplier : v3,
                notional_value     : arg4,
                native_token       : arg3,
            };
            0x2::vec_map::insert<0x1::type_name::TypeName, BridgeTokenMetadata>(&mut arg0.supported_tokens, v0, v4);
            0x2::vec_map::insert<u8, 0x1::type_name::TypeName>(&mut arg0.id_token_type_map, arg2, v0);
            0x2::transfer::public_freeze_object<0x2::package::UpgradeCap>(v1);
            let v5 = NewTokenEvent{
                token_id           : arg2,
                type_name          : v0,
                native_token       : arg3,
                decimal_multiplier : v3,
                notional_value     : arg4,
            };
            0x2::event::emit<NewTokenEvent>(v5);
        };
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : BridgeTreasury {
        BridgeTreasury{
            treasuries        : 0x2::object_bag::new(arg0),
            supported_tokens  : 0x2::vec_map::empty<0x1::type_name::TypeName, BridgeTokenMetadata>(),
            id_token_type_map : 0x2::vec_map::empty<u8, 0x1::type_name::TypeName>(),
            waiting_room      : 0x2::bag::new(arg0),
        }
    }

    public fun decimal_multiplier<T0>(arg0: &BridgeTreasury) : u64 {
        let v0 = get_token_metadata<T0>(arg0);
        v0.decimal_multiplier
    }

    fun get_token_metadata<T0>(arg0: &BridgeTreasury) : BridgeTokenMetadata {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::vec_map::try_get<0x1::type_name::TypeName, BridgeTokenMetadata>(&arg0.supported_tokens, &v0);
        assert!(0x1::option::is_some<BridgeTokenMetadata>(&v1), 1);
        0x1::option::destroy_some<BridgeTokenMetadata>(v1)
    }

    public fun notional_value<T0>(arg0: &BridgeTreasury) : u64 {
        let v0 = get_token_metadata<T0>(arg0);
        v0.notional_value
    }

    public(friend) fun register_foreign_token<T0>(arg0: &mut BridgeTreasury, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0x2::package::UpgradeCap, arg3: &0x2::coin::CoinMetadata<T0>) {
        assert!(0x2::coin::total_supply<T0>(&arg1) == 0, 3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x2::package::upgrade_package(&arg2);
        assert!(0x2::object::id_to_address(&v1) == 0x2::address::from_bytes(0x2::hex::decode(0x1::ascii::into_bytes(0x1::type_name::address_string(&v0)))), 2);
        let v2 = ForeignTokenRegistration{
            type_name : v0,
            uc        : arg2,
            decimal   : 0x2::coin::get_decimals<T0>(arg3),
        };
        0x2::bag::add<0x1::ascii::String, ForeignTokenRegistration>(&mut arg0.waiting_room, 0x1::type_name::into_string(v0), v2);
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, v0, arg1);
        let v3 = TokenRegistrationEvent{
            type_name    : v0,
            decimal      : 0x2::coin::get_decimals<T0>(arg3),
            native_token : false,
        };
        0x2::event::emit<TokenRegistrationEvent>(v3);
    }

    public fun token_id<T0>(arg0: &BridgeTreasury) : u8 {
        let v0 = get_token_metadata<T0>(arg0);
        v0.id
    }

    public(friend) fun update_asset_notional_price(arg0: &mut BridgeTreasury, arg1: u8, arg2: u64) {
        let v0 = 0x2::vec_map::try_get<u8, 0x1::type_name::TypeName>(&arg0.id_token_type_map, &arg1);
        assert!(0x1::option::is_some<0x1::type_name::TypeName>(&v0), 1);
        assert!(arg2 > 0, 4);
        let v1 = 0x1::option::destroy_some<0x1::type_name::TypeName>(v0);
        0x2::vec_map::get_mut<0x1::type_name::TypeName, BridgeTokenMetadata>(&mut arg0.supported_tokens, &v1).notional_value = arg2;
        let v2 = UpdateTokenPriceEvent{
            token_id  : arg1,
            new_price : arg2,
        };
        0x2::event::emit<UpdateTokenPriceEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

