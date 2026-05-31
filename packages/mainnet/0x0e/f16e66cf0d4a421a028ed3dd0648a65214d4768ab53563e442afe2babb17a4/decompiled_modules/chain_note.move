module 0xef16e66cf0d4a421a028ed3dd0648a65214d4768ab53563e442afe2babb17a4::chain_note {
    struct Chain has store, key {
        id: 0x2::object::UID,
        author: address,
        created_ms: u64,
        updated_ms: u64,
        locked: bool,
        next_index: u64,
        title: 0x1::string::String,
        order: vector<0x2::object::ID>,
    }

    struct Fragment has store, key {
        id: 0x2::object::UID,
        chain_id: 0x2::object::ID,
        author: address,
        index: u64,
        created_ms: u64,
        updated_ms: u64,
        text: 0x1::string::String,
    }

    struct PublishedChain has store, key {
        id: 0x2::object::UID,
        source_chain_id: 0x2::object::ID,
        author: address,
        title: 0x1::string::String,
        created_ms: u64,
        published_ms: u64,
        fragment_count: u64,
        fragment_ids: vector<0x2::object::ID>,
    }

    struct PublishedFragment has store, key {
        id: 0x2::object::UID,
        source_chain_id: 0x2::object::ID,
        source_fragment_id: 0x2::object::ID,
        author: address,
        pos: u64,
        original_index: u64,
        created_ms: u64,
        published_ms: u64,
        text: 0x1::string::String,
    }

    struct MintedFragment has store, key {
        id: 0x2::object::UID,
        published_fragment_id: 0x2::object::ID,
        source_chain_id: 0x2::object::ID,
        source_fragment_id: 0x2::object::ID,
        author: address,
        minter: address,
        pos: u64,
        minted_ms: u64,
        text: 0x1::string::String,
    }

    public fun add_fragment(arg0: &mut Chain, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.locked, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = Fragment{
            id         : 0x2::object::new(arg3),
            chain_id   : 0x2::object::id<Chain>(arg0),
            author     : v0,
            index      : arg0.next_index,
            created_ms : v1,
            updated_ms : v1,
            text       : arg1,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.order, 0x2::object::id<Fragment>(&v2));
        arg0.next_index = arg0.next_index + 1;
        arg0.updated_ms = v1;
        0x2::transfer::public_transfer<Fragment>(v2, v0);
    }

    public fun burn_chain_empty(arg0: Chain) {
        assert!(!arg0.locked, 1);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.order) == 0, 5);
        let Chain {
            id         : v0,
            author     : _,
            created_ms : _,
            updated_ms : _,
            locked     : _,
            next_index : _,
            title      : _,
            order      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_chain(arg0: 0x1::string::String, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = Chain{
            id         : 0x2::object::new(arg2),
            author     : v0,
            created_ms : v1,
            updated_ms : v1,
            locked     : false,
            next_index : 0,
            title      : arg0,
            order      : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::public_transfer<Chain>(v2, v0);
    }

    public fun edit_fragment(arg0: &mut Chain, arg1: &mut Fragment, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        assert!(!arg0.locked, 1);
        assert!(arg1.chain_id == 0x2::object::id<Chain>(arg0), 3);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.text = arg2;
        arg1.updated_ms = v0;
        arg0.updated_ms = v0;
    }

    public fun lock_chain(arg0: &mut Chain, arg1: &0x2::clock::Clock) {
        assert!(!arg0.locked, 1);
        arg0.locked = true;
        arg0.updated_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public fun mint_fragment(arg0: &PublishedFragment, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MintedFragment{
            id                    : 0x2::object::new(arg3),
            published_fragment_id : 0x2::object::id<PublishedFragment>(arg0),
            source_chain_id       : arg0.source_chain_id,
            source_fragment_id    : arg0.source_fragment_id,
            author                : arg0.author,
            minter                : 0x2::tx_context::sender(arg3),
            pos                   : arg0.pos,
            minted_ms             : 0x2::clock::timestamp_ms(arg2),
            text                  : arg0.text,
        };
        0x2::transfer::public_transfer<MintedFragment>(v0, arg1);
    }

    public fun move_fragment(arg0: &mut Chain, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(!arg0.locked, 1);
        let v0 = 0x1::vector::length<0x2::object::ID>(&arg0.order);
        assert!(arg1 < v0, 4);
        assert!(arg2 < v0, 4);
        0x1::vector::insert<0x2::object::ID>(&mut arg0.order, 0x1::vector::remove<0x2::object::ID>(&mut arg0.order, arg1), arg2);
        arg0.updated_ms = 0x2::clock::timestamp_ms(arg3);
    }

    public fun publish_all(arg0: Chain, arg1: vector<Fragment>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Chain>(&arg0);
        let Chain {
            id         : v1,
            author     : v2,
            created_ms : v3,
            updated_ms : _,
            locked     : v5,
            next_index : _,
            title      : v7,
            order      : v8,
        } = arg0;
        let v9 = v8;
        assert!(v5, 2);
        let v10 = 0x2::clock::timestamp_ms(arg2);
        let v11 = 0x1::vector::length<Fragment>(&arg1);
        assert!(v11 == 0x1::vector::length<0x2::object::ID>(&v9), 5);
        let v12 = 0;
        let v13 = 0x1::vector::empty<0x2::object::ID>();
        while (v12 < v11) {
            let v14 = 0x1::vector::remove<Fragment>(&mut arg1, 0);
            assert!(v14.chain_id == v0, 3);
            let v15 = 0x2::object::id<Fragment>(&v14);
            assert!(v15 == *0x1::vector::borrow<0x2::object::ID>(&v9, v12), 5);
            let Fragment {
                id         : v16,
                chain_id   : _,
                author     : v18,
                index      : v19,
                created_ms : v20,
                updated_ms : _,
                text       : v22,
            } = v14;
            assert!(v18 == v2, 3);
            let v23 = PublishedFragment{
                id                 : 0x2::object::new(arg3),
                source_chain_id    : v0,
                source_fragment_id : v15,
                author             : v2,
                pos                : v12,
                original_index     : v19,
                created_ms         : v20,
                published_ms       : v10,
                text               : v22,
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v13, 0x2::object::id<PublishedFragment>(&v23));
            0x2::object::delete(v16);
            0x2::transfer::freeze_object<PublishedFragment>(v23);
            v12 = v12 + 1;
        };
        0x1::vector::destroy_empty<Fragment>(arg1);
        let v24 = PublishedChain{
            id              : 0x2::object::new(arg3),
            source_chain_id : v0,
            author          : v2,
            title           : v7,
            created_ms      : v3,
            published_ms    : v10,
            fragment_count  : v11,
            fragment_ids    : v13,
        };
        0x2::object::delete(v1);
        0x2::transfer::freeze_object<PublishedChain>(v24);
    }

    public fun remove_fragment(arg0: &mut Chain, arg1: Fragment, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(!arg0.locked, 1);
        assert!(arg1.chain_id == 0x2::object::id<Chain>(arg0), 3);
        let v0 = 0x2::object::id<Fragment>(&arg1);
        assert!(arg2 < 0x1::vector::length<0x2::object::ID>(&arg0.order), 4);
        assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0.order, arg2) == v0, 5);
        assert!(0x1::vector::remove<0x2::object::ID>(&mut arg0.order, arg2) == v0, 5);
        let Fragment {
            id         : v1,
            chain_id   : _,
            author     : _,
            index      : _,
            created_ms : _,
            updated_ms : _,
            text       : _,
        } = arg1;
        0x2::object::delete(v1);
        arg0.updated_ms = 0x2::clock::timestamp_ms(arg3);
    }

    // decompiled from Move bytecode v7
}

