module 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::atomic_mint {
    struct AtomicMintStorage has store, key {
        id: 0x2::object::UID,
        proposedMint: 0x2::table::Table<vector<u8>, address>,
        proposedBurn: 0x2::table::Table<vector<u8>, address>,
        burningCoins: 0x2::bag::Bag,
        minterCaps: 0x2::bag::Bag,
        burnerCaps: 0x2::bag::Bag,
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

    public entry fun addToken<T0>(arg0: u8, arg1: u8, arg2: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::PermissionsStorage, arg3: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg4: &mut 0x2::tx_context::TxContext) {
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::assertOnlyAdmin(arg2, arg4);
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::addTokenInternal<T0>(arg0, arg1, arg3);
    }

    public entry fun cancelBurn<T0>(arg0: vector<u8>, arg1: &mut AtomicMintStorage, arg2: &0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg1.proposedBurn, arg0);
        assert!(v0 != @0xed, 50);
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 > 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::createdTimeFrom(arg0) + 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::EXPIRE_PERIOD(), 54);
        0x2::table::remove<vector<u8>, address>(&mut arg1.proposedBurn, arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(0x2::bag::borrow_mut<u8, 0x2::coin::Coin<T0>>(&mut arg1.burningCoins, 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::tokenIndexFrom<T0>(arg0, arg2)), 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::amountFrom(arg0, arg2), arg4), v0);
        let v1 = TokenBurnCancelled{
            reqId    : arg0,
            proposer : v0,
        };
        0x2::event::emit<TokenBurnCancelled>(v1);
    }

    public entry fun cancelMint(arg0: vector<u8>, arg1: &mut AtomicMintStorage, arg2: &0x2::clock::Clock) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg1.proposedMint, arg0);
        assert!(v0 != @0xed, 50);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 > 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::createdTimeFrom(arg0) + 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::EXPIRE_EXTRA_PERIOD(), 54);
        0x2::table::remove<vector<u8>, address>(&mut arg1.proposedMint, arg0);
        let v1 = TokenMintCancelled{
            reqId     : arg0,
            recipient : v0,
        };
        0x2::event::emit<TokenMintCancelled>(v1);
    }

    public entry fun executeBurn<T0>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AccessConfig, arg6: &mut 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::mbtc::TreasuryCapManager, arg7: &mut AtomicMintStorage, arg8: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::PermissionsStorage, arg9: &0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg7.proposedBurn, arg0);
        assert!(v0 != @0xed, 50);
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::checkMultiSignatures(0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::msgFromReqSigningMessage(arg0), arg1, arg2, arg3, arg4, arg10, arg8);
        *0x2::table::borrow_mut<vector<u8>, address>(&mut arg7.proposedBurn, arg0) = @0xed;
        let v1 = 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::tokenIndexFrom<T0>(arg0, arg9);
        0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::mbtc::burn(0x2::coin::split<0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::mbtc::MBTC>(0x2::bag::borrow_mut<u8, 0x2::coin::Coin<0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::mbtc::MBTC>>(&mut arg7.burningCoins, v1), 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::amountFrom(arg0, arg9), arg11), arg6, 0x2::bag::borrow<u8, 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::BurnerCap>(&arg7.burnerCaps, v1), arg5);
        let v2 = TokenBurnExecuted{
            reqId    : arg0,
            proposer : v0,
        };
        0x2::event::emit<TokenBurnExecuted>(v2);
    }

    public entry fun executeMint<T0>(arg0: vector<u8>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: u64, arg5: &mut 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::AccessConfig, arg6: &mut 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::mbtc::TreasuryCapManager, arg7: &mut AtomicMintStorage, arg8: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::PermissionsStorage, arg9: &0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x2::table::borrow<vector<u8>, address>(&arg7.proposedMint, arg0);
        assert!(v0 != @0xed, 50);
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::checkMultiSignatures(0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::msgFromReqSigningMessage(arg0), arg1, arg2, arg3, arg4, arg10, arg8);
        *0x2::table::borrow_mut<vector<u8>, address>(&mut arg7.proposedMint, arg0) = @0xed;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::mbtc::MBTC>>(0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::mbtc::mint(0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::amountFrom(arg0, arg9), arg6, 0x2::bag::borrow<u8, 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::MinterCap>(&arg7.minterCaps, 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::tokenIndexFrom<T0>(arg0, arg9)), arg5, arg11), v0);
        let v1 = TokenMintExecuted{
            reqId     : arg0,
            recipient : v0,
        };
        0x2::event::emit<TokenMintExecuted>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::PermissionsStorage>(0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::initPermissionsStorage(arg0));
        0x2::transfer::public_share_object<0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage>(0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::initReqHelpersStorage(arg0));
        let v0 = AtomicMintStorage{
            id           : 0x2::object::new(arg0),
            proposedMint : 0x2::table::new<vector<u8>, address>(arg0),
            proposedBurn : 0x2::table::new<vector<u8>, address>(arg0),
            burningCoins : 0x2::bag::new(arg0),
            minterCaps   : 0x2::bag::new(arg0),
            burnerCaps   : 0x2::bag::new(arg0),
        };
        0x2::transfer::public_share_object<AtomicMintStorage>(v0);
    }

    public entry fun proposeBurn<T0>(arg0: vector<u8>, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut AtomicMintStorage, arg3: &0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::assertToChainOnly(arg0);
        assert!(0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::actionFrom(arg0) & 15 == 2, 56);
        proposeBurnPrivate<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun proposeBurnForMint<T0>(arg0: vector<u8>, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut AtomicMintStorage, arg3: &0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::assertFromChainOnly(arg0);
        assert!(0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::actionFrom(arg0) & 15 == 3, 53);
        proposeBurnPrivate<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun proposeBurnPrivate<T0>(arg0: vector<u8>, arg1: vector<0x2::coin::Coin<T0>>, arg2: &mut AtomicMintStorage, arg3: &0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::checkCreatedTimeFrom(arg0, arg4);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg2.proposedBurn, arg0), 50);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 != @0xed, 55);
        0x2::table::add<vector<u8>, address>(&mut arg2.proposedBurn, arg0, v0);
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::utils::joinCoins<T0>(arg1, 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::amountFrom(arg0, arg3), &mut arg2.burningCoins, 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::tokenIndexFrom<T0>(arg0, arg3), arg5);
        let v1 = TokenBurnProposed{
            reqId    : arg0,
            proposer : v0,
        };
        0x2::event::emit<TokenBurnProposed>(v1);
    }

    public entry fun proposeMint<T0>(arg0: vector<u8>, arg1: address, arg2: &mut AtomicMintStorage, arg3: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::PermissionsStorage, arg4: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::assertOnlyProposer(arg3, arg6);
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::assertToChainOnly(arg0);
        assert!(0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::actionFrom(arg0) & 15 == 1, 52);
        proposeMintPrivate<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    public entry fun proposeMintFromBurn<T0>(arg0: vector<u8>, arg1: address, arg2: &mut AtomicMintStorage, arg3: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::PermissionsStorage, arg4: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::assertOnlyProposer(arg3, arg6);
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::assertToChainOnly(arg0);
        assert!(0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::actionFrom(arg0) & 15 == 3, 53);
        proposeMintPrivate<T0>(arg0, arg1, arg2, arg4, arg5);
    }

    fun proposeMintPrivate<T0>(arg0: vector<u8>, arg1: address, arg2: &mut AtomicMintStorage, arg3: &0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg4: &0x2::clock::Clock) {
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::checkCreatedTimeFrom(arg0, arg4);
        assert!(!0x2::table::contains<vector<u8>, address>(&arg2.proposedMint, arg0), 50);
        assert!(arg1 != @0xed, 51);
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::amountFrom(arg0, arg3);
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::tokenIndexFrom<T0>(arg0, arg3);
        0x2::table::add<vector<u8>, address>(&mut arg2.proposedMint, arg0, arg1);
        let v0 = TokenMintProposed{
            reqId     : arg0,
            recipient : arg1,
        };
        0x2::event::emit<TokenMintProposed>(v0);
    }

    public entry fun removeToken(arg0: u8, arg1: &mut AtomicMintStorage, arg2: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::PermissionsStorage, arg3: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage, arg4: &mut 0x2::tx_context::TxContext) {
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::permissions::assertOnlyAdmin(arg2, arg4);
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::removeTokenInternal(arg0, arg3);
        if (0x2::bag::contains<u8>(&arg1.minterCaps, arg0)) {
            0x2::transfer::public_transfer<0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::MinterCap>(0x2::bag::remove<u8, 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::MinterCap>(&mut arg1.minterCaps, arg0), 0x2::tx_context::sender(arg4));
            0x2::transfer::public_transfer<0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::BurnerCap>(0x2::bag::remove<u8, 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::BurnerCap>(&mut arg1.burnerCaps, arg0), 0x2::tx_context::sender(arg4));
        };
    }

    public entry fun transferCaps<T0>(arg0: u8, arg1: 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::MinterCap, arg2: 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::BurnerCap, arg3: &mut AtomicMintStorage, arg4: &mut 0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::ReqHelpersStorage) {
        0xc0e02990a533992e81af97958d3284dd7aa8faea0a2631514211fef9917c8a4e::req_helpers::checkTokenType<T0>(arg0, arg4);
        assert!(!0x2::bag::contains<u8>(&arg3.minterCaps, arg0), 57);
        0x2::bag::add<u8, 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::MinterCap>(&mut arg3.minterCaps, arg0, arg1);
        0x2::bag::add<u8, 0xd1a91b46bd6d966b62686263609074ad16cfdffc63c31a4775870a2d54d20c6b::access_control::BurnerCap>(&mut arg3.burnerCaps, arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

