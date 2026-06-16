module 0xc35fd63d33718dd59103cad5a323e0040a13dfa8d3e52b417d1e0544d54278bc::reward {
    struct Reward has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        round: u64,
        reward_type: u8,
        total_tickets: u64,
        amount: u64,
        merkle_root: vector<u8>,
        vrf_input: vector<u8>,
        secret_hash: vector<u8>,
        vrf_pubkey: vector<u8>,
        committed_at_ms: u64,
        expired: bool,
        revealed: bool,
        secret_seed: vector<u8>,
        vrf_output: vector<u8>,
        vrf_proof: vector<u8>,
        winner_index: u64,
        claimer: address,
        claimed: bool,
    }

    public fun id(arg0: &Reward) : 0x2::object::ID {
        0x2::object::id<Reward>(arg0)
    }

    public(friend) fun new(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Reward {
        assert!(arg3 > 0, 24);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 36);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 21);
        assert!(0x1::vector::length<u8>(&arg8) == 32, 20);
        Reward{
            id              : 0x2::object::new(arg10),
            vault_id        : arg0,
            round           : arg1,
            reward_type     : arg2,
            total_tickets   : arg3,
            amount          : arg4,
            merkle_root     : arg5,
            vrf_input       : arg6,
            secret_hash     : arg7,
            vrf_pubkey      : arg8,
            committed_at_ms : arg9,
            expired         : false,
            revealed        : false,
            secret_seed     : b"",
            vrf_output      : b"",
            vrf_proof       : b"",
            winner_index    : 0,
            claimer         : @0x0,
            claimed         : false,
        }
    }

    public fun amount(arg0: &Reward) : u64 {
        arg0.amount
    }

    public(friend) fun assert_claimer(arg0: &Reward, arg1: address) {
        assert!(arg0.claimer == arg1, 28);
    }

    public(friend) fun assert_expiry_elapsed(arg0: &Reward, arg1: u64, arg2: u64) {
        assert!(arg1 >= arg0.committed_at_ms + arg2, 38);
    }

    public(friend) fun assert_merkle_ok(arg0: bool) {
        assert!(arg0, 35);
    }

    public(friend) fun assert_not_expired(arg0: &Reward) {
        assert!(!arg0.expired, 37);
    }

    public(friend) fun assert_not_revealed(arg0: &Reward) {
        assert!(!arg0.revealed, 25);
    }

    public(friend) fun assert_revealed(arg0: &Reward) {
        assert!(arg0.revealed, 29);
    }

    public(friend) fun assert_secret_matches(arg0: &Reward, arg1: &vector<u8>) {
        assert!(*arg1 == arg0.secret_hash, 26);
    }

    public(friend) fun assert_unclaimed(arg0: &Reward) {
        assert!(!arg0.claimed, 30);
    }

    public(friend) fun assert_vault(arg0: &Reward, arg1: 0x2::object::ID) {
        assert!(arg0.vault_id == arg1, 31);
    }

    public(friend) fun assert_vrf_valid(arg0: bool) {
        assert!(arg0, 27);
    }

    public(friend) fun assert_winner_range(arg0: &Reward, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg2 > 0, 32);
        let v0 = arg1 + arg2;
        assert!(v0 <= arg0.total_tickets, 33);
        assert!(arg3 >= arg1 && arg3 < v0, 34);
    }

    public fun claimed(arg0: &Reward) : bool {
        arg0.claimed
    }

    public fun claimer(arg0: &Reward) : address {
        arg0.claimer
    }

    public fun committed_at_ms(arg0: &Reward) : u64 {
        arg0.committed_at_ms
    }

    public fun expired(arg0: &Reward) : bool {
        arg0.expired
    }

    public(friend) fun mark_claimed(arg0: &mut Reward) {
        arg0.claimed = true;
    }

    public(friend) fun mark_expired(arg0: &mut Reward) {
        arg0.expired = true;
    }

    public(friend) fun mark_revealed(arg0: &mut Reward, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: address) {
        arg0.revealed = true;
        arg0.secret_seed = arg1;
        arg0.vrf_output = arg2;
        arg0.vrf_proof = arg3;
        arg0.winner_index = arg4;
        arg0.claimer = arg5;
    }

    public fun merkle_root(arg0: &Reward) : &vector<u8> {
        &arg0.merkle_root
    }

    public fun revealed(arg0: &Reward) : bool {
        arg0.revealed
    }

    public fun reward_type(arg0: &Reward) : u8 {
        arg0.reward_type
    }

    public fun round(arg0: &Reward) : u64 {
        arg0.round
    }

    public fun secret_hash(arg0: &Reward) : &vector<u8> {
        &arg0.secret_hash
    }

    public fun secret_seed(arg0: &Reward) : &vector<u8> {
        &arg0.secret_seed
    }

    public(friend) fun share(arg0: Reward) {
        0x2::transfer::share_object<Reward>(arg0);
    }

    public fun total_tickets(arg0: &Reward) : u64 {
        arg0.total_tickets
    }

    public(friend) fun validate_vrf_lengths(arg0: &vector<u8>, arg1: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 64, 22);
        assert!(0x1::vector::length<u8>(arg1) == 80, 23);
    }

    public fun vault_id(arg0: &Reward) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun vrf_input(arg0: &Reward) : &vector<u8> {
        &arg0.vrf_input
    }

    public fun vrf_output(arg0: &Reward) : &vector<u8> {
        &arg0.vrf_output
    }

    public fun vrf_proof(arg0: &Reward) : &vector<u8> {
        &arg0.vrf_proof
    }

    public fun vrf_pubkey(arg0: &Reward) : &vector<u8> {
        &arg0.vrf_pubkey
    }

    public fun winner_index(arg0: &Reward) : u64 {
        arg0.winner_index
    }

    // decompiled from Move bytecode v7
}

