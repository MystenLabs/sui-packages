module 0xbfc8310ded6a444807564c0f3e34681b68594fd74b716b2ad9ee71ecaf7119c3::choplock {
    struct LockedTokens<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        tokens: 0x2::balance::Balance<T0>,
        locked_until_epoch: u64,
        last_updated: u64,
    }

    struct NewLocker has copy, drop {
        locker_id: 0x2::object::ID,
        owner: address,
        locked_until_epoch: u64,
        total_stake: u64,
        last_updated: u64,
    }

    struct AddToLocker has copy, drop {
        locker_id: 0x2::object::ID,
        owner: address,
        total_stake: u64,
        last_updated: u64,
    }

    struct UnlockedLocker has copy, drop {
        locker_id: 0x2::object::ID,
        owner: address,
        total_stake: u64,
        last_updated: u64,
    }

    struct TransferLocker has copy, drop {
        locker_id: 0x2::object::ID,
        owner: address,
        new_owner: address,
        last_updated: u64,
    }

    public fun addToChopLocker<T0>(arg0: &mut LockedTokens<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.tokens, 0x2::coin::into_balance<T0>(arg1));
        arg0.last_updated = 0x2::clock::timestamp_ms(arg2);
        let v0 = AddToLocker{
            locker_id    : 0x2::object::uid_to_inner(&arg0.id),
            owner        : 0x2::tx_context::sender(arg3),
            total_stake  : 0x2::balance::value<T0>(&arg0.tokens),
            last_updated : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AddToLocker>(v0);
    }

    public fun locked_balance<T0>(arg0: &LockedTokens<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.tokens)
    }

    public fun locked_until_epoch<T0>(arg0: &LockedTokens<T0>) : u64 {
        arg0.locked_until_epoch
    }

    public fun newChopLocker<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) < arg1, 0);
        let v0 = 0x2::object::new(arg3);
        let v1 = LockedTokens<T0>{
            id                 : v0,
            owner              : 0x2::tx_context::sender(arg3),
            tokens             : 0x2::coin::into_balance<T0>(arg0),
            locked_until_epoch : arg1,
            last_updated       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::transfer::share_object<LockedTokens<T0>>(v1);
        let v2 = NewLocker{
            locker_id          : 0x2::object::uid_to_inner(&v0),
            owner              : 0x2::tx_context::sender(arg3),
            locked_until_epoch : arg1,
            total_stake        : 0x2::coin::value<T0>(&arg0),
            last_updated       : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<NewLocker>(v2);
    }

    public fun owner<T0>(arg0: &LockedTokens<T0>) : address {
        arg0.owner
    }

    public fun transferChopLocker<T0>(arg0: &mut LockedTokens<T0>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        arg0.owner = arg1;
        arg0.last_updated = 0x2::clock::timestamp_ms(arg2);
        let v0 = TransferLocker{
            locker_id    : 0x2::object::uid_to_inner(&arg0.id),
            owner        : 0x2::tx_context::sender(arg3),
            new_owner    : arg1,
            last_updated : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TransferLocker>(v0);
    }

    public fun unlockChopLocker<T0>(arg0: LockedTokens<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) > arg0.locked_until_epoch, 1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 2);
        let LockedTokens {
            id                 : v0,
            owner              : v1,
            tokens             : v2,
            locked_until_epoch : _,
            last_updated       : _,
        } = arg0;
        let v5 = v2;
        let v6 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg2), v1);
        0x2::object::delete(v6);
        let v7 = UnlockedLocker{
            locker_id    : 0x2::object::uid_to_inner(&v6),
            owner        : 0x2::tx_context::sender(arg2),
            total_stake  : 0x2::balance::value<T0>(&v5),
            last_updated : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<UnlockedLocker>(v7);
    }

    // decompiled from Move bytecode v6
}

