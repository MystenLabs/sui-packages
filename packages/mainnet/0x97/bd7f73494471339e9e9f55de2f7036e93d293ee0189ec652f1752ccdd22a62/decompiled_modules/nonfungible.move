module 0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::nonfungible {
    struct Registry has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct NftTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        max_supply: 0x1::option::Option<u32>,
    }

    struct AdminCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::borrow::Referent<0x2::package::Publisher>,
        display: 0x2::borrow::Referent<0x2::display::Display<Nft<T0>>>,
        policy_cap: 0x2::borrow::Referent<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>,
        pebble_policy_cap: 0x2::borrow::Referent<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>,
    }

    struct OperatorCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        minter_addresses: 0x2::vec_set::VecSet<address>,
        burner_addresses: 0x2::vec_set::VecSet<address>,
        max_supply: 0x1::option::Option<u32>,
        minted: u32,
        burned: u32,
    }

    struct Nft<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        properties: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NONFUNGIBLE has drop {
        dummy_field: bool,
    }

    struct EventCreateCollection has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        operator: address,
        admin_cap: 0x2::object::ID,
        operator_cap: 0x2::object::ID,
    }

    struct EventMint<phantom T0> has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        operator: address,
    }

    struct EventBurn<phantom T0> has copy, drop {
        nft_id: 0x2::object::ID,
        operator: address,
    }

    public entry fun transfer<T0>(arg0: Nft<T0>, arg1: address) {
        0x2::transfer::public_transfer<Nft<T0>>(arg0, arg1);
    }

    public fun add_properties<T0>(arg0: &OperatorCap<T0>, arg1: &mut Nft<T0>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &0x2::tx_context::TxContext) {
        assert!(can_mint<T0>(arg0, 0x2::tx_context::sender(arg4)), 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 4);
        let v0 = arg1.properties;
        while (!0x1::vector::is_empty<0x1::string::String>(&arg2)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::vector::pop_back<0x1::string::String>(&mut arg2), 0x1::vector::pop_back<0x1::string::String>(&mut arg3));
        };
        arg1.properties = v0;
    }

    public fun batch_burn<T0>(arg0: &mut OperatorCap<T0>, arg1: vector<Nft<T0>>, arg2: &0x2::tx_context::TxContext) {
        assert!(can_burn<T0>(arg0, 0x2::tx_context::sender(arg2)), 0);
        arg0.burned = arg0.burned + (0x1::vector::length<Nft<T0>>(&arg1) as u32);
        while (!0x1::vector::is_empty<Nft<T0>>(&arg1)) {
            burn_internal<T0>(0x1::vector::pop_back<Nft<T0>>(&mut arg1), arg2);
        };
        0x1::vector::destroy_empty<Nft<T0>>(arg1);
    }

    public fun batch_mint<T0>(arg0: &mut OperatorCap<T0>, arg1: address, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(can_mint<T0>(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = (0x1::vector::length<0x1::string::String>(&arg2) as u32);
        assert!(0x1::option::is_none<u32>(&arg0.max_supply) || arg0.minted + v0 < *0x1::option::borrow<u32>(&arg0.max_supply), 3);
        arg0.minted = arg0.minted + v0;
        while (!0x1::vector::is_empty<0x1::string::String>(&arg2)) {
            0x2::transfer::public_transfer<Nft<T0>>(mint_internal<T0>(0x1::vector::pop_back<0x1::string::String>(&mut arg2), arg3), arg1);
        };
    }

    public fun batch_mint_and_transfer<T0>(arg0: &mut OperatorCap<T0>, arg1: vector<address>, arg2: vector<0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(can_mint<T0>(arg0, 0x2::tx_context::sender(arg3)), 0);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<0x1::string::String>(&arg2), 4);
        let v0 = (0x1::vector::length<address>(&arg1) as u32);
        assert!(0x1::option::is_none<u32>(&arg0.max_supply) || arg0.minted + v0 < *0x1::option::borrow<u32>(&arg0.max_supply), 3);
        arg0.minted = arg0.minted + v0;
        while (!0x1::vector::is_empty<address>(&arg1)) {
            0x2::transfer::public_transfer<Nft<T0>>(mint_internal<T0>(0x1::vector::pop_back<0x1::string::String>(&mut arg2), arg3), 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    public fun batch_transfer<T0>(arg0: vector<Nft<T0>>, arg1: vector<address>) {
        assert!(0x1::vector::length<Nft<T0>>(&arg0) == 0x1::vector::length<address>(&arg1), 4);
        while (!0x1::vector::is_empty<Nft<T0>>(&arg0)) {
            0x2::transfer::public_transfer<Nft<T0>>(0x1::vector::pop_back<Nft<T0>>(&mut arg0), 0x1::vector::pop_back<address>(&mut arg1));
        };
        0x1::vector::destroy_empty<Nft<T0>>(arg0);
    }

    public fun borrow_display<T0>(arg0: &mut AdminCap<T0>) : (0x2::display::Display<Nft<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::display::Display<Nft<T0>>>(&mut arg0.display)
    }

    public fun borrow_pebble_policy_cap<T0>(arg0: &mut AdminCap<T0>) : (0x2::transfer_policy::TransferPolicyCap<Nft<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>(&mut arg0.pebble_policy_cap)
    }

    public fun borrow_policy_cap<T0>(arg0: &mut AdminCap<T0>) : (0x2::transfer_policy::TransferPolicyCap<Nft<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>(&mut arg0.policy_cap)
    }

    public fun borrow_publisher<T0>(arg0: &mut AdminCap<T0>) : (0x2::package::Publisher, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::package::Publisher>(&mut arg0.publisher)
    }

    public fun burn<T0>(arg0: &mut OperatorCap<T0>, arg1: Nft<T0>, arg2: &0x2::tx_context::TxContext) {
        assert!(can_burn<T0>(arg0, 0x2::tx_context::sender(arg2)), 0);
        arg0.burned = arg0.burned + 1;
        burn_internal<T0>(arg1, arg2);
    }

    fun burn_internal<T0>(arg0: Nft<T0>, arg1: &0x2::tx_context::TxContext) {
        let Nft {
            id         : v0,
            name       : _,
            properties : v2,
        } = arg0;
        let v3 = v0;
        let v4 = EventBurn<T0>{
            nft_id   : 0x2::object::uid_to_inner(&v3),
            operator : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EventBurn<T0>>(v4);
        delete_properties(v2);
        0x2::object::delete(v3);
    }

    fun can_burn<T0>(arg0: &OperatorCap<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.burner_addresses, &arg1)
    }

    fun can_mint<T0>(arg0: &OperatorCap<T0>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.minter_addresses, &arg1)
    }

    public fun claim_ticket<T0: drop, T1>(arg0: T0, arg1: 0x1::option::Option<u32>, arg2: &mut 0x2::tx_context::TxContext) : NftTicket<T1> {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 1);
        let v0 = 0x2::package::claim<T0>(arg0, arg2);
        assert!(0x2::package::from_module<T1>(&v0), 2);
        NftTicket<T1>{
            id         : 0x2::object::new(arg2),
            publisher  : v0,
            max_supply : arg1,
        }
    }

    public fun create_collection<T0>(arg0: &Registry, arg1: NftTicket<T0>, arg2: &mut 0x2::tx_context::TxContext) : (AdminCap<T0>, OperatorCap<T0>) {
        let NftTicket {
            id         : v0,
            publisher  : v1,
            max_supply : v2,
        } = arg1;
        0x2::object::delete(v0);
        let (v3, v4) = 0x2::transfer_policy::new<Nft<T0>>(&arg0.publisher, arg2);
        let (v5, v6) = 0x2::transfer_policy::new<Nft<T0>>(&arg0.publisher, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft<T0>>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicy<Nft<T0>>>(v5, 0x2::tx_context::sender(arg2));
        let v7 = AdminCap<T0>{
            id                : 0x2::object::new(arg2),
            publisher         : 0x2::borrow::new<0x2::package::Publisher>(v1, arg2),
            display           : 0x2::borrow::new<0x2::display::Display<Nft<T0>>>(0x2::display::new<Nft<T0>>(&arg0.publisher, arg2), arg2),
            policy_cap        : 0x2::borrow::new<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>(v4, arg2),
            pebble_policy_cap : 0x2::borrow::new<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>(v6, arg2),
        };
        let v8 = OperatorCap<T0>{
            id               : 0x2::object::new(arg2),
            minter_addresses : 0x2::vec_set::empty<address>(),
            burner_addresses : 0x2::vec_set::empty<address>(),
            max_supply       : v2,
            minted           : 0,
            burned           : 0,
        };
        let v9 = EventCreateCollection{
            nft_type     : 0x1::type_name::get<T0>(),
            operator     : 0x2::tx_context::sender(arg2),
            admin_cap    : 0x2::object::uid_to_inner(&v7.id),
            operator_cap : 0x2::object::uid_to_inner(&v8.id),
        };
        0x2::event::emit<EventCreateCollection>(v9);
        (v7, v8)
    }

    fun delete_properties(arg0: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        while (!0x2::vec_map::is_empty<0x1::string::String, 0x1::string::String>(&arg0)) {
            let (_, _) = 0x2::vec_map::pop<0x1::string::String, 0x1::string::String>(&mut arg0);
        };
        0x2::vec_map::destroy_empty<0x1::string::String, 0x1::string::String>(arg0);
    }

    public fun get_burner_addresses<T0>(arg0: &OperatorCap<T0>) : 0x2::vec_set::VecSet<address> {
        arg0.burner_addresses
    }

    public fun get_max_supply<T0>(arg0: &OperatorCap<T0>) : 0x1::option::Option<u32> {
        arg0.max_supply
    }

    public fun get_minter_addresses<T0>(arg0: &OperatorCap<T0>) : 0x2::vec_set::VecSet<address> {
        arg0.minter_addresses
    }

    public fun get_name<T0>(arg0: &Nft<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun get_properties<T0>(arg0: &Nft<T0>) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.properties
    }

    public fun get_supply<T0>(arg0: &OperatorCap<T0>) : (u32, u32) {
        (arg0.minted, arg0.burned)
    }

    public fun grant_burner_addresses<T0>(arg0: &AdminCap<T0>, arg1: &mut OperatorCap<T0>, arg2: vector<address>) {
        let v0 = arg1.burner_addresses;
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut v0, 0x1::vector::pop_back<address>(&mut arg2));
        };
        arg1.burner_addresses = v0;
    }

    public fun grant_minter_addresses<T0>(arg0: &AdminCap<T0>, arg1: &mut OperatorCap<T0>, arg2: vector<address>) {
        let v0 = arg1.minter_addresses;
        while (!0x1::vector::is_empty<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut v0, 0x1::vector::pop_back<address>(&mut arg2));
        };
        arg1.minter_addresses = v0;
    }

    fun init(arg0: NONFUNGIBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<NONFUNGIBLE>(arg0, arg1),
        };
        0x2::transfer::transfer<Registry>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint<T0>(arg0: &mut OperatorCap<T0>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : Nft<T0> {
        assert!(can_mint<T0>(arg0, 0x2::tx_context::sender(arg2)), 0);
        assert!(0x1::option::is_none<u32>(&arg0.max_supply) || *0x1::option::borrow<u32>(&arg0.max_supply) > arg0.minted, 3);
        arg0.minted = arg0.minted + 1;
        mint_internal<T0>(arg1, arg2)
    }

    public fun mint_and_transfer<T0>(arg0: &mut OperatorCap<T0>, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Nft<T0>>(mint<T0>(arg0, arg2, arg3), arg1);
    }

    fun mint_internal<T0>(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Nft<T0> {
        let v0 = Nft<T0>{
            id         : 0x2::object::new(arg1),
            name       : arg0,
            properties : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        let v1 = EventMint<T0>{
            nft_id   : 0x2::object::uid_to_inner(&v0.id),
            name     : arg0,
            operator : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EventMint<T0>>(v1);
        v0
    }

    public fun remove_properties<T0>(arg0: &OperatorCap<T0>, arg1: &mut Nft<T0>, arg2: vector<0x1::string::String>, arg3: &0x2::tx_context::TxContext) {
        assert!(can_mint<T0>(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = arg1.properties;
        while (!0x1::vector::is_empty<0x1::string::String>(&arg2)) {
            let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut arg2);
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0, &v1);
        };
        arg1.properties = v0;
    }

    public fun return_display<T0>(arg0: &mut AdminCap<T0>, arg1: 0x2::display::Display<Nft<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::display::Display<Nft<T0>>>(&mut arg0.display, arg1, arg2);
    }

    public fun return_pebble_policy_cap<T0>(arg0: &mut AdminCap<T0>, arg1: 0x2::transfer_policy::TransferPolicyCap<Nft<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>(&mut arg0.pebble_policy_cap, arg1, arg2);
    }

    public fun return_policy_cap<T0>(arg0: &mut AdminCap<T0>, arg1: 0x2::transfer_policy::TransferPolicyCap<Nft<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>(&mut arg0.policy_cap, arg1, arg2);
    }

    public fun return_publisher<T0>(arg0: &mut AdminCap<T0>, arg1: 0x2::package::Publisher, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::package::Publisher>(&mut arg0.publisher, arg1, arg2);
    }

    public fun revoke_burner_addresses<T0>(arg0: &AdminCap<T0>, arg1: &mut OperatorCap<T0>, arg2: vector<address>) {
        let v0 = arg1.burner_addresses;
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            0x2::vec_set::remove<address>(&mut v0, &v1);
        };
        arg1.burner_addresses = v0;
    }

    public fun revoke_minter_addresses<T0>(arg0: &AdminCap<T0>, arg1: &mut OperatorCap<T0>, arg2: vector<address>) {
        let v0 = arg1.minter_addresses;
        while (!0x1::vector::is_empty<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            0x2::vec_set::remove<address>(&mut v0, &v1);
        };
        arg1.minter_addresses = v0;
    }

    public fun update_name<T0>(arg0: &OperatorCap<T0>, arg1: &mut Nft<T0>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(can_mint<T0>(arg0, 0x2::tx_context::sender(arg3)), 0);
        arg1.name = arg2;
    }

    public fun update_properties<T0>(arg0: &OperatorCap<T0>, arg1: &mut Nft<T0>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &0x2::tx_context::TxContext) {
        assert!(can_mint<T0>(arg0, 0x2::tx_context::sender(arg4)), 0);
        assert!(0x1::vector::length<0x1::string::String>(&arg2) == 0x1::vector::length<0x1::string::String>(&arg3), 4);
        let v0 = arg1.properties;
        while (!0x1::vector::is_empty<0x1::string::String>(&arg2)) {
            let v1 = 0x1::vector::pop_back<0x1::string::String>(&mut arg2);
            let v2 = 0x2::vec_map::get_idx_opt<0x1::string::String, 0x1::string::String>(&v0, &v1);
            if (0x1::option::is_some<u64>(&v2)) {
                let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0, &v1);
            };
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, v1, 0x1::vector::pop_back<0x1::string::String>(&mut arg3));
        };
        arg1.properties = v0;
    }

    // decompiled from Move bytecode v6
}

