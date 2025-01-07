module 0x6514249c7b1140c38e3d4be9801fd945f85bbfdb1a7af93769b8e0dc7a375046::ipx_coin_standard {
    struct CapWitness {
        treasury: address,
        name: 0x1::type_name::TypeName,
        mint_cap_address: 0x1::option::Option<address>,
        burn_cap_address: 0x1::option::Option<address>,
        metadata_cap_address: 0x1::option::Option<address>,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        treasury: address,
        name: 0x1::type_name::TypeName,
    }

    struct BurnCap has store, key {
        id: 0x2::object::UID,
        treasury: address,
        name: 0x1::type_name::TypeName,
    }

    struct MetadataCap has store, key {
        id: 0x2::object::UID,
        treasury: address,
        name: 0x1::type_name::TypeName,
    }

    struct IPXTreasuryStandard has store, key {
        id: 0x2::object::UID,
        name: 0x1::type_name::TypeName,
        can_burn: bool,
        metadata_cap: 0x1::option::Option<address>,
        mint_cap: 0x1::option::Option<address>,
        burn_cap: 0x1::option::Option<address>,
    }

    struct New has copy, drop {
        name: 0x1::type_name::TypeName,
        treasury: address,
        ipx_treasury: address,
    }

    struct Mint has copy, drop {
        pos0: 0x1::type_name::TypeName,
        pos1: u64,
    }

    struct Burn has copy, drop {
        pos0: 0x1::type_name::TypeName,
        pos1: u64,
    }

    struct DestroyMintCap has copy, drop {
        pos0: 0x1::type_name::TypeName,
    }

    struct DestroyBurnCap has copy, drop {
        pos0: 0x1::type_name::TypeName,
    }

    struct DestroyMetadataCap has copy, drop {
        pos0: 0x1::type_name::TypeName,
    }

    public fun mint<T0>(arg0: &MintCap, arg1: &mut IPXTreasuryStandard, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.treasury == 0x2::object::uid_to_address(&arg1.id), 0);
        let v0 = Mint{
            pos0 : arg1.name,
            pos1 : arg2,
        };
        0x2::event::emit<Mint>(v0);
        0x2::coin::mint<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, arg1.name), arg2, arg3)
    }

    public fun total_supply<T0>(arg0: &IPXTreasuryStandard) : u64 {
        0x2::coin::total_supply<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name))
    }

    public fun update_description<T0>(arg0: &IPXTreasuryStandard, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::string::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 0);
        0x2::coin::update_description<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun update_icon_url<T0>(arg0: &IPXTreasuryStandard, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::ascii::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 0);
        0x2::coin::update_icon_url<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun update_name<T0>(arg0: &IPXTreasuryStandard, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::string::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 0);
        0x2::coin::update_name<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun update_symbol<T0>(arg0: &IPXTreasuryStandard, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::ascii::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 0);
        0x2::coin::update_symbol<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (IPXTreasuryStandard, CapWitness) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = IPXTreasuryStandard{
            id           : 0x2::object::new(arg1),
            name         : v0,
            can_burn     : false,
            metadata_cap : 0x1::option::none<address>(),
            mint_cap     : 0x1::option::none<address>(),
            burn_cap     : 0x1::option::none<address>(),
        };
        let v2 = 0x2::object::uid_to_address(&v1.id);
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut v1.id, v0, arg0);
        let v3 = New{
            name         : v0,
            treasury     : 0x2::object::id_address<0x2::coin::TreasuryCap<T0>>(&arg0),
            ipx_treasury : v2,
        };
        0x2::event::emit<New>(v3);
        let v4 = CapWitness{
            treasury             : v2,
            name                 : v0,
            mint_cap_address     : 0x1::option::none<address>(),
            burn_cap_address     : 0x1::option::none<address>(),
            metadata_cap_address : 0x1::option::none<address>(),
        };
        (v1, v4)
    }

    public fun add_burn_capability(arg0: &mut CapWitness, arg1: &mut IPXTreasuryStandard) {
        assert!(0x1::option::is_none<address>(&arg0.burn_cap_address), 1);
        arg0.burn_cap_address = 0x1::option::some<address>(0x2::object::uid_to_address(&arg1.id));
        arg1.can_burn = true;
    }

    public fun burn_cap_address(arg0: &CapWitness) : 0x1::option::Option<address> {
        arg0.burn_cap_address
    }

    public fun burn_cap_name(arg0: &BurnCap) : 0x1::type_name::TypeName {
        arg0.name
    }

    public fun burn_cap_treasury(arg0: &BurnCap) : address {
        arg0.treasury
    }

    public fun can_burn(arg0: &IPXTreasuryStandard) : bool {
        arg0.can_burn
    }

    public fun cap_burn<T0>(arg0: &BurnCap, arg1: &mut IPXTreasuryStandard, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg0.treasury == 0x2::object::uid_to_address(&arg1.id), 0);
        let v0 = Burn{
            pos0 : arg1.name,
            pos1 : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<Burn>(v0);
        0x2::coin::burn<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, arg1.name), arg2);
    }

    public fun cap_witness_name(arg0: &CapWitness) : 0x1::type_name::TypeName {
        arg0.name
    }

    public fun cap_witness_treasury(arg0: &CapWitness) : address {
        arg0.treasury
    }

    public fun create_burn_cap(arg0: &mut CapWitness, arg1: &mut 0x2::tx_context::TxContext) : BurnCap {
        assert!(0x1::option::is_none<address>(&arg0.burn_cap_address), 1);
        let v0 = 0x2::object::new(arg1);
        arg0.burn_cap_address = 0x1::option::some<address>(0x2::object::uid_to_address(&v0));
        BurnCap{
            id       : v0,
            treasury : arg0.treasury,
            name     : arg0.name,
        }
    }

    public fun create_metadata_cap(arg0: &mut CapWitness, arg1: &mut 0x2::tx_context::TxContext) : MetadataCap {
        assert!(0x1::option::is_none<address>(&arg0.metadata_cap_address), 1);
        let v0 = 0x2::object::new(arg1);
        arg0.metadata_cap_address = 0x1::option::some<address>(0x2::object::uid_to_address(&v0));
        MetadataCap{
            id       : v0,
            treasury : arg0.treasury,
            name     : arg0.name,
        }
    }

    public fun create_mint_cap(arg0: &mut CapWitness, arg1: &mut 0x2::tx_context::TxContext) : MintCap {
        assert!(0x1::option::is_none<address>(&arg0.mint_cap_address), 1);
        let v0 = 0x2::object::new(arg1);
        arg0.mint_cap_address = 0x1::option::some<address>(0x2::object::uid_to_address(&v0));
        MintCap{
            id       : v0,
            treasury : arg0.treasury,
            name     : arg0.name,
        }
    }

    public fun destroy_burn_cap(arg0: &mut IPXTreasuryStandard, arg1: BurnCap) {
        let BurnCap {
            id       : v0,
            treasury : v1,
            name     : v2,
        } = arg1;
        assert!(v1 == 0x2::object::uid_to_address(&arg0.id), 3);
        arg0.burn_cap = 0x1::option::none<address>();
        let v3 = DestroyBurnCap{pos0: v2};
        0x2::event::emit<DestroyBurnCap>(v3);
        0x2::object::delete(v0);
    }

    public fun destroy_cap_witness(arg0: &mut IPXTreasuryStandard, arg1: CapWitness) {
        let CapWitness {
            treasury             : v0,
            name                 : _,
            mint_cap_address     : v2,
            burn_cap_address     : v3,
            metadata_cap_address : v4,
        } = arg1;
        assert!(v0 == 0x2::object::uid_to_address(&arg0.id), 3);
        arg0.mint_cap = v2;
        let v5 = if (arg0.can_burn) {
            0x1::option::none<address>()
        } else {
            v3
        };
        arg0.burn_cap = v5;
        arg0.metadata_cap = v4;
    }

    public fun destroy_metadata_cap(arg0: &mut IPXTreasuryStandard, arg1: MetadataCap) {
        let MetadataCap {
            id       : v0,
            treasury : v1,
            name     : v2,
        } = arg1;
        assert!(v1 == 0x2::object::uid_to_address(&arg0.id), 3);
        arg0.metadata_cap = 0x1::option::none<address>();
        let v3 = DestroyMetadataCap{pos0: v2};
        0x2::event::emit<DestroyMetadataCap>(v3);
        0x2::object::delete(v0);
    }

    public fun destroy_mint_cap(arg0: &mut IPXTreasuryStandard, arg1: MintCap) {
        let MintCap {
            id       : v0,
            treasury : v1,
            name     : v2,
        } = arg1;
        assert!(v1 == 0x2::object::uid_to_address(&arg0.id), 3);
        arg0.mint_cap = 0x1::option::none<address>();
        let v3 = DestroyMintCap{pos0: v2};
        0x2::event::emit<DestroyMintCap>(v3);
        0x2::object::delete(v0);
    }

    public fun metadata_cap_address(arg0: &CapWitness) : 0x1::option::Option<address> {
        arg0.metadata_cap_address
    }

    public fun metadata_cap_name(arg0: &MetadataCap) : 0x1::type_name::TypeName {
        arg0.name
    }

    public fun metadata_cap_treasury(arg0: &MetadataCap) : address {
        arg0.treasury
    }

    public fun mint_cap_address(arg0: &CapWitness) : 0x1::option::Option<address> {
        arg0.mint_cap_address
    }

    public fun mint_cap_name(arg0: &MintCap) : 0x1::type_name::TypeName {
        arg0.name
    }

    public fun mint_cap_treasury(arg0: &MintCap) : address {
        arg0.treasury
    }

    public fun treasury_burn<T0>(arg0: &mut IPXTreasuryStandard, arg1: 0x2::coin::Coin<T0>) {
        assert!(arg0.can_burn, 2);
        let v0 = Burn{
            pos0 : arg0.name,
            pos1 : 0x2::coin::value<T0>(&arg1),
        };
        0x2::event::emit<Burn>(v0);
        0x2::coin::burn<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, arg0.name), arg1);
    }

    public fun treasury_cap_name(arg0: &IPXTreasuryStandard) : 0x1::type_name::TypeName {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

