module 0xb2b30e98a327044f6583a913df043518585521d6d30f6f666702c0735ea5ec20::voting {
    struct VOTING has drop {
        dummy_field: bool,
    }

    struct EncryptedVote has copy, drop, store {
        iv: vector<u8>,
        ephemeral_pub_key: vector<u8>,
        ciphertext: vector<u8>,
        mac: vector<u8>,
    }

    struct Vote has key {
        id: 0x2::object::UID,
        vote_encrypted: EncryptedVote,
        voted_at: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Results has store {
        defi: 0x1::string::String,
        infra_tooling: 0x1::string::String,
        ai: 0x1::string::String,
        cryptography: 0x1::string::String,
        degen: 0x1::string::String,
        payments_wallets: 0x1::string::String,
        entertainment_culture: 0x1::string::String,
        explorations: 0x1::string::String,
        programmable_storage: 0x1::string::String,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        voters: 0x2::table::Table<address, bool>,
        ballots: 0x2::table::Table<address, EncryptedVote>,
        operator: address,
        encryption_public_key: vector<u8>,
        encryption_private_key: vector<u8>,
        voting_end_date: u64,
        results: Results,
    }

    public fun add_voters(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg2), 101);
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (!0x2::table::contains<address, bool>(&arg0.voters, v1)) {
                0x2::table::add<address, bool>(&mut arg0.voters, v1, false);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public fun assign_operator(arg0: &mut Registry, arg1: address, arg2: &AdminCap) {
        arg0.operator = arg1;
    }

    public fun has_voted(arg0: &Registry, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, bool>(&arg0.voters, v0)) {
            return *0x2::table::borrow<address, bool>(&arg0.voters, v0)
        };
        false
    }

    fun init(arg0: VOTING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VOTING>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"My Overflow 2025 Vote"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"This is my encrypted vote for the Overflow 2025 tracks"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://raw.githubusercontent.com/sui-foundation/VotingOverflow2025/refs/heads/main/frontend/public/display.png?token=GHSAT0AAAAAADBRYCSZORO5TE3TJAVJFXSI2B5K2KQ"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Sui Foundation Dev Rel"));
        let v5 = 0x2::display::new_with_fields<Vote>(&v0, v1, v3, arg1);
        0x2::display::update_version<Vote>(&mut v5);
        let v6 = Results{
            defi                  : 0x1::string::utf8(b""),
            infra_tooling         : 0x1::string::utf8(b""),
            ai                    : 0x1::string::utf8(b""),
            cryptography          : 0x1::string::utf8(b""),
            degen                 : 0x1::string::utf8(b""),
            payments_wallets      : 0x1::string::utf8(b""),
            entertainment_culture : 0x1::string::utf8(b""),
            explorations          : 0x1::string::utf8(b""),
            programmable_storage  : 0x1::string::utf8(b""),
        };
        let v7 = Registry{
            id                     : 0x2::object::new(arg1),
            voters                 : 0x2::table::new<address, bool>(arg1),
            ballots                : 0x2::table::new<address, EncryptedVote>(arg1),
            operator               : 0x2::tx_context::sender(arg1),
            encryption_public_key  : b"",
            encryption_private_key : b"",
            voting_end_date        : 1750453200000,
            results                : v6,
        };
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Vote>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Registry>(v7);
    }

    public fun is_eligible(arg0: &Registry, arg1: &0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::tx_context::sender(arg1);
        if (0x2::table::contains<address, bool>(&arg0.voters, v0)) {
            if (*0x2::table::borrow<address, bool>(&arg0.voters, v0)) {
                return 1
            };
            return 2
        };
        0
    }

    public fun publish_results(arg0: &mut Registry, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: &0x2::clock::Clock, arg11: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg11), 101);
        assert!(arg0.voting_end_date <= 0x2::clock::timestamp_ms(arg10), 202);
        arg0.results.defi = arg1;
        arg0.results.infra_tooling = arg2;
        arg0.results.ai = arg3;
        arg0.results.cryptography = arg4;
        arg0.results.degen = arg5;
        arg0.results.payments_wallets = arg6;
        arg0.results.entertainment_culture = arg7;
        arg0.results.explorations = arg8;
        arg0.results.programmable_storage = arg9;
    }

    public fun remove_voters(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg2), 101);
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (0x2::table::contains<address, bool>(&arg0.voters, v1)) {
                0x2::table::remove<address, bool>(&mut arg0.voters, v1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public fun remove_votes(arg0: &mut Registry, arg1: vector<address>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg2), 101);
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg1);
            if (0x2::table::contains<address, bool>(&arg0.voters, v1)) {
                0x2::table::remove<address, EncryptedVote>(&mut arg0.ballots, v1);
            };
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public fun set_end_date(arg0: &mut Registry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg2), 101);
        arg0.voting_end_date = arg1;
    }

    public fun set_private_key(arg0: &mut Registry, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg3), 101);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.voting_end_date, 201);
        arg0.encryption_private_key = arg1;
    }

    public fun set_public_key(arg0: &mut Registry, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.operator == 0x2::tx_context::sender(arg2), 101);
        arg0.encryption_public_key = arg1;
    }

    public fun vote(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg0.voting_end_date, 104);
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::table::contains<address, bool>(&arg0.voters, v0), 103);
        assert!(!*0x2::table::borrow<address, bool>(&arg0.voters, v0), 102);
        *0x2::table::borrow_mut<address, bool>(&mut arg0.voters, v0) = true;
        let v1 = EncryptedVote{
            iv                : arg1,
            ephemeral_pub_key : arg2,
            ciphertext        : arg3,
            mac               : arg4,
        };
        0x2::table::add<address, EncryptedVote>(&mut arg0.ballots, v0, v1);
        let v2 = Vote{
            id             : 0x2::object::new(arg6),
            vote_encrypted : v1,
            voted_at       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::transfer::transfer<Vote>(v2, v0);
    }

    // decompiled from Move bytecode v6
}

