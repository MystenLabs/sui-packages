module 0xc8f25fd69685839ded5afafd564d4fde85061fb405eb5c4fbd073d8e3a75ba91::treasury_cap {
    struct BurnCap has store, key {
        id: 0x2::object::UID,
        treasury: address,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        treasury: address,
    }

    struct MetadataCap has store, key {
        id: 0x2::object::UID,
        treasury: address,
    }

    struct TreasuryCapV2 has store, key {
        id: 0x2::object::UID,
        name: 0x1::type_name::TypeName,
    }

    struct Mint<phantom T0> has copy, drop {
        pos0: u64,
    }

    struct Burn<phantom T0> has copy, drop {
        pos0: u64,
    }

    public fun burn<T0>(arg0: &mut TreasuryCapV2, arg1: &BurnCap, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg1.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372689689804801);
        let v0 = Burn<T0>{pos0: 0x2::coin::value<T0>(&arg2)};
        0x2::event::emit<Burn<T0>>(v0);
        0x2::coin::burn<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, arg0.name), arg2);
    }

    public fun mint<T0>(arg0: &mut TreasuryCapV2, arg1: &MintCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372629560262657);
        let v0 = Mint<T0>{pos0: arg2};
        0x2::event::emit<Mint<T0>>(v0);
        0x2::coin::mint<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, arg0.name), arg2, arg3)
    }

    public fun total_supply<T0>(arg0: &TreasuryCapV2) : u64 {
        0x2::coin::total_supply<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name))
    }

    public fun update_description<T0>(arg0: &TreasuryCapV2, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::string::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372517891112961);
        0x2::coin::update_description<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun update_icon_url<T0>(arg0: &TreasuryCapV2, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::ascii::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372573725687809);
        0x2::coin::update_icon_url<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun update_name<T0>(arg0: &TreasuryCapV2, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::string::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372406221963265);
        0x2::coin::update_name<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun update_symbol<T0>(arg0: &TreasuryCapV2, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::ascii::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372462056538113);
        0x2::coin::update_symbol<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (TreasuryCapV2, MintCap, BurnCap, MetadataCap) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = TreasuryCapV2{
            id   : 0x2::object::new(arg1),
            name : v0,
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut v1.id, v0, arg0);
        let v2 = 0x2::object::uid_to_address(&v1.id);
        let v3 = MintCap{
            id       : 0x2::object::new(arg1),
            treasury : v2,
        };
        let v4 = BurnCap{
            id       : 0x2::object::new(arg1),
            treasury : v2,
        };
        let v5 = MetadataCap{
            id       : 0x2::object::new(arg1),
            treasury : v2,
        };
        (v1, v3, v4, v5)
    }

    public fun burn_cap_treasury(arg0: &BurnCap) : address {
        arg0.treasury
    }

    public fun destroy_burn_cap(arg0: BurnCap) {
        let BurnCap {
            id       : v0,
            treasury : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_metadata_cap(arg0: MetadataCap) {
        let MetadataCap {
            id       : v0,
            treasury : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_mint_cap(arg0: MintCap) {
        let MintCap {
            id       : v0,
            treasury : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun metadata_cap_treasury(arg0: &MetadataCap) : address {
        arg0.treasury
    }

    public fun mint_cap_treasury(arg0: &MintCap) : address {
        arg0.treasury
    }

    // decompiled from Move bytecode v6
}

