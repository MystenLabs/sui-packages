module 0x183b005d2290858ffcfaabd8435f529bbcc1c84c54458eade6e9ce68adc8b91f::lock_coin {
    struct LockedCoinCreated has copy, drop {
        LockedCoin_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        key_hash: vector<u8>,
        balance: u64,
    }

    struct LockedCoinUnlocked has copy, drop {
        LockedCoin_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        creator: address,
        recipient: address,
        key: vector<u8>,
        balance: u64,
    }

    struct LockedCoin<phantom T0> has store, key {
        id: 0x2::object::UID,
        creator: address,
        key_hash: vector<u8>,
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun lock_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LockedCoin<T0>{
            id       : 0x2::object::new(arg2),
            creator  : 0x2::tx_context::sender(arg2),
            key_hash : arg1,
            balance  : 0x2::coin::into_balance<T0>(arg0),
        };
        emit_locked_coin_created<T0>(&v0);
        0x2::transfer::public_share_object<LockedCoin<T0>>(v0);
    }

    public fun emit_locked_coin_created<T0>(arg0: &LockedCoin<T0>) {
        let v0 = LockedCoinCreated{
            LockedCoin_id : *0x2::object::borrow_id<LockedCoin<T0>>(arg0),
            coin_type     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            creator       : arg0.creator,
            key_hash      : arg0.key_hash,
            balance       : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<LockedCoinCreated>(v0);
    }

    public fun emit_locked_coin_unlocked<T0>(arg0: &LockedCoin<T0>, arg1: address, arg2: vector<u8>) {
        let v0 = LockedCoinUnlocked{
            LockedCoin_id : *0x2::object::borrow_id<LockedCoin<T0>>(arg0),
            coin_type     : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            creator       : arg0.creator,
            recipient     : arg1,
            key           : arg2,
            balance       : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<LockedCoinUnlocked>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun unlock_coin<T0>(arg0: &mut LockedCoin<T0>, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::hash::sha3_256(arg1) == arg0.key_hash) {
            true
        } else {
            let v1 = 0x2::tx_context::sender(arg2);
            &arg0.creator == &v1
        };
        assert!(v0, 0);
        let v2 = 0x2::tx_context::sender(arg2);
        emit_locked_coin_unlocked<T0>(arg0, v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance), arg2), v2);
        arg0.key_hash = 0x1::vector::empty<u8>();
    }

    // decompiled from Move bytecode v6
}

