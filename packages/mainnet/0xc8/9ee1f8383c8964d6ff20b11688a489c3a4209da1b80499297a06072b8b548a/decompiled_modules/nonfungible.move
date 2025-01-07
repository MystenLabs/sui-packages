module 0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::nonfungible {
    struct Registry has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
    }

    struct NftCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::borrow::Referent<0x2::package::Publisher>,
        display: 0x2::borrow::Referent<0x2::display::Display<Nft<T0>>>,
        policy_cap: 0x2::borrow::Referent<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>,
        max_supply: 0x1::option::Option<u32>,
        minted: u32,
        burned: u32,
    }

    struct NftTicket<phantom T0> has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        max_supply: 0x1::option::Option<u32>,
    }

    struct Nft<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        token_id: u64,
        metadata_url: 0x1::string::String,
        metadata: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct NONFUNGIBLE has drop {
        dummy_field: bool,
    }

    struct EventCreateCollection has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        operator: address,
    }

    struct EventMint has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        nft_id: 0x2::object::ID,
        metadata_url: 0x1::string::String,
        operator: address,
    }

    struct EventBurn has copy, drop {
        nft_type: 0x1::type_name::TypeName,
        nft_id: 0x2::object::ID,
        operator: address,
    }

    public entry fun transfer<T0>(arg0: Nft<T0>, arg1: address) {
        0x2::transfer::public_transfer<Nft<T0>>(arg0, arg1);
    }

    public fun add_metadata<T0>(arg0: &NftCap<T0>, arg1: &mut Nft<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.metadata, arg2, arg3);
    }

    public fun batch_burn<T0>(arg0: &mut NftCap<T0>, arg1: vector<Nft<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Nft<T0>>(&arg1);
        arg0.burned = arg0.burned + (v0 as u32);
        while (v0 > 0) {
            let Nft {
                id           : v1,
                name         : _,
                token_id     : _,
                metadata_url : _,
                metadata     : v5,
            } = 0x1::vector::pop_back<Nft<T0>>(&mut arg1);
            let v6 = v1;
            let v7 = EventBurn{
                nft_type : 0x1::type_name::get<T0>(),
                nft_id   : 0x2::object::uid_to_inner(&v6),
                operator : 0x2::tx_context::sender(arg2),
            };
            0x2::event::emit<EventBurn>(v7);
            deleteMetadata(v5);
            0x2::object::delete(v6);
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<Nft<T0>>(arg1);
    }

    public fun batch_mint<T0>(arg0: &mut NftCap<T0>, arg1: address, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg4);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 3);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 3);
        assert!(0x1::option::is_none<u32>(&arg0.max_supply) || arg0.minted + (v0 as u32) < *0x1::option::borrow<u32>(&arg0.max_supply), 2);
        while (v0 > 0) {
            0x2::transfer::transfer<Nft<T0>>(mint<T0>(arg0, 0x1::vector::pop_back<0x1::string::String>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4), arg5), arg1);
            v0 = v0 - 1;
        };
    }

    public fun batch_mint_and_transfer<T0>(arg0: &mut NftCap<T0>, arg1: vector<address>, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg2), 3);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 3);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg4), 3);
        assert!(0x1::option::is_none<u32>(&arg0.max_supply) || arg0.minted + (v0 as u32) < *0x1::option::borrow<u32>(&arg0.max_supply), 2);
        while (v0 > 0) {
            mint_and_transfer<T0>(arg0, 0x1::vector::pop_back<address>(&mut arg1), 0x1::vector::pop_back<0x1::string::String>(&mut arg2), 0x1::vector::pop_back<u64>(&mut arg3), 0x1::vector::pop_back<0x1::string::String>(&mut arg4), arg5);
            v0 = v0 - 1;
        };
    }

    public fun batch_transfer<T0>(arg0: vector<Nft<T0>>, arg1: vector<address>) {
        let v0 = 0x1::vector::length<Nft<T0>>(&arg0);
        assert!(v0 == 0x1::vector::length<address>(&arg1), 3);
        while (v0 > 0) {
            0x2::transfer::public_transfer<Nft<T0>>(0x1::vector::pop_back<Nft<T0>>(&mut arg0), 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 - 1;
        };
        0x1::vector::destroy_empty<Nft<T0>>(arg0);
    }

    public fun borrow_display<T0>(arg0: &mut NftCap<T0>) : (0x2::display::Display<Nft<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::display::Display<Nft<T0>>>(&mut arg0.display)
    }

    public fun borrow_policy_cap<T0>(arg0: &mut NftCap<T0>) : (0x2::transfer_policy::TransferPolicyCap<Nft<T0>>, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>(&mut arg0.policy_cap)
    }

    public fun borrow_publisher<T0>(arg0: &mut NftCap<T0>) : (0x2::package::Publisher, 0x2::borrow::Borrow) {
        0x2::borrow::borrow<0x2::package::Publisher>(&mut arg0.publisher)
    }

    public fun burn<T0>(arg0: &mut NftCap<T0>, arg1: Nft<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.burned = arg0.burned + 1;
        let Nft {
            id           : v0,
            name         : _,
            token_id     : _,
            metadata_url : _,
            metadata     : v4,
        } = arg1;
        let v5 = v0;
        let v6 = EventBurn{
            nft_type : 0x1::type_name::get<T0>(),
            nft_id   : 0x2::object::uid_to_inner(&v5),
            operator : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<EventBurn>(v6);
        deleteMetadata(v4);
        0x2::object::delete(v5);
    }

    public fun claim_ticket<T0: drop, T1>(arg0: T0, arg1: 0x1::option::Option<u32>, arg2: &mut 0x2::tx_context::TxContext) : NftTicket<T1> {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = 0x2::package::claim<T0>(arg0, arg2);
        assert!(0x2::package::from_module<T1>(&v0), 1);
        NftTicket<T1>{
            id         : 0x2::object::new(arg2),
            publisher  : v0,
            max_supply : arg1,
        }
    }

    public fun create_collection<T0>(arg0: &Registry, arg1: NftTicket<T0>, arg2: &mut 0x2::tx_context::TxContext) : NftCap<T0> {
        let NftTicket {
            id         : v0,
            publisher  : v1,
            max_supply : v2,
        } = arg1;
        0x2::object::delete(v0);
        let (v3, v4) = 0x2::transfer_policy::new<Nft<T0>>(&arg0.publisher, arg2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Nft<T0>>>(v3);
        let v5 = NftCap<T0>{
            id         : 0x2::object::new(arg2),
            publisher  : 0x2::borrow::new<0x2::package::Publisher>(v1, arg2),
            display    : 0x2::borrow::new<0x2::display::Display<Nft<T0>>>(0x2::display::new<Nft<T0>>(&arg0.publisher, arg2), arg2),
            policy_cap : 0x2::borrow::new<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>(v4, arg2),
            max_supply : v2,
            minted     : 0,
            burned     : 0,
        };
        let v6 = EventCreateCollection{
            nft_type : 0x1::type_name::get<T0>(),
            operator : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<EventCreateCollection>(v6);
        v5
    }

    fun deleteMetadata(arg0: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) {
        while (!0x2::vec_map::is_empty<0x1::string::String, 0x1::string::String>(&arg0)) {
            let (_, _) = 0x2::vec_map::pop<0x1::string::String, 0x1::string::String>(&mut arg0);
        };
        0x2::vec_map::destroy_empty<0x1::string::String, 0x1::string::String>(arg0);
    }

    fun init(arg0: NONFUNGIBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::package::claim<NONFUNGIBLE>(arg0, arg1),
        };
        0x2::transfer::transfer<Registry>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint<T0>(arg0: &mut NftCap<T0>, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Nft<T0> {
        assert!(0x1::option::is_none<u32>(&arg0.max_supply) || *0x1::option::borrow<u32>(&arg0.max_supply) > arg0.minted, 2);
        arg0.minted = arg0.minted + 1;
        let v0 = Nft<T0>{
            id           : 0x2::object::new(arg4),
            name         : arg1,
            token_id     : arg2,
            metadata_url : arg3,
            metadata     : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        let v1 = EventMint{
            nft_type     : 0x1::type_name::get<T0>(),
            nft_id       : 0x2::object::uid_to_inner(&v0.id),
            metadata_url : arg3,
            operator     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EventMint>(v1);
        v0
    }

    public fun mint_and_transfer<T0>(arg0: &mut NftCap<T0>, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<Nft<T0>>(mint<T0>(arg0, arg2, arg3, arg4, arg5), arg1);
    }

    public fun remove_metadata<T0>(arg0: &NftCap<T0>, arg1: &mut Nft<T0>, arg2: 0x1::string::String) {
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.metadata, &arg2);
    }

    public fun return_display<T0>(arg0: &mut NftCap<T0>, arg1: 0x2::display::Display<Nft<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::display::Display<Nft<T0>>>(&mut arg0.display, arg1, arg2);
    }

    public fun return_policy_cap<T0>(arg0: &mut NftCap<T0>, arg1: 0x2::transfer_policy::TransferPolicyCap<Nft<T0>>, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::transfer_policy::TransferPolicyCap<Nft<T0>>>(&mut arg0.policy_cap, arg1, arg2);
    }

    public fun return_publisher<T0>(arg0: &mut NftCap<T0>, arg1: 0x2::package::Publisher, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<0x2::package::Publisher>(&mut arg0.publisher, arg1, arg2);
    }

    public fun update_metadata<T0>(arg0: &NftCap<T0>, arg1: &mut Nft<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        let v0 = 0x2::vec_map::get_idx_opt<0x1::string::String, 0x1::string::String>(&arg1.metadata, &arg2);
        if (0x1::option::is_some<u64>(&v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.metadata, &arg2);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.metadata, arg2, arg3);
    }

    public fun update_metadata_url<T0>(arg0: &NftCap<T0>, arg1: &mut Nft<T0>, arg2: 0x1::string::String) {
        arg1.metadata_url = arg2;
    }

    public fun update_name<T0>(arg0: &NftCap<T0>, arg1: &mut Nft<T0>, arg2: 0x1::string::String) {
        arg1.name = arg2;
    }

    public fun update_token_id<T0>(arg0: &NftCap<T0>, arg1: &mut Nft<T0>, arg2: u64) {
        arg1.token_id = arg2;
    }

    // decompiled from Move bytecode v6
}

