module 0xd167112e0beaffcdb88caf07957f40257fd7296086c79b3d600d26a3494378db::stake_entry {
    struct StakeEntry<T0: store + key> has store, key {
        id: 0x2::object::UID,
        nft: T0,
        nft_owner: address,
        staked_at_epoch: u64,
        last_claimed_epoch: u64,
        stake_pool_id: 0x2::object::ID,
        url: 0x1::option::Option<0x2::url::Url>,
    }

    public fun create_stake_entry<T0: store + key>(arg0: T0, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : StakeEntry<T0> {
        StakeEntry<T0>{
            id                 : 0x2::object::new(arg5),
            nft                : arg0,
            nft_owner          : arg1,
            staked_at_epoch    : arg2,
            last_claimed_epoch : arg3,
            stake_pool_id      : arg4,
            url                : 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"ipfs://QmY4MFz7WiFQH8DehNixY42JomCiA9yVoRZBvXRhbmg5yP"))),
        }
    }

    public fun is_owner<T0: store + key>(arg0: &StakeEntry<T0>, arg1: address) : bool {
        arg0.nft_owner != arg1
    }

    public fun last_claimed_epoch<T0: store + key>(arg0: &StakeEntry<T0>) : u64 {
        arg0.last_claimed_epoch
    }

    public fun nft_owner<T0: store + key>(arg0: &StakeEntry<T0>) : address {
        arg0.nft_owner
    }

    public fun redeem_and_destroy_stake_entry<T0: store + key>(arg0: StakeEntry<T0>, arg1: address) {
        let StakeEntry {
            id                 : v0,
            nft                : v1,
            nft_owner          : _,
            staked_at_epoch    : _,
            last_claimed_epoch : _,
            stake_pool_id      : _,
            url                : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<T0>(v1, arg1);
    }

    public fun set_last_claimed_epoch<T0: store + key>(arg0: &mut StakeEntry<T0>, arg1: u64) {
        arg0.last_claimed_epoch = arg1;
    }

    public fun stake_pool_id<T0: store + key>(arg0: &StakeEntry<T0>) : 0x2::object::ID {
        arg0.stake_pool_id
    }

    public fun staked_at_epoch<T0: store + key>(arg0: &StakeEntry<T0>) : u64 {
        arg0.staked_at_epoch
    }

    // decompiled from Move bytecode v6
}

