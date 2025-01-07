module 0x7680bd31027b28f18876c848a44e908ec81272ad330516a2166a9225be6f6cc0::miner {
    struct Miner has store, key {
        id: 0x2::object::UID,
        current_hash: vector<u8>,
        total_rewards: u64,
        total_hashes: u64,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : Miner {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::tx_context::sender(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v1));
        let v2 = 0x2::tx_context::fresh_object_address(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&v2));
        Miner{
            id            : 0x2::object::new(arg0),
            current_hash  : 0x2::hash::keccak256(&v0),
            total_rewards : 0,
            total_hashes  : 0,
        }
    }

    public fun current_hash(arg0: &Miner) : vector<u8> {
        arg0.current_hash
    }

    public(friend) fun current_hash_mut(arg0: &mut Miner) : &mut vector<u8> {
        &mut arg0.current_hash
    }

    public fun destroy(arg0: Miner) {
        let Miner {
            id            : v0,
            current_hash  : _,
            total_rewards : _,
            total_hashes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun record_hash(arg0: &mut Miner) {
        arg0.total_hashes = arg0.total_hashes + 1;
    }

    public(friend) fun record_rewards(arg0: &mut Miner, arg1: u64) {
        arg0.total_rewards = arg0.total_rewards + arg1;
    }

    entry fun register(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0);
        0x2::transfer::transfer<Miner>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun total_hashes(arg0: &Miner) : u64 {
        arg0.total_hashes
    }

    public fun total_rewards(arg0: &Miner) : u64 {
        arg0.total_rewards
    }

    // decompiled from Move bytecode v6
}

