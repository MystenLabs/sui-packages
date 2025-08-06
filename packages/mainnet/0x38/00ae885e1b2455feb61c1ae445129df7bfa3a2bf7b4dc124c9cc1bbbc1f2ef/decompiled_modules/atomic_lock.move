module 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::atomic_lock {
    struct AtomicLockStorage has store, key {
        id: 0x2::object::UID,
        proposedLock: 0x2::table::Table<vector<u8>, address>,
        proposedUnlock: 0x2::table::Table<vector<u8>, address>,
        lockedBalanceOf: 0x2::table::Table<u8, u64>,
        lockedCoins: 0x2::bag::Bag,
    }

    struct TokenLockProposed has copy, drop {
        reqId: vector<u8>,
        proposer: address,
    }

    struct TokenLockExecuted has copy, drop {
        reqId: vector<u8>,
        proposer: address,
    }

    struct TokenLockCancelled has copy, drop {
        reqId: vector<u8>,
        proposer: address,
    }

    struct TokenUnlockProposed has copy, drop {
        reqId: vector<u8>,
        recipient: address,
    }

    struct TokenUnlockExecuted has copy, drop {
        reqId: vector<u8>,
        recipient: address,
    }

    struct TokenUnlockCancelled has copy, drop {
        reqId: vector<u8>,
        recipient: address,
    }

    public entry fun addToken<T0>(arg0: u8, arg1: u8, arg2: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::PermissionsStorage, arg3: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::ReqHelpersStorage, arg4: &mut 0x2::tx_context::TxContext) {
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::assertOnlyAdmin(arg2, arg4);
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::addTokenInternal<T0>(arg0, arg1, arg3);
    }

    public entry fun cancelLock<T0>(arg0: vector<u8>, arg1: &mut AtomicLockStorage, arg2: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::ReqHelpersStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg1.proposedLock, arg0);
        assert!(v0 != @0xed, 71);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 > 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::createdTimeFrom(arg0) + 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::EXPIRE_PERIOD(), 73);
        0x2::table::remove<vector<u8>, address>(&mut arg1.proposedLock, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::bag::borrow_mut<u8, 0x2::coin::Coin<T0>>(&mut arg1.lockedCoins, 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::tokenIndexFrom<T0>(arg0, arg2)), 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::amountFrom(arg0, arg2), arg4), v0);
        let v1 = TokenLockCancelled{
            reqId    : arg0,
            proposer : v0,
        };
        0x2::event::emit<TokenLockCancelled>(v1);
    }

    public entry fun cancelUnlock<T0>(arg0: vector<u8>, arg1: &mut AtomicLockStorage, arg2: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::ReqHelpersStorage, arg3: &0x2::clock::Clock) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg1.proposedUnlock, arg0);
        assert!(v0 != @0xed, 71);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 > 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::createdTimeFrom(arg0) + 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::EXPIRE_EXTRA_PERIOD(), 73);
        0x2::table::remove<vector<u8>, address>(&mut arg1.proposedUnlock, arg0);
        let v1 = 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::tokenIndexFrom<T0>(arg0, arg2);
        *0x2::table::borrow_mut<u8, u64>(&mut arg1.lockedBalanceOf, v1) = *0x2::table::borrow<u8, u64>(&arg1.lockedBalanceOf, v1) + 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::amountFrom(arg0, arg2);
        let v2 = TokenUnlockCancelled{
            reqId     : arg0,
            recipient : v0,
        };
        0x2::event::emit<TokenUnlockCancelled>(v2);
    }

    public entry fun executeLock<T0>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut AtomicLockStorage, arg6: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::PermissionsStorage, arg7: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::ReqHelpersStorage, arg8: &0x2::clock::Clock) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg5.proposedLock, arg0);
        assert!(v0 != @0xed, 71);
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::checkMultiSignatures(0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::msgFromReqSigningMessage(arg0), arg1, arg2, arg3, arg4, arg8, arg6);
        *0x2::table::borrow_mut<vector<u8>, address>(&mut arg5.proposedLock, arg0) = @0xed;
        let v1 = 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::tokenIndexFrom<T0>(arg0, arg7);
        if (0x2::table::contains<u8, u64>(&arg5.lockedBalanceOf, v1)) {
            *0x2::table::borrow_mut<u8, u64>(&mut arg5.lockedBalanceOf, v1) = *0x2::table::borrow<u8, u64>(&arg5.lockedBalanceOf, v1) + 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::amountFrom(arg0, arg7);
        } else {
            0x2::table::add<u8, u64>(&mut arg5.lockedBalanceOf, v1, 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::amountFrom(arg0, arg7));
        };
        let v2 = TokenLockExecuted{
            reqId    : arg0,
            proposer : v0,
        };
        0x2::event::emit<TokenLockExecuted>(v2);
    }

    public entry fun executeUnlock<T0>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut AtomicLockStorage, arg6: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::PermissionsStorage, arg7: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::ReqHelpersStorage, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg5.proposedUnlock, arg0);
        assert!(v0 != @0xed, 71);
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::checkMultiSignatures(0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::msgFromReqSigningMessage(arg0), arg1, arg2, arg3, arg4, arg8, arg6);
        *0x2::table::borrow_mut<vector<u8>, address>(&mut arg5.proposedUnlock, arg0) = @0xed;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::bag::borrow_mut<u8, 0x2::coin::Coin<T0>>(&mut arg5.lockedCoins, 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::tokenIndexFrom<T0>(arg0, arg7)), 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::amountFrom(arg0, arg7), arg9), v0);
        let v1 = TokenUnlockExecuted{
            reqId     : arg0,
            recipient : v0,
        };
        0x2::event::emit<TokenUnlockExecuted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::PermissionsStorage>(0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::initPermissionsStorage(arg0));
        0x2::transfer::public_share_object<0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::ReqHelpersStorage>(0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::initReqHelpersStorage(arg0));
        let v0 = AtomicLockStorage{
            id              : 0x2::object::new(arg0),
            proposedLock    : 0x2::table::new<vector<u8>, address>(arg0),
            proposedUnlock  : 0x2::table::new<vector<u8>, address>(arg0),
            lockedBalanceOf : 0x2::table::new<u8, u64>(arg0),
            lockedCoins     : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<AtomicLockStorage>(v0);
    }

    public entry fun proposeLock<T0>(arg0: vector<u8>, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut AtomicLockStorage, arg3: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::ReqHelpersStorage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::assertFromChainOnly(arg0);
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::checkCreatedTimeFrom(arg0, arg4);
        assert!(0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::actionFrom(arg0) & 15 == 1, 70);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg2.proposedLock, arg0), 71);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != @0xed, 72);
        0x2::table::add<vector<u8>, address>(&mut arg2.proposedLock, arg0, v0);
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::utils::joinCoins<T0>(arg1, 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::amountFrom(arg0, arg3), &mut arg2.lockedCoins, 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::tokenIndexFrom<T0>(arg0, arg3), arg5);
        let v1 = TokenLockProposed{
            reqId    : arg0,
            proposer : v0,
        };
        0x2::event::emit<TokenLockProposed>(v1);
    }

    public entry fun proposeUnlock<T0>(arg0: vector<u8>, arg1: address, arg2: &mut AtomicLockStorage, arg3: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::PermissionsStorage, arg4: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::ReqHelpersStorage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::assertOnlyProposer(arg3, arg6);
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::assertFromChainOnly(arg0);
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::checkCreatedTimeFrom(arg0, arg5);
        assert!(0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::actionFrom(arg0) & 15 == 2, 74);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg2.proposedUnlock, arg0), 71);
        assert!(arg1 != @0xed, 75);
        let v0 = 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::tokenIndexFrom<T0>(arg0, arg4);
        *0x2::table::borrow_mut<u8, u64>(&mut arg2.lockedBalanceOf, v0) = *0x2::table::borrow<u8, u64>(&arg2.lockedBalanceOf, v0) - 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::amountFrom(arg0, arg4);
        0x2::table::add<vector<u8>, address>(&mut arg2.proposedUnlock, arg0, arg1);
        let v1 = TokenUnlockProposed{
            reqId     : arg0,
            recipient : arg1,
        };
        0x2::event::emit<TokenUnlockProposed>(v1);
    }

    public entry fun removeToken(arg0: u8, arg1: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::PermissionsStorage, arg2: &mut 0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::ReqHelpersStorage, arg3: &mut 0x2::tx_context::TxContext) {
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::permissions::assertOnlyAdmin(arg1, arg3);
        0x3800ae885e1b2455feb61c1ae445129df7bfa3a2bf7b4dc124c9cc1bbbc1f2ef::req_helpers::removeTokenInternal(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

