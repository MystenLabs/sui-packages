module 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::vault {
    struct EuterpeVault has key {
        id: 0x2::object::UID,
    }

    struct DepositNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        token_id: u256,
        amount: u256,
        account: address,
    }

    struct WithdrawNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        token_id: u256,
        amount: u256,
        account: address,
    }

    public entry fun deposit_nft(arg0: &mut EuterpeVault, arg1: 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositNFTEvent{
            object_id : 0x2::object::id<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(&arg1),
            token_id  : 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::get_token_id(&arg1),
            amount    : 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::get_amount(&arg1),
            account   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DepositNFTEvent>(v0);
        0x2::dynamic_object_field::add<0x2::object::ID, 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(&mut arg0.id, 0x2::object::id<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(&arg1), arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EuterpeVault{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<EuterpeVault>(v0);
    }

    public entry fun withdraw_multi_nfts(arg0: &0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::capabilities::OwnerCap, arg1: u256, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::mint_multi(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun withdraw_nft(arg0: &0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::capabilities::OwnerCap, arg1: u256, arg2: u256, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::mint(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun withdraw_nft_from_vault(arg0: &0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::capabilities::OwnerCap, arg1: &mut EuterpeVault, arg2: 0x2::object::ID, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x2::object::ID>(&arg1.id, arg2), 0);
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(&mut arg1.id, arg2);
        let v1 = WithdrawNFTEvent{
            object_id : arg2,
            token_id  : 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::get_token_id(&v0),
            amount    : 0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::get_amount(&v0),
            account   : arg3,
        };
        0x2::event::emit<WithdrawNFTEvent>(v1);
        0x2::transfer::public_transfer<0x871341d2725e5069e170287eab3cf6ff687fd9ef327ba9ef857649b1dd7cd846::ip_nft::EuterpeIPNFT>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

