module 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::braav_public {
    struct BRAAV_PUBLIC has drop {
        dummy_field: bool,
    }

    struct CreatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct BRAAV<phantom T0> has store, key {
        id: 0x2::object::UID,
        supply_limit: u64,
        minted_count: u64,
        counter: 0x2::object::ID,
    }

    struct NFT<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        coin_id: 0x1::string::String,
        mint_number: u64,
        issuer: address,
        timestamp: u64,
        restricted: bool,
        creatorname: 0x1::string::String,
        frontimageurl: 0x1::string::String,
        backimageurl: 0x1::string::String,
        currentuserid: 0x1::string::String,
        transferhistory: vector<address>,
        videourl: 0x1::string::String,
        verificationmethod: 0x1::string::String,
        shared_notes_id: 0x2::object::ID,
    }

    struct RestrictedNFT<phantom T0> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        coin_id: 0x1::string::String,
        mint_number: u64,
        issuer: address,
        timestamp: u64,
        restricted: bool,
        creatorname: 0x1::string::String,
        frontimageurl: 0x1::string::String,
        backimageurl: 0x1::string::String,
        currentuserid: 0x1::string::String,
        transferhistory: vector<address>,
        videourl: 0x1::string::String,
        verificationmethod: 0x1::string::String,
        shared_notes_id: 0x2::object::ID,
    }

    struct Note has drop, store {
        content: 0x1::string::String,
        author: address,
    }

    struct SharedNotes<phantom T0> has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        creator: address,
        current_owner: address,
        notes: vector<Note>,
    }

    struct CounterCreated has copy, drop {
        counter_id: 0x2::object::ID,
    }

    struct Multimedia<phantom T0> has key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        creator: address,
        metadata: 0x1::string::String,
        creatornotes: 0x1::string::String,
    }

    struct MultimediaCreated has copy, drop {
        nft_id: 0x2::object::ID,
        multimedia_id: 0x2::object::ID,
    }

    struct CreatorReassigned has copy, drop {
        object_id: 0x2::object::ID,
        previous_creator: address,
        new_creator: address,
    }

    struct SupplyRegistry has key {
        id: 0x2::object::UID,
        version: u16,
    }

    struct TypeClaimed<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct SupplyRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        version: u16,
    }

    struct TypeClaimedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        claimed_by: address,
        backfilled: bool,
    }

    public fun add_note<T0: drop>(arg0: &mut SharedNotes<T0>, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.creator || v0 == arg0.current_owner, 7);
        let v1 = Note{
            content : arg1,
            author  : v0,
        };
        0x1::vector::push_back<Note>(&mut arg0.notes, v1);
    }

    public fun admin_claim_type<T0>(arg0: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::cap::AdminCap, arg1: &mut SupplyRegistry, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::packages::version(), 11);
        let v0 = TypeClaimed<T0>{dummy_field: false};
        if (!0x2::dynamic_field::exists_<TypeClaimed<T0>>(&arg1.id, v0)) {
            let v1 = TypeClaimed<T0>{dummy_field: false};
            0x2::dynamic_field::add<TypeClaimed<T0>, bool>(&mut arg1.id, v1, true);
            let v2 = TypeClaimedEvent{
                registry_id : 0x2::object::id<SupplyRegistry>(arg1),
                claimed_by  : 0x2::tx_context::sender(arg2),
                backfilled  : true,
            };
            0x2::event::emit<TypeClaimedEvent>(v2);
        };
    }

    public fun admin_reassign_creator<T0: drop>(arg0: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::cap::AdminCap, arg1: &mut Multimedia<T0>, arg2: address, arg3: address) {
        assert!(arg3 != @0x0, 5);
        assert!(arg1.creator == arg2, 10);
        arg1.creator = arg3;
        let v0 = CreatorReassigned{
            object_id        : 0x2::object::id<Multimedia<T0>>(arg1),
            previous_creator : arg1.creator,
            new_creator      : arg3,
        };
        0x2::event::emit<CreatorReassigned>(v0);
    }

    public fun admin_reassign_notes_creator<T0: drop>(arg0: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::cap::AdminCap, arg1: &mut SharedNotes<T0>, arg2: address, arg3: address) {
        assert!(arg3 != @0x0, 5);
        assert!(arg1.creator == arg2, 10);
        arg1.creator = arg3;
        let v0 = CreatorReassigned{
            object_id        : 0x2::object::id<SharedNotes<T0>>(arg1),
            previous_creator : arg1.creator,
            new_creator      : arg3,
        };
        0x2::event::emit<CreatorReassigned>(v0);
    }

    public fun create_supply<T0>(arg0: &CreatorCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : BRAAV<T0> {
        abort 14
    }

    public fun create_supply_v2<T0>(arg0: &CreatorCap, arg1: &mut SupplyRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : BRAAV<T0> {
        assert!(arg1.version == 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::packages::version(), 11);
        let v0 = TypeClaimed<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<TypeClaimed<T0>>(&arg1.id, v0), 13);
        let v1 = TypeClaimed<T0>{dummy_field: false};
        0x2::dynamic_field::add<TypeClaimed<T0>, bool>(&mut arg1.id, v1, true);
        let v2 = TypeClaimedEvent{
            registry_id : 0x2::object::id<SupplyRegistry>(arg1),
            claimed_by  : 0x2::tx_context::sender(arg3),
            backfilled  : false,
        };
        0x2::event::emit<TypeClaimedEvent>(v2);
        let v3 = 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::new_internal(arg3);
        let v4 = 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::get_id(&v3);
        0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::add_field<T0>(&mut v3);
        let v5 = CounterCreated{counter_id: v4};
        0x2::event::emit<CounterCreated>(v5);
        0x2::transfer::public_transfer<0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::Counter>(v3, 0x2::tx_context::sender(arg3));
        BRAAV<T0>{
            id           : 0x2::object::new(arg3),
            supply_limit : arg2,
            minted_count : 0,
            counter      : v4,
        }
    }

    public fun edit_note<T0: drop>(arg0: &mut SharedNotes<T0>, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.creator || v0 == arg0.current_owner, 7);
        assert!(arg1 < 0x1::vector::length<Note>(&arg0.notes), 8);
        0x1::vector::borrow_mut<Note>(&mut arg0.notes, arg1).content = arg2;
    }

    public fun get_counter_id<T0>(arg0: &BRAAV<T0>) : 0x2::object::ID {
        arg0.counter
    }

    public fun get_minted_count<T0>(arg0: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::Counter) : u64 {
        0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::num_minted<T0>(arg0)
    }

    fun init(arg0: BRAAV_PUBLIC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BRAAV_PUBLIC>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_supply_registry(arg0: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SupplyRegistry{
            id      : 0x2::object::new(arg1),
            version : 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::packages::version(),
        };
        let v1 = SupplyRegistryCreated{
            registry_id : 0x2::object::id<SupplyRegistry>(&v0),
            version     : v0.version,
        };
        0x2::event::emit<SupplyRegistryCreated>(v1);
        0x2::transfer::share_object<SupplyRegistry>(v0);
    }

    public fun is_type_claimed<T0>(arg0: &SupplyRegistry) : bool {
        let v0 = TypeClaimed<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<TypeClaimed<T0>>(&arg0.id, v0)
    }

    public fun migrate_supply_registry(arg0: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::cap::AdminCap, arg1: &mut SupplyRegistry) {
        assert!(arg1.version < 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::packages::version(), 12);
        arg1.version = 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::packages::version();
    }

    public fun mint_and_transfer<T0: drop>(arg0: &CreatorCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut BRAAV<T0>, arg9: &mut 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::Counter, arg10: address, arg11: 0x1::string::String, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 != @0x0, 5);
        assert!(0x2::object::id<0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::Counter>(arg9) == arg8.counter, 5);
        let v0 = 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::num_minted<T0>(arg9);
        assert!(v0 < arg8.supply_limit, 3);
        0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::incr_counter<T0>(arg9);
        arg8.minted_count = arg8.minted_count + 1;
        let v1 = 0x2::object::new(arg13);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::tx_context::sender(arg13);
        let v4 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v4, arg10);
        let v5 = SharedNotes<T0>{
            id            : 0x2::object::new(arg13),
            nft_id        : v2,
            creator       : v3,
            current_owner : arg10,
            notes         : 0x1::vector::empty<Note>(),
        };
        0x2::transfer::share_object<SharedNotes<T0>>(v5);
        let v6 = Multimedia<T0>{
            id           : 0x2::object::new(arg13),
            nft_id       : v2,
            creator      : v3,
            metadata     : 0x1::string::utf8(b""),
            creatornotes : 0x1::string::utf8(b""),
        };
        0x2::transfer::share_object<Multimedia<T0>>(v6);
        let v7 = MultimediaCreated{
            nft_id        : v2,
            multimedia_id : 0x2::object::id<Multimedia<T0>>(&v6),
        };
        0x2::event::emit<MultimediaCreated>(v7);
        let v8 = NFT<T0>{
            id                 : v1,
            name               : arg1,
            coin_id            : arg2,
            mint_number        : v0 + 1,
            issuer             : v3,
            timestamp          : 0x2::clock::timestamp_ms(arg12),
            restricted         : false,
            creatorname        : arg3,
            frontimageurl      : arg4,
            backimageurl       : arg5,
            currentuserid      : arg11,
            transferhistory    : v4,
            videourl           : arg6,
            verificationmethod : arg7,
            shared_notes_id    : 0x2::object::id<SharedNotes<T0>>(&v5),
        };
        0x2::transfer::public_transfer<NFT<T0>>(v8, arg10);
    }

    public fun mint_creator_cap(arg0: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : CreatorCap {
        CreatorCap{id: 0x2::object::new(arg1)}
    }

    public fun mint_restricted<T0: drop>(arg0: &CreatorCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: &mut BRAAV<T0>, arg9: &mut 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::Counter, arg10: address, arg11: 0x1::string::String, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg10 != @0x0, 5);
        assert!(0x2::object::id<0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::Counter>(arg9) == arg8.counter, 5);
        let v0 = 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::num_minted<T0>(arg9);
        assert!(v0 < arg8.supply_limit, 3);
        0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::incr_counter<T0>(arg9);
        arg8.minted_count = arg8.minted_count + 1;
        let v1 = 0x2::object::new(arg13);
        let v2 = 0x2::object::uid_to_inner(&v1);
        let v3 = 0x2::tx_context::sender(arg13);
        let v4 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v4, arg10);
        let v5 = SharedNotes<T0>{
            id            : 0x2::object::new(arg13),
            nft_id        : v2,
            creator       : v3,
            current_owner : arg10,
            notes         : 0x1::vector::empty<Note>(),
        };
        0x2::transfer::share_object<SharedNotes<T0>>(v5);
        let v6 = Multimedia<T0>{
            id           : 0x2::object::new(arg13),
            nft_id       : v2,
            creator      : v3,
            metadata     : 0x1::string::utf8(b""),
            creatornotes : 0x1::string::utf8(b""),
        };
        0x2::transfer::share_object<Multimedia<T0>>(v6);
        let v7 = MultimediaCreated{
            nft_id        : v2,
            multimedia_id : 0x2::object::id<Multimedia<T0>>(&v6),
        };
        0x2::event::emit<MultimediaCreated>(v7);
        let v8 = RestrictedNFT<T0>{
            id                 : v1,
            name               : arg1,
            coin_id            : arg2,
            mint_number        : v0 + 1,
            issuer             : v3,
            timestamp          : 0x2::clock::timestamp_ms(arg12),
            restricted         : true,
            creatorname        : arg3,
            frontimageurl      : arg4,
            backimageurl       : arg5,
            currentuserid      : arg11,
            transferhistory    : v4,
            videourl           : arg6,
            verificationmethod : arg7,
            shared_notes_id    : 0x2::object::id<SharedNotes<T0>>(&v5),
        };
        0x2::transfer::transfer<RestrictedNFT<T0>>(v8, arg10);
    }

    public fun registry_version(arg0: &SupplyRegistry) : u16 {
        arg0.version
    }

    public fun transfer_nft<T0: drop>(arg0: NFT<T0>, arg1: address, arg2: &mut SharedNotes<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 5);
        assert!(0x2::object::id<SharedNotes<T0>>(arg2) == arg0.shared_notes_id, 6);
        assert!(arg2.nft_id == 0x2::object::id<NFT<T0>>(&arg0), 6);
        0x1::vector::push_back<address>(&mut arg0.transferhistory, arg1);
        arg2.current_owner = arg1;
        0x2::transfer::public_transfer<NFT<T0>>(arg0, arg1);
    }

    public fun transfer_restricted<T0: drop>(arg0: RestrictedNFT<T0>, arg1: address, arg2: &mut SharedNotes<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 5);
        assert!(0x2::object::id<SharedNotes<T0>>(arg2) == arg0.shared_notes_id, 6);
        assert!(arg2.nft_id == 0x2::object::id<RestrictedNFT<T0>>(&arg0), 6);
        0x1::vector::push_back<address>(&mut arg0.transferhistory, arg1);
        arg2.current_owner = arg1;
        0x2::transfer::transfer<RestrictedNFT<T0>>(arg0, arg1);
    }

    public fun update_creatornotes<T0: drop>(arg0: &mut Multimedia<T0>, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 7);
        arg0.creatornotes = arg1;
    }

    public fun update_multimedia<T0: drop>(arg0: &mut Multimedia<T0>, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 7);
        arg0.metadata = arg1;
    }

    public fun update_nft<T0: drop>(arg0: &mut NFT<T0>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String) {
        arg0.name = arg1;
        arg0.coin_id = arg2;
        arg0.creatorname = arg3;
        arg0.frontimageurl = arg4;
        arg0.backimageurl = arg5;
        arg0.videourl = arg6;
        arg0.verificationmethod = arg7;
    }

    public fun update_supply<T0>(arg0: &CreatorCap, arg1: &mut BRAAV<T0>, arg2: u64, arg3: &0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::Counter) {
        assert!(0x2::object::id<0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::Counter>(arg3) == arg1.counter, 5);
        assert!(arg2 >= 0x24715d0ea131b240bf7a244102c0e73f2db958c4076fff8fccc73af707f1919d::counter::num_minted<T0>(arg3), 4);
        arg1.supply_limit = arg2;
    }

    // decompiled from Move bytecode v6
}

