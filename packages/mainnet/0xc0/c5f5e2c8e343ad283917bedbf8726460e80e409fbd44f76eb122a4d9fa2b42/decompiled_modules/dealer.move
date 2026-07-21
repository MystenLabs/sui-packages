module 0xc0c5f5e2c8e343ad283917bedbf8726460e80e409fbd44f76eb122a4d9fa2b42::dealer {
    struct HouseCap has store, key {
        id: 0x2::object::UID,
        house: address,
    }

    struct Enclave has key {
        id: 0x2::object::UID,
        house: address,
        pubkey: vector<u8>,
    }

    struct HandDeal has key {
        id: 0x2::object::UID,
        table_id: vector<u8>,
        deck_commitment: vector<u8>,
        revealed: bool,
        revealed_deck: vector<u8>,
    }

    struct EnclaveRegistered has copy, drop {
        enclave: 0x2::object::ID,
        pubkey: vector<u8>,
    }

    struct DealCommitted has copy, drop {
        deal: 0x2::object::ID,
        table_id: vector<u8>,
        deck_commitment: vector<u8>,
    }

    struct DealRevealed has copy, drop {
        deal: 0x2::object::ID,
        table_id: vector<u8>,
    }

    public fun commit_deal(arg0: &Enclave, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.pubkey, &arg2), 1);
        let v0 = HandDeal{
            id              : 0x2::object::new(arg4),
            table_id        : arg1,
            deck_commitment : arg2,
            revealed        : false,
            revealed_deck   : b"",
        };
        let v1 = DealCommitted{
            deal            : 0x2::object::id<HandDeal>(&v0),
            table_id        : v0.table_id,
            deck_commitment : v0.deck_commitment,
        };
        0x2::event::emit<DealCommitted>(v1);
        0x2::transfer::share_object<HandDeal>(v0);
    }

    public fun deck_commitment(arg0: &HandDeal) : vector<u8> {
        arg0.deck_commitment
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HouseCap{
            id    : 0x2::object::new(arg0),
            house : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_transfer<HouseCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_revealed(arg0: &HandDeal) : bool {
        arg0.revealed
    }

    public fun pubkey(arg0: &Enclave) : vector<u8> {
        arg0.pubkey
    }

    public fun register_enclave(arg0: &HouseCap, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.house == 0x2::tx_context::sender(arg2), 0);
        let v0 = Enclave{
            id     : 0x2::object::new(arg2),
            house  : arg0.house,
            pubkey : arg1,
        };
        let v1 = EnclaveRegistered{
            enclave : 0x2::object::id<Enclave>(&v0),
            pubkey  : v0.pubkey,
        };
        0x2::event::emit<EnclaveRegistered>(v1);
        0x2::transfer::share_object<Enclave>(v0);
    }

    public fun reveal_deal(arg0: &mut HandDeal, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.revealed, 2);
        0x1::vector::append<u8>(&mut arg1, arg2);
        assert!(0x1::hash::sha2_256(arg1) == arg0.deck_commitment, 3);
        arg0.revealed = true;
        arg0.revealed_deck = arg1;
        let v0 = DealRevealed{
            deal     : 0x2::object::id<HandDeal>(arg0),
            table_id : arg0.table_id,
        };
        0x2::event::emit<DealRevealed>(v0);
    }

    public fun revealed_deck(arg0: &HandDeal) : vector<u8> {
        arg0.revealed_deck
    }

    // decompiled from Move bytecode v7
}

