module 0x26f677a39b84d77d420c89e6a016a59420ab27606a3b5255db8144be3901d359::ticket {
    struct Stats has key {
        id: 0x2::object::UID,
        total_files: u64,
        total_bytes: u64,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        identity_hash: vector<u8>,
        sender: address,
        blob_id: vector<u8>,
        wrapped_key: vector<u8>,
        encrypted_metadata: vector<u8>,
        file_size: u64,
        expires_at: u64,
        created_at: u64,
    }

    struct TicketCreated has copy, drop {
        ticket_id: 0x2::object::ID,
        sender: address,
        identity_hash: vector<u8>,
        expires_at: u64,
    }

    struct TicketRevoked has copy, drop {
        ticket_id: 0x2::object::ID,
        sender: address,
    }

    struct TicketCleanedUp has copy, drop {
        ticket_id: 0x2::object::ID,
        sender: address,
    }

    public fun sender(arg0: &Ticket) : address {
        arg0.sender
    }

    public fun blob_id(arg0: &Ticket) : &vector<u8> {
        &arg0.blob_id
    }

    public fun cleanup_expired(arg0: Ticket, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.expires_at, 12);
        let Ticket {
            id                 : v0,
            identity_hash      : _,
            sender             : _,
            blob_id            : _,
            wrapped_key        : _,
            encrypted_metadata : _,
            file_size          : _,
            expires_at         : _,
            created_at         : _,
        } = arg0;
        let v9 = TicketCleanedUp{
            ticket_id : 0x2::object::id<Ticket>(&arg0),
            sender    : arg0.sender,
        };
        0x2::event::emit<TicketCleanedUp>(v9);
        0x2::object::delete(v0);
    }

    public fun create_ticket(arg0: &mut Stats, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg7);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg8) >= 30000000, 13);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg8, @0x129da6059e8efde573c5ae5864cbc3a86ed455728533e6eae2e4df500c238c8d);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 3);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 9);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 10);
        assert!(arg6 > v0, 4);
        let v1 = arg6 - v0;
        assert!(v1 >= 1800000, 8);
        assert!(v1 <= 31536000000, 7);
        arg0.total_files = arg0.total_files + 1;
        arg0.total_bytes = arg0.total_bytes + arg5;
        let v2 = Ticket{
            id                 : 0x2::object::new(arg9),
            identity_hash      : arg1,
            sender             : 0x2::tx_context::sender(arg9),
            blob_id            : arg2,
            wrapped_key        : arg3,
            encrypted_metadata : arg4,
            file_size          : arg5,
            expires_at         : arg6,
            created_at         : v0,
        };
        let v3 = TicketCreated{
            ticket_id     : 0x2::object::id<Ticket>(&v2),
            sender        : 0x2::tx_context::sender(arg9),
            identity_hash : v2.identity_hash,
            expires_at    : arg6,
        };
        0x2::event::emit<TicketCreated>(v3);
        0x2::transfer::share_object<Ticket>(v2);
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
        30000000
    }

    public fun get_dev_wallet() : address {
        @0x129da6059e8efde573c5ae5864cbc3a86ed455728533e6eae2e4df500c238c8d
    }

    public fun get_stats(arg0: &Stats) : (u64, u64) {
        (arg0.total_files, arg0.total_bytes)
    }

    public fun identity_hash(arg0: &Ticket) : &vector<u8> {
        &arg0.identity_hash
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Stats{
            id          : 0x2::object::new(arg0),
            total_files : 0,
            total_bytes : 0,
        };
        0x2::transfer::share_object<Stats>(v0);
    }

    public fun is_claimable(arg0: &Ticket, arg1: &0x2::clock::Clock) : bool {
        !is_expired(arg0, arg1)
    }

    public fun is_expired(arg0: &Ticket, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.expires_at
    }

    public fun revoke_ticket(arg0: Ticket, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.sender == 0x2::tx_context::sender(arg1), 2);
        let Ticket {
            id                 : v0,
            identity_hash      : _,
            sender             : _,
            blob_id            : _,
            wrapped_key        : _,
            encrypted_metadata : _,
            file_size          : _,
            expires_at         : _,
            created_at         : _,
        } = arg0;
        let v9 = TicketRevoked{
            ticket_id : 0x2::object::id<Ticket>(&arg0),
            sender    : arg0.sender,
        };
        0x2::event::emit<TicketRevoked>(v9);
        0x2::object::delete(v0);
    }

    public fun total_bytes(arg0: &Stats) : u64 {
        arg0.total_bytes
    }

    public fun total_files(arg0: &Stats) : u64 {
        arg0.total_files
    }

    public fun wrapped_key(arg0: &Ticket) : &vector<u8> {
        &arg0.wrapped_key
    }

    // decompiled from Move bytecode v6
}

