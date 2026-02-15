module 0x31671a3251141c579ab6a012ff7c97f2fd545358326e5d0a8b7dfbab3632e5dc::ticket {
    struct Ticket has store, key {
        id: 0x2::object::UID,
        share_id: 0x2::object::ID,
        share_size: u64,
        identity_hash: vector<u8>,
        sender: address,
        blob_id: vector<u8>,
        wrapped_key: vector<u8>,
        encrypted_metadata: vector<u8>,
        file_size: u64,
        expires_at: u64,
        created_at: u64,
    }

    struct ShareCreated has copy, drop {
        share_id: 0x2::object::ID,
        sender: address,
        ticket_ids: vector<0x2::object::ID>,
        identity_hashes: vector<vector<u8>>,
        blob_id: vector<u8>,
        file_size: u64,
        expires_at: u64,
    }

    struct ShareRevoked has copy, drop {
        share_id: 0x2::object::ID,
        sender: address,
        ticket_ids: vector<0x2::object::ID>,
    }

    struct ShareCleanedUp has copy, drop {
        share_id: 0x2::object::ID,
        sender: address,
        ticket_ids: vector<0x2::object::ID>,
    }

    public fun sender(arg0: &Ticket) : address {
        arg0.sender
    }

    public fun blob_id(arg0: &Ticket) : &vector<u8> {
        &arg0.blob_id
    }

    public fun cleanup_expired_share(arg0: vector<Ticket>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Ticket>(&arg0);
        assert!(v0 > 0, 15);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x1::vector::borrow<Ticket>(&arg0, 0);
        let v3 = v2.share_id;
        assert!(v0 == v2.share_size, 18);
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<Ticket>(&arg0)) {
            let v5 = 0x1::vector::pop_back<Ticket>(&mut arg0);
            assert!(v5.sender == v1, 2);
            assert!(v5.share_id == v3, 17);
            assert!(0x2::clock::timestamp_ms(arg1) >= v5.expires_at, 12);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<Ticket>(&v5));
            let Ticket {
                id                 : v6,
                share_id           : _,
                share_size         : _,
                identity_hash      : _,
                sender             : _,
                blob_id            : _,
                wrapped_key        : _,
                encrypted_metadata : _,
                file_size          : _,
                expires_at         : _,
                created_at         : _,
            } = v5;
            0x2::object::delete(v6);
        };
        0x1::vector::destroy_empty<Ticket>(arg0);
        let v17 = ShareCleanedUp{
            share_id   : v3,
            sender     : v1,
            ticket_ids : v4,
        };
        0x2::event::emit<ShareCleanedUp>(v17);
    }

    public fun create_share(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(&arg0);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(0x1::vector::length<vector<u8>>(&arg0) == 0x1::vector::length<vector<u8>>(&arg2), 14);
        assert!(v0 > 0, 15);
        assert!(v0 <= 50, 16);
        let v2 = 0x2::tx_context::sender(arg8);
        let v3 = 10000000 * v0;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= v3, 13);
        if (0x2::coin::value<0x2::sui::SUI>(&arg7) == v3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, @0x129da6059e8efde573c5ae5864cbc3a86ed455728533e6eae2e4df500c238c8d);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg7, v3, arg8), @0x129da6059e8efde573c5ae5864cbc3a86ed455728533e6eae2e4df500c238c8d);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, v2);
        };
        assert!(!0x1::vector::is_empty<u8>(&arg1), 9);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 19);
        assert!(arg5 > v1, 4);
        let v4 = arg5 - v1;
        assert!(v4 >= 3600000, 8);
        assert!(v4 <= 31536000000, 7);
        let v5 = 0x2::object::id_from_address(0x2::tx_context::fresh_object_address(arg8));
        let v6 = 0x1::vector::empty<0x2::object::ID>();
        let v7 = 0;
        while (v7 < v0) {
            let v8 = *0x1::vector::borrow<vector<u8>>(&arg0, v7);
            let v9 = *0x1::vector::borrow<vector<u8>>(&arg2, v7);
            assert!(0x1::vector::length<u8>(&v8) == 32, 3);
            assert!(!0x1::vector::is_empty<u8>(&v9), 10);
            let v10 = Ticket{
                id                 : 0x2::object::new(arg8),
                share_id           : v5,
                share_size         : v0,
                identity_hash      : v8,
                sender             : v2,
                blob_id            : arg1,
                wrapped_key        : v9,
                encrypted_metadata : arg3,
                file_size          : arg4,
                expires_at         : arg5,
                created_at         : v1,
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v6, 0x2::object::id<Ticket>(&v10));
            0x2::transfer::share_object<Ticket>(v10);
            v7 = v7 + 1;
        };
        let v11 = ShareCreated{
            share_id        : v5,
            sender          : v2,
            ticket_ids      : v6,
            identity_hashes : arg0,
            blob_id         : arg1,
            file_size       : arg4,
            expires_at      : arg5,
        };
        0x2::event::emit<ShareCreated>(v11);
    }

    public fun created_at(arg0: &Ticket) : u64 {
        arg0.created_at
    }

    public fun encrypted_metadata(arg0: &Ticket) : &vector<u8> {
        &arg0.encrypted_metadata
    }

    public fun expires_at(arg0: &Ticket) : u64 {
        arg0.expires_at
    }

    public fun file_size(arg0: &Ticket) : u64 {
        arg0.file_size
    }

    public fun get_dev_fee_amount() : u64 {
        10000000
    }

    public fun get_dev_wallet() : address {
        @0x129da6059e8efde573c5ae5864cbc3a86ed455728533e6eae2e4df500c238c8d
    }

    public fun get_max_batch_size() : u64 {
        50
    }

    public fun identity_hash(arg0: &Ticket) : &vector<u8> {
        &arg0.identity_hash
    }

    public fun is_claimable(arg0: &Ticket, arg1: &0x2::clock::Clock) : bool {
        !is_expired(arg0, arg1)
    }

    public fun is_expired(arg0: &Ticket, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expires_at
    }

    public fun revoke_share(arg0: vector<Ticket>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<Ticket>(&arg0);
        assert!(v0 > 0, 15);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = 0x1::vector::borrow<Ticket>(&arg0, 0);
        let v3 = v2.share_id;
        assert!(v0 == v2.share_size, 18);
        let v4 = 0x1::vector::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<Ticket>(&arg0)) {
            let v5 = 0x1::vector::pop_back<Ticket>(&mut arg0);
            assert!(v5.sender == v1, 2);
            assert!(v5.share_id == v3, 17);
            0x1::vector::push_back<0x2::object::ID>(&mut v4, 0x2::object::id<Ticket>(&v5));
            let Ticket {
                id                 : v6,
                share_id           : _,
                share_size         : _,
                identity_hash      : _,
                sender             : _,
                blob_id            : _,
                wrapped_key        : _,
                encrypted_metadata : _,
                file_size          : _,
                expires_at         : _,
                created_at         : _,
            } = v5;
            0x2::object::delete(v6);
        };
        0x1::vector::destroy_empty<Ticket>(arg0);
        let v17 = ShareRevoked{
            share_id   : v3,
            sender     : v1,
            ticket_ids : v4,
        };
        0x2::event::emit<ShareRevoked>(v17);
    }

    public fun share_id(arg0: &Ticket) : 0x2::object::ID {
        arg0.share_id
    }

    public fun share_size(arg0: &Ticket) : u64 {
        arg0.share_size
    }

    public fun wrapped_key(arg0: &Ticket) : &vector<u8> {
        &arg0.wrapped_key
    }

    // decompiled from Move bytecode v6
}

