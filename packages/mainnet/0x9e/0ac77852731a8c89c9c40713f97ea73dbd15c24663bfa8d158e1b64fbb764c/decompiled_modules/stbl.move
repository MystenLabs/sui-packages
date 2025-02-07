module 0x9e0ac77852731a8c89c9c40713f97ea73dbd15c24663bfa8d158e1b64fbb764c::stbl {
    struct STBL has drop {
        dummy_field: bool,
    }

    struct Capability has store, key {
        id: 0x2::object::UID,
        capability: 0x1::option::Option<0x2::coin::TreasuryCap<STBL>>,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct BurnCap has store, key {
        id: 0x2::object::UID,
    }

    struct MetadataCap has store, key {
        id: 0x2::object::UID,
    }

    struct GeneralCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventMint has copy, drop {
        amount: u64,
        operator: address,
    }

    struct EventBurn has copy, drop {
        amount: u64,
        operator: address,
    }

    struct EventUpdateMetadata has copy, drop {
        key: 0x1::string::String,
        value: 0x1::string::String,
        operator: address,
    }

    struct EventBurnCap has copy, drop {
        id: 0x2::object::ID,
        cap: 0x1::string::String,
        operator: address,
    }

    public entry fun burn(arg0: &mut Capability, arg1: &BurnCap, arg2: 0x2::coin::Coin<STBL>, arg3: &0x2::tx_context::TxContext) {
        let v0 = EventBurn{
            amount   : 0x2::coin::value<STBL>(&arg2),
            operator : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EventBurn>(v0);
        0x2::coin::burn<STBL>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<STBL>>(&mut arg0.capability), arg2);
    }

    public fun mint(arg0: &mut Capability, arg1: &MintCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<STBL> {
        let v0 = EventMint{
            amount   : arg2,
            operator : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EventMint>(v0);
        0x2::coin::mint<STBL>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<STBL>>(&mut arg0.capability), arg2, arg3)
    }

    public entry fun mint_and_transfer(arg0: &mut Capability, arg1: &MintCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<STBL>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<STBL>>(&mut arg0.capability), arg2, arg3, arg4);
        let v0 = EventMint{
            amount   : arg2,
            operator : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EventMint>(v0);
    }

    public fun supply_immut(arg0: &Capability, arg1: &GeneralCap) : &0x2::balance::Supply<STBL> {
        0x2::coin::supply_immut<STBL>(0x1::option::borrow<0x2::coin::TreasuryCap<STBL>>(&arg0.capability))
    }

    public fun supply_mut(arg0: &mut Capability, arg1: &GeneralCap) : &mut 0x2::balance::Supply<STBL> {
        0x2::coin::supply_mut<STBL>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<STBL>>(&mut arg0.capability))
    }

    public fun total_supply(arg0: &Capability, arg1: &GeneralCap) : u64 {
        0x2::coin::total_supply<STBL>(0x1::option::borrow<0x2::coin::TreasuryCap<STBL>>(&arg0.capability))
    }

    public fun treasury_into_supply(arg0: &mut Capability, arg1: &GeneralCap) : 0x2::balance::Supply<STBL> {
        0x2::coin::treasury_into_supply<STBL>(0x1::option::extract<0x2::coin::TreasuryCap<STBL>>(&mut arg0.capability))
    }

    public entry fun update_description(arg0: &Capability, arg1: &MetadataCap, arg2: &mut 0x2::coin::CoinMetadata<STBL>, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x2::coin::update_description<STBL>(0x1::option::borrow<0x2::coin::TreasuryCap<STBL>>(&arg0.capability), arg2, arg3);
        let v0 = EventUpdateMetadata{
            key      : 0x1::string::utf8(b"description"),
            value    : arg3,
            operator : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EventUpdateMetadata>(v0);
    }

    public entry fun update_icon_url(arg0: &Capability, arg1: &MetadataCap, arg2: &mut 0x2::coin::CoinMetadata<STBL>, arg3: 0x1::ascii::String, arg4: &0x2::tx_context::TxContext) {
        0x2::coin::update_icon_url<STBL>(0x1::option::borrow<0x2::coin::TreasuryCap<STBL>>(&arg0.capability), arg2, arg3);
        let v0 = EventUpdateMetadata{
            key      : 0x1::string::utf8(b"icon_url"),
            value    : 0x1::string::from_ascii(arg3),
            operator : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EventUpdateMetadata>(v0);
    }

    public entry fun update_name(arg0: &Capability, arg1: &MetadataCap, arg2: &mut 0x2::coin::CoinMetadata<STBL>, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x2::coin::update_name<STBL>(0x1::option::borrow<0x2::coin::TreasuryCap<STBL>>(&arg0.capability), arg2, arg3);
        let v0 = EventUpdateMetadata{
            key      : 0x1::string::utf8(b"name"),
            value    : arg3,
            operator : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EventUpdateMetadata>(v0);
    }

    public entry fun update_symbol(arg0: &Capability, arg1: &MetadataCap, arg2: &mut 0x2::coin::CoinMetadata<STBL>, arg3: 0x1::ascii::String, arg4: &0x2::tx_context::TxContext) {
        0x2::coin::update_symbol<STBL>(0x1::option::borrow<0x2::coin::TreasuryCap<STBL>>(&arg0.capability), arg2, arg3);
        let v0 = EventUpdateMetadata{
            key      : 0x1::string::utf8(b"symbol"),
            value    : 0x1::string::from_ascii(arg3),
            operator : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EventUpdateMetadata>(v0);
    }

    public fun delete_burn_cap(arg0: BurnCap, arg1: &0x2::tx_context::TxContext) {
        let BurnCap { id: v0 } = arg0;
        let v1 = EventBurnCap{
            id       : 0x2::object::uid_to_inner(&v0),
            cap      : 0x1::string::utf8(b"BurnCap"),
            operator : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EventBurnCap>(v1);
        0x2::object::delete(v0);
    }

    public fun delete_general_cap(arg0: GeneralCap, arg1: &0x2::tx_context::TxContext) {
        let GeneralCap { id: v0 } = arg0;
        let v1 = EventBurnCap{
            id       : 0x2::object::uid_to_inner(&v0),
            cap      : 0x1::string::utf8(b"GeneralCap"),
            operator : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EventBurnCap>(v1);
        0x2::object::delete(v0);
    }

    public fun delete_metadata_cap(arg0: MetadataCap, arg1: &0x2::tx_context::TxContext) {
        let MetadataCap { id: v0 } = arg0;
        let v1 = EventBurnCap{
            id       : 0x2::object::uid_to_inner(&v0),
            cap      : 0x1::string::utf8(b"MetadataCap"),
            operator : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EventBurnCap>(v1);
        0x2::object::delete(v0);
    }

    public fun delete_mint_cap(arg0: MintCap, arg1: &0x2::tx_context::TxContext) {
        let MintCap { id: v0 } = arg0;
        let v1 = EventBurnCap{
            id       : 0x2::object::uid_to_inner(&v0),
            cap      : 0x1::string::utf8(b"MintCap"),
            operator : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EventBurnCap>(v1);
        0x2::object::delete(v0);
    }

    fun init(arg0: STBL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STBL>(arg0, 9, b"STBL", b"Starble", b"Starble", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = Capability{
            id         : 0x2::object::new(arg1),
            capability : 0x1::option::some<0x2::coin::TreasuryCap<STBL>>(v0),
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STBL>>(v1);
        0x2::transfer::public_share_object<Capability>(v2);
        let v3 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = BurnCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BurnCap>(v4, 0x2::tx_context::sender(arg1));
        let v5 = MetadataCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MetadataCap>(v5, 0x2::tx_context::sender(arg1));
        let v6 = GeneralCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<GeneralCap>(v6, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

