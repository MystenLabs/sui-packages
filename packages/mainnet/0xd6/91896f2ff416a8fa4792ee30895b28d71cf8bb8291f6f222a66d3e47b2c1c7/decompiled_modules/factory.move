module 0xd691896f2ff416a8fa4792ee30895b28d71cf8bb8291f6f222a66d3e47b2c1c7::factory {
    struct State has key {
        id: 0x2::object::UID,
        commission: u16,
        platform: address,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct CollectionCap has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        symbol: 0x1::string::String,
        image_url: 0x2::url::Url,
        royalty: u16,
        royalty_receiver: address,
    }

    struct MintCap<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        link: 0x2::url::Url,
        image_url: 0x2::url::Url,
        whitelisted: bool,
        uses: u8,
    }

    struct SignerSet has copy, drop {
        new_signer: address,
    }

    struct CommissionSet has copy, drop {
        new_commission: u16,
    }

    struct PlatformAddressSet has copy, drop {
        new_platform_address: address,
    }

    public entry fun create_collection_cap(arg0: &OwnerCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u16, arg6: address, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg1) > 0, 0);
        assert!(0x1::string::length(&arg3) > 0, 1);
        let v0 = CollectionCap{
            id               : 0x2::object::new(arg8),
            name             : arg1,
            description      : arg2,
            symbol           : arg3,
            image_url        : 0x2::url::new_unsafe(0x1::string::to_ascii(arg4)),
            royalty          : arg5,
            royalty_receiver : arg6,
        };
        0x2::transfer::transfer<CollectionCap>(v0, arg7);
    }

    public entry fun create_mint_cap<T0: drop>(arg0: &OwnerCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: bool, arg6: u8, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = MintCap<T0>{
            id          : 0x2::object::new(arg8),
            name        : arg1,
            description : arg2,
            link        : 0x2::url::new_unsafe(0x1::string::to_ascii(arg3)),
            image_url   : 0x2::url::new_unsafe(0x1::string::to_ascii(arg4)),
            whitelisted : arg5,
            uses        : arg6,
        };
        0x2::transfer::transfer<MintCap<T0>>(v0, arg7);
    }

    public fun destroy_collection_cap(arg0: CollectionCap) : (0x1::string::String, 0x1::string::String, 0x1::string::String, 0x2::url::Url, u16, address) {
        let CollectionCap {
            id               : v0,
            name             : v1,
            description      : v2,
            symbol           : v3,
            image_url        : v4,
            royalty          : v5,
            royalty_receiver : v6,
        } = arg0;
        0x2::object::delete(v0);
        (v1, v2, v3, v4, v5, v6)
    }

    public fun destroy_mint_cap<T0: drop>(arg0: MintCap<T0>) {
        let MintCap {
            id          : v0,
            name        : _,
            description : _,
            link        : _,
            image_url   : _,
            whitelisted : _,
            uses        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun get_platform_address(arg0: &State) : address {
        arg0.platform
    }

    public(friend) fun get_platform_commission(arg0: &State) : u16 {
        arg0.commission
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = State{
            id         : 0x2::object::new(arg0),
            commission : 0,
            platform   : @0x0,
        };
        0x2::transfer::share_object<State>(v0);
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        set_signer(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun set_commission(arg0: &OwnerCap, arg1: u16, arg2: &mut State) {
        arg2.commission = arg1;
        let v0 = CommissionSet{new_commission: arg1};
        0x2::event::emit<CommissionSet>(v0);
    }

    public entry fun set_platform_address(arg0: &OwnerCap, arg1: address, arg2: &mut State) {
        arg2.platform = arg1;
        let v0 = PlatformAddressSet{new_platform_address: arg1};
        0x2::event::emit<PlatformAddressSet>(v0);
    }

    public entry fun set_signer(arg0: OwnerCap, arg1: address) {
        0x2::transfer::transfer<OwnerCap>(arg0, arg1);
        let v0 = SignerSet{new_signer: arg1};
        0x2::event::emit<SignerSet>(v0);
    }

    public(friend) fun use_mint_cap<T0: drop>(arg0: MintCap<T0>, arg1: &0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String, 0x2::url::Url, 0x2::url::Url, bool) {
        if (arg0.uses == 1) {
            destroy_mint_cap<T0>(arg0);
        } else {
            arg0.uses = arg0.uses - 1;
            0x2::transfer::transfer<MintCap<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
        (arg0.name, arg0.description, arg0.link, arg0.image_url, arg0.whitelisted)
    }

    // decompiled from Move bytecode v6
}

