module 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::atomic_mint {
    struct AtomicMintStorage has store, key {
        id: 0x2::object::UID,
        proposedMint: 0x2::table::Table<vector<u8>, address>,
        proposedBurn: 0x2::table::Table<vector<u8>, address>,
        burningCoins: 0x2::bag::Bag,
        minterCaps: 0x2::bag::Bag,
    }

    struct TokenMintProposed has copy, drop {
        reqId: vector<u8>,
        recipient: address,
    }

    struct TokenMintExecuted has copy, drop {
        reqId: vector<u8>,
        recipient: address,
    }

    struct TokenMintCancelled has copy, drop {
        reqId: vector<u8>,
        recipient: address,
    }

    struct TokenBurnProposed has copy, drop {
        reqId: vector<u8>,
        proposer: address,
    }

    struct TokenBurnExecuted has copy, drop {
        reqId: vector<u8>,
        proposer: address,
    }

    struct TokenBurnCancelled has copy, drop {
        reqId: vector<u8>,
        proposer: address,
    }

    public entry fun addToken<T0>(arg0: u8, arg1: u8, arg2: 0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::MinterCap<T0>, arg3: &mut AtomicMintStorage, arg4: &mut 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::addTokenInternal<T0>(arg0, arg1, arg4);
        assert!(!0x2::bag::contains<u8>(&arg3.minterCaps, arg0), 57);
        0x2::bag::add<u8, 0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::MinterCap<T0>>(&mut arg3.minterCaps, arg0, arg2);
    }

    public entry fun cancelBurn<T0>(arg0: vector<u8>, arg1: &mut AtomicMintStorage, arg2: &0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg1.proposedBurn, arg0);
        assert!(v0 != @0xed, 50);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 > 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::createdTimeFrom(arg0) + 259200, 54);
        0x2::table::remove<vector<u8>, address>(&mut arg1.proposedBurn, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::bag::borrow_mut<u8, 0x2::coin::Coin<T0>>(&mut arg1.burningCoins, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::tokenIndexFrom<T0>(arg0, arg2)), 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::amountFrom(arg0, arg2), arg4), v0);
        let v1 = TokenBurnCancelled{
            reqId    : arg0,
            proposer : v0,
        };
        0x2::event::emit<TokenBurnCancelled>(v1);
    }

    public entry fun cancelMint(arg0: vector<u8>, arg1: &mut AtomicMintStorage, arg2: &0x2::clock::Clock) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg1.proposedMint, arg0);
        assert!(v0 != @0xed, 50);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 > 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::createdTimeFrom(arg0) + 345600, 54);
        0x2::table::remove<vector<u8>, address>(&mut arg1.proposedMint, arg0);
        let v1 = TokenMintCancelled{
            reqId     : arg0,
            recipient : v0,
        };
        0x2::event::emit<TokenMintCancelled>(v1);
    }

    public entry fun executeBurn<T0>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut 0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::TreasuryCapManager<T0>, arg6: &mut AtomicMintStorage, arg7: &mut 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::PermissionsStorage, arg8: &0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg6.proposedBurn, arg0);
        assert!(v0 != @0xed, 50);
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::checkMultiSignatures(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::msgFromReqSigningMessage(arg0), arg1, arg2, arg3, arg4, arg9, arg7);
        *0x2::table::borrow_mut<vector<u8>, address>(&mut arg6.proposedBurn, arg0) = @0xed;
        let v1 = 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::amountFrom(arg0, arg8);
        let v2 = 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::tokenIndexFrom<T0>(arg0, arg8);
        0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::burn<T0>(v1, 0x1::vector::singleton<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::bag::borrow_mut<u8, 0x2::coin::Coin<T0>>(&mut arg6.burningCoins, v2), v1, arg10)), 0x2::bag::borrow_mut<u8, 0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::MinterCap<T0>>(&mut arg6.minterCaps, v2), arg5, arg10);
        let v3 = TokenBurnExecuted{
            reqId    : arg0,
            proposer : v0,
        };
        0x2::event::emit<TokenBurnExecuted>(v3);
    }

    public entry fun executeMint<T0>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut 0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::TreasuryCapManager<T0>, arg6: &mut AtomicMintStorage, arg7: &mut 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::PermissionsStorage, arg8: &0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg6.proposedMint, arg0);
        assert!(v0 != @0xed, 50);
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::checkMultiSignatures(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::msgFromReqSigningMessage(arg0), arg1, arg2, arg3, arg4, arg9, arg7);
        *0x2::table::borrow_mut<vector<u8>, address>(&mut arg6.proposedMint, arg0) = @0xed;
        0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::mint<T0>(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::amountFrom(arg0, arg8), v0, 0x2::bag::borrow_mut<u8, 0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::MinterCap<T0>>(&mut arg6.minterCaps, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::tokenIndexFrom<T0>(arg0, arg8)), arg5, arg10);
        let v1 = TokenMintExecuted{
            reqId     : arg0,
            recipient : v0,
        };
        0x2::event::emit<TokenMintExecuted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::PermissionsStorage>(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::initPermissionsStorage(arg0));
        0x2::transfer::public_share_object<0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage>(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::initReqHelpersStorage(arg0));
        let v0 = AtomicMintStorage{
            id           : 0x2::object::new(arg0),
            proposedMint : 0x2::table::new<vector<u8>, address>(arg0),
            proposedBurn : 0x2::table::new<vector<u8>, address>(arg0),
            burningCoins : 0x2::bag::new(arg0),
            minterCaps   : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<AtomicMintStorage>(v0);
    }

    public entry fun proposeBurn<T0>(arg0: vector<u8>, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut AtomicMintStorage, arg3: &0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::assertToChainOnly(arg0);
        assert!(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::actionFrom(arg0) & 15 == 2, 56);
        proposeBurnPrivate<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun proposeBurnForMint<T0>(arg0: vector<u8>, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut AtomicMintStorage, arg3: &0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::assertFromChainOnly(arg0);
        assert!(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::actionFrom(arg0) & 15 == 3, 53);
        proposeBurnPrivate<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun proposeBurnPrivate<T0>(arg0: vector<u8>, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut AtomicMintStorage, arg3: &0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::checkCreatedTimeFrom(arg0, arg4);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg2.proposedBurn, arg0), 50);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != @0xed, 55);
        0x2::table::add<vector<u8>, address>(&mut arg2.proposedBurn, arg0, v0);
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::utils::joinCoins<T0>(arg1, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::amountFrom(arg0, arg3), &mut arg2.burningCoins, 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::tokenIndexFrom<T0>(arg0, arg3), arg5);
        let v1 = TokenBurnProposed{
            reqId    : arg0,
            proposer : v0,
        };
        0x2::event::emit<TokenBurnProposed>(v1);
    }

    public entry fun proposeMint<T0>(arg0: vector<u8>, arg1: address, arg2: &mut AtomicMintStorage, arg3: &mut 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::PermissionsStorage, arg4: &mut 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::assertOnlyProposer(arg3, arg6);
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::assertToChainOnly(arg0);
        assert!(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::actionFrom(arg0) & 15 == 1, 52);
        proposeMintPrivate<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    public entry fun proposeMintFromBurn<T0>(arg0: vector<u8>, arg1: address, arg2: &mut AtomicMintStorage, arg3: &mut 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::PermissionsStorage, arg4: &mut 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::assertOnlyProposer(arg3, arg6);
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::assertToChainOnly(arg0);
        assert!(0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::actionFrom(arg0) & 15 == 3, 53);
        proposeMintPrivate<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    fun proposeMintPrivate<T0>(arg0: vector<u8>, arg1: address, arg2: &mut AtomicMintStorage, arg3: &0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg4: &0x2::clock::Clock) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::checkCreatedTimeFrom(arg0, arg4);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg2.proposedMint, arg0), 50);
        assert!(arg1 != @0xed, 51);
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::amountFrom(arg0, arg3);
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::tokenIndexFrom<T0>(arg0, arg3);
        0x2::table::add<vector<u8>, address>(&mut arg2.proposedMint, arg0, arg1);
        let v0 = TokenMintProposed{
            reqId     : arg0,
            recipient : arg1,
        };
        0x2::event::emit<TokenMintProposed>(v0);
    }

    public entry fun removeToken<T0>(arg0: u8, arg1: &mut AtomicMintStorage, arg2: &mut 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::PermissionsStorage, arg3: &mut 0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::ReqHelpersStorage, arg4: &mut 0x2::tx_context::TxContext) {
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::permissions::assertOnlyAdmin(arg2, arg4);
        0x9ca148bbd99b43c568418ed59dfd586b21995af71374dcd8140a3f5b36777b72::req_helpers::removeTokenInternal(arg0, arg3);
        assert!(0x2::bag::contains<u8>(&arg1.minterCaps, arg0), 58);
        0x2::transfer::public_freeze_object<0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::MinterCap<T0>>(0x2::bag::remove<u8, 0xf7246f49e59a7df31e4db03a46db6da059d2e5ef68cd2bb4a818781a06473822::minter_manager::MinterCap<T0>>(&mut arg1.minterCaps, arg0));
    }

    // decompiled from Move bytecode v6
}

