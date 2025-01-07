module 0x7a7faa02ec4049c71c148084954f838a55b9967a482fa2cbd63c9d8d241370f8::coin_v2 {
    struct CapWitness has drop {
        treasury: address,
        name: 0x1::type_name::TypeName,
        mint_cap_created: bool,
        burn_cap_created: bool,
        metadata_cap_created: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
        treasury: address,
        name: 0x1::type_name::TypeName,
    }

    struct BurnCap has store, key {
        id: 0x2::object::UID,
        treasury: address,
        indestructible: bool,
        name: 0x1::type_name::TypeName,
    }

    struct MetadataCap has store, key {
        id: 0x2::object::UID,
        treasury: address,
        name: 0x1::type_name::TypeName,
    }

    struct TreasuryCapV2 has store, key {
        id: 0x2::object::UID,
        name: 0x1::type_name::TypeName,
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

    public fun burn<T0>(arg0: &mut TreasuryCapV2, arg1: &BurnCap, arg2: 0x2::coin::Coin<T0>) {
        assert!(arg1.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372745524379649);
        let v0 = Burn{
            pos0 : arg0.name,
            pos1 : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<Burn>(v0);
        0x2::coin::burn<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, arg0.name), arg2);
    }

    public fun mint<T0>(arg0: &mut TreasuryCapV2, arg1: &MintCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372685394837505);
        let v0 = Mint{
            pos0 : arg0.name,
            pos1 : arg2,
        };
        0x2::event::emit<Mint>(v0);
        0x2::coin::mint<T0>(0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, arg0.name), arg2, arg3)
    }

    public fun total_supply<T0>(arg0: &TreasuryCapV2) : u64 {
        0x2::coin::total_supply<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name))
    }

    public fun update_description<T0>(arg0: &TreasuryCapV2, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::string::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372921618038785);
        0x2::coin::update_description<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun update_icon_url<T0>(arg0: &TreasuryCapV2, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::ascii::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372977452613633);
        0x2::coin::update_icon_url<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun update_name<T0>(arg0: &TreasuryCapV2, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::string::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372809948889089);
        0x2::coin::update_name<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun update_symbol<T0>(arg0: &TreasuryCapV2, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: &MetadataCap, arg3: 0x1::ascii::String) {
        assert!(arg2.treasury == 0x2::object::uid_to_address(&arg0.id), 9223372865783463937);
        0x2::coin::update_symbol<T0>(0x2::dynamic_object_field::borrow<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&arg0.id, arg0.name), arg1, arg3);
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : (TreasuryCapV2, CapWitness) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = TreasuryCapV2{
            id   : 0x2::object::new(arg1),
            name : v0,
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut v1.id, v0, arg0);
        let v2 = CapWitness{
            treasury             : 0x2::object::uid_to_address(&v1.id),
            name                 : v0,
            mint_cap_created     : false,
            burn_cap_created     : false,
            metadata_cap_created : false,
        };
        (v1, v2)
    }

    public fun burn_cap_name(arg0: &BurnCap) : 0x1::type_name::TypeName {
        arg0.name
    }

    public fun burn_cap_treasury(arg0: &BurnCap) : address {
        arg0.treasury
    }

    public fun create_burn_cap(arg0: &mut CapWitness, arg1: &mut 0x2::tx_context::TxContext) : BurnCap {
        assert!(!arg0.burn_cap_created, 9223372513596276739);
        arg0.burn_cap_created = true;
        BurnCap{
            id             : 0x2::object::new(arg1),
            treasury       : arg0.treasury,
            indestructible : false,
            name           : arg0.name,
        }
    }

    public fun create_indestructible_burn_cap(arg0: &mut CapWitness, arg1: &mut 0x2::tx_context::TxContext) : BurnCap {
        assert!(!arg0.burn_cap_created, 9223372565135884291);
        arg0.burn_cap_created = true;
        BurnCap{
            id             : 0x2::object::new(arg1),
            treasury       : arg0.treasury,
            indestructible : true,
            name           : arg0.name,
        }
    }

    public fun create_metadata_cap(arg0: &mut CapWitness, arg1: &mut 0x2::tx_context::TxContext) : MetadataCap {
        assert!(!arg0.metadata_cap_created, 9223372616675491843);
        arg0.metadata_cap_created = true;
        MetadataCap{
            id       : 0x2::object::new(arg1),
            treasury : arg0.treasury,
            name     : arg0.name,
        }
    }

    public fun create_mint_cap(arg0: &mut CapWitness, arg1: &mut 0x2::tx_context::TxContext) : MintCap {
        assert!(!arg0.mint_cap_created, 9223372466351636483);
        arg0.mint_cap_created = true;
        MintCap{
            id       : 0x2::object::new(arg1),
            treasury : arg0.treasury,
            name     : arg0.name,
        }
    }

    public fun destroy_burn_cap(arg0: BurnCap) {
        assert!(!arg0.indestructible, 9223373046172352517);
        let BurnCap {
            id             : v0,
            treasury       : _,
            indestructible : _,
            name           : v3,
        } = arg0;
        let v4 = DestroyBurnCap{pos0: v3};
        0x2::event::emit<DestroyBurnCap>(v4);
        0x2::object::delete(v0);
    }

    public fun destroy_metadata_cap(arg0: MetadataCap) {
        let MetadataCap {
            id       : v0,
            treasury : _,
            name     : v2,
        } = arg0;
        let v3 = DestroyMetadataCap{pos0: v2};
        0x2::event::emit<DestroyMetadataCap>(v3);
        0x2::object::delete(v0);
    }

    public fun destroy_mint_cap(arg0: MintCap) {
        let MintCap {
            id       : v0,
            treasury : _,
            name     : v2,
        } = arg0;
        let v3 = DestroyMintCap{pos0: v2};
        0x2::event::emit<DestroyMintCap>(v3);
        0x2::object::delete(v0);
    }

    public fun metadata_cap_name(arg0: &MetadataCap) : 0x1::type_name::TypeName {
        arg0.name
    }

    public fun metadata_cap_treasury(arg0: &MetadataCap) : address {
        arg0.treasury
    }

    public fun mint_cap_name(arg0: &MintCap) : 0x1::type_name::TypeName {
        arg0.name
    }

    public fun mint_cap_treasury(arg0: &MintCap) : address {
        arg0.treasury
    }

    public fun treasury_cap_name(arg0: &TreasuryCapV2) : 0x1::type_name::TypeName {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

