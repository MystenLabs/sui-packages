module 0xad361131dd8a8f78fb8c68225f5d897a6602a624653074ad51cfe4ffb4c1e0f2::collectible {
    struct Registry has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct CollectionCap<T0: store> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::borrow::Referent<0x2::package::Publisher>,
        display: 0x2::borrow::Referent<0x2::display::Display<Collectible<T0>>>,
        policy_cap: 0x2::borrow::Referent<0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>>,
        max_supply: 0x1::option::Option<u32>,
        minted: u32,
        burned: u32,
    }

    struct CollectionTicket<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        max_supply: 0x1::option::Option<u32>,
    }

    struct Collectible<T0: store> has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        name: 0x1::option::Option<0x1::string::String>,
        description: 0x1::option::Option<0x1::string::String>,
        creator: 0x1::option::Option<0x1::string::String>,
        meta: 0x1::option::Option<T0>,
    }

    struct COLLECTIBLE has drop {
        dummy_field: bool,
    }

    public fun batch_mint<T0: store>(arg0: &mut CollectionCap<T0>, arg1: vector<0x1::string::String>, arg2: 0x1::option::Option<vector<0x1::string::String>>, arg3: 0x1::option::Option<vector<0x1::string::String>>, arg4: 0x1::option::Option<vector<0x1::string::String>>, arg5: 0x1::option::Option<vector<T0>>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg1);
        assert!(0x1::option::is_none<u32>(&arg0.max_supply) || arg0.minted + (v0 as u32) < *0x1::option::borrow<u32>(&arg0.max_supply), 2);
        assert!(0x1::option::is_none<vector<0x1::string::String>>(&arg2) || 0x1::vector::length<0x1::string::String>(0x1::option::borrow<vector<0x1::string::String>>(&arg2)) == v0, 3);
        assert!(0x1::option::is_none<vector<0x1::string::String>>(&arg4) || 0x1::vector::length<0x1::string::String>(0x1::option::borrow<vector<0x1::string::String>>(&arg4)) == v0, 5);
        assert!(0x1::option::is_none<vector<0x1::string::String>>(&arg3) || 0x1::vector::length<0x1::string::String>(0x1::option::borrow<vector<0x1::string::String>>(&arg3)) == v0, 4);
        assert!(0x1::option::is_none<vector<T0>>(&arg5) || 0x1::vector::length<T0>(0x1::option::borrow<vector<T0>>(&arg5)) == v0, 6);
        while (v0 > 0) {
            let v1 = &mut arg2;
            let v2 = &mut arg3;
            let v3 = &mut arg4;
            let v4 = &mut arg5;
            let v5 = mint<T0>(arg0, 0x1::vector::pop_back<0x1::string::String>(&mut arg1), pop_or_none<0x1::string::String>(v1), pop_or_none<0x1::string::String>(v2), pop_or_none<0x1::string::String>(v3), pop_or_none<T0>(v4), arg6);
            0x2::transfer::transfer<Collectible<T0>>(v5, 0x2::tx_context::sender(arg6));
            v0 = v0 - 1;
        };
        if (0x1::option::is_some<vector<T0>>(&arg5)) {
            0x1::vector::destroy_empty<T0>(0x1::option::destroy_some<vector<T0>>(arg5));
        } else {
            0x1::option::destroy_none<vector<T0>>(arg5);
        };
    }

    public fun borrow_display<T0: store>(arg0: &mut CollectionCap<T0>) : (0x2::display::Display<Collectible<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::display::Display<Collectible<T0>>>(&mut arg0.display)
    }

    public fun borrow_policy_cap<T0: store>(arg0: &mut CollectionCap<T0>) : (0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>>(&mut arg0.policy_cap)
    }

    public fun borrow_publisher<T0: store>(arg0: &mut CollectionCap<T0>) : (0x2::package::Publisher, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::package::Publisher>(&mut arg0.publisher)
    }

    public fun claim_ticket<T0: drop, T1: store>(arg0: T0, arg1: 0x1::option::Option<u32>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = 0x2::package::claim<T0>(arg0, arg2);
        assert!(0x2::package::from_module<T1>(&v0), 1);
        let v1 = CollectionTicket<T1>{
            id         : 0x2::object::new(arg2),
            publisher  : v0,
            max_supply : arg1,
        };
        0x2::transfer::transfer<CollectionTicket<T1>>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun create_collection<T0: store>(arg0: &Registry, arg1: CollectionTicket<T0>, arg2: &mut 0x2::tx_context::TxContext) : CollectionCap<T0> {
        let CollectionTicket {
            id         : v0,
            publisher  : v1,
            max_supply : v2,
        } = arg1;
        0x2::object::delete(v0);
        let (v3, v4) = 0x2::transfer_policy::new<Collectible<T0>>(&arg0.publisher, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Collectible<T0>>>(v3);
        CollectionCap<T0>{
            id         : 0x2::object::new(arg2),
            publisher  : 0x2::borrow::new<0x2::package::Publisher>(v1, arg2),
            display    : 0x2::borrow::new<0x2::display::Display<Collectible<T0>>>(0x2::display::new<Collectible<T0>>(&arg0.publisher, arg2), arg2),
            policy_cap : 0x2::borrow::new<0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>>(v4, arg2),
            max_supply : v2,
            minted     : 0,
            burned     : 0,
        }
    }

    fun init(arg0: COLLECTIBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<COLLECTIBLE>(arg0, arg1),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun mint<T0: store>(arg0: &mut CollectionCap<T0>, arg1: 0x1::string::String, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<T0>, arg6: &mut 0x2::tx_context::TxContext) : Collectible<T0> {
        assert!(0x1::option::is_none<u32>(&arg0.max_supply) || *0x1::option::borrow<u32>(&arg0.max_supply) > arg0.minted, 2);
        arg0.minted = arg0.minted + 1;
        Collectible<T0>{
            id          : 0x2::object::new(arg6),
            image_url   : arg1,
            name        : arg2,
            description : arg3,
            creator     : arg4,
            meta        : arg5,
        }
    }

    fun pop_or_none<T0>(arg0: &mut 0x1::option::Option<vector<T0>>) : 0x1::option::Option<T0> {
        if (0x1::option::is_none<vector<T0>>(arg0)) {
            0x1::option::none<T0>()
        } else {
            0x1::option::some<T0>(0x1::vector::pop_back<T0>(0x1::option::borrow_mut<vector<T0>>(arg0)))
        }
    }

    public fun return_display<T0: store>(arg0: &mut CollectionCap<T0>, arg1: 0x2::display::Display<Collectible<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::display::Display<Collectible<T0>>>(&mut arg0.display, arg1, arg2);
    }

    public fun return_policy_cap<T0: store>(arg0: &mut CollectionCap<T0>, arg1: 0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::transfer_policy::TransferPolicyCap<Collectible<T0>>>(&mut arg0.policy_cap, arg1, arg2);
    }

    public fun return_publisher<T0: store>(arg0: &mut CollectionCap<T0>, arg1: 0x2::package::Publisher, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::package::Publisher>(&mut arg0.publisher, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

