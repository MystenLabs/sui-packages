module 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::arca {
    struct ARCA has drop {
        dummy_field: bool,
    }

    struct Guardian has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<ARCA>,
        for_multi_sign: 0x2::object::ID,
    }

    struct ExtraCoinMeta has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
    }

    struct MintRequest has store, key {
        id: 0x2::object::UID,
        amount: u64,
        recipient: address,
    }

    struct BurnRequest has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<ARCA>,
        creator: address,
    }

    struct UpdateMetadataRequest has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        max_supply: u64,
    }

    struct Metadata has drop {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        max_supply: u64,
    }

    struct RoleGranted has copy, drop {
        cashier: address,
    }

    struct RoleRevoked has copy, drop {
        cashier: address,
    }

    struct CoinMinted has copy, drop {
        cashier: address,
        recipient: address,
        amount: u64,
    }

    struct CoinBurned has copy, drop {
        cashier: address,
    }

    fun burn(arg0: &mut Guardian, arg1: BurnRequest, arg2: &mut 0x2::tx_context::TxContext) {
        let BurnRequest {
            id      : v0,
            coin    : v1,
            creator : _,
        } = arg1;
        0x2::coin::burn<ARCA>(&mut arg0.treasury_cap, v1);
        0x2::object::delete(v0);
        let v3 = CoinBurned{cashier: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<CoinBurned>(v3);
    }

    public entry fun burn_execute(arg0: &mut Guardian, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: &ExtraCoinMeta, arg3: u256, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : bool {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg5);
        if (arg4) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg3);
            if (v0) {
                let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::extract_proposal_request<BurnRequest>(arg1, arg3, arg5);
                burn(arg0, v2, arg5);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg3, arg5);
                return true
            };
        } else {
            let (v3, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg3);
            if (v3) {
                let BurnRequest {
                    id      : v5,
                    coin    : v6,
                    creator : v7,
                } = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::extract_proposal_request<BurnRequest>(arg1, arg3, arg5);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg3, arg5);
                0x2::transfer::public_transfer<0x2::coin::Coin<ARCA>>(v6, v7);
                0x2::object::delete(v5);
                return true
            };
        };
        abort 4
    }

    public entry fun burn_request(arg0: &mut Guardian, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: 0x2::coin::Coin<ARCA>, arg3: &mut 0x2::tx_context::TxContext) {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg3);
        let v0 = BurnRequest{
            id      : 0x2::object::new(arg3),
            coin    : arg2,
            creator : 0x2::tx_context::sender(arg3),
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<BurnRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<BurnRequest>(arg1, *0x1::string::bytes(&v1), 2, v0, arg3);
    }

    public fun get_max_supply(arg0: &ExtraCoinMeta) : u64 {
        arg0.max_supply
    }

    fun init(arg0: ARCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARCA>(arg0, 9, b"ARCA", b"ARCA", b"ARCA Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_multisig(arg1);
        let v3 = Guardian{
            id             : 0x2::object::new(arg1),
            treasury_cap   : v0,
            for_multi_sign : 0x2::object::id<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature>(&v2),
        };
        0x2::transfer::public_share_object<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature>(v2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARCA>>(v1);
        0x2::transfer::share_object<Guardian>(v3);
        let v4 = ExtraCoinMeta{
            id         : 0x2::object::new(arg1),
            max_supply : 10000000000000000000,
        };
        0x2::transfer::share_object<ExtraCoinMeta>(v4);
    }

    fun max_supply_not_exceed(arg0: &Guardian, arg1: &ExtraCoinMeta, arg2: u64) {
        assert!(0x2::coin::total_supply<ARCA>(&arg0.treasury_cap) + arg2 <= arg1.max_supply, 3);
    }

    fun mint(arg0: &mut Guardian, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ARCA>(&mut arg0.treasury_cap, arg1, arg2, arg3);
        let v0 = CoinMinted{
            cashier   : 0x2::tx_context::sender(arg3),
            recipient : arg2,
            amount    : arg1,
        };
        0x2::event::emit<CoinMinted>(v0);
    }

    public entry fun mint_execute(arg0: &mut Guardian, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: &ExtraCoinMeta, arg3: u256, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : bool {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg5);
        if (arg4) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg3);
            if (v0) {
                let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<MintRequest>(arg1, &arg3, arg5);
                max_supply_not_exceed(arg0, arg2, v2.amount);
                mint(arg0, v2.amount, v2.recipient, arg5);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg3, arg5);
                return true
            };
        } else {
            let (v3, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg3);
            if (v3) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg3, arg5);
                return true
            };
        };
        abort 4
    }

    public entry fun mint_request(arg0: &mut Guardian, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: &ExtraCoinMeta, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg5);
        max_supply_not_exceed(arg0, arg2, arg3);
        let v0 = MintRequest{
            id        : 0x2::object::new(arg5),
            amount    : arg3,
            recipient : arg4,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<MintRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<MintRequest>(arg1, *0x1::string::bytes(&v1), 1, v0, arg5);
    }

    fun only_multi_sig_scope(arg0: &0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg1: &Guardian) {
        assert!(0x2::object::id<0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature>(arg0) == arg1.for_multi_sign, 1);
    }

    fun only_participant(arg0: &0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_participant(arg0, 0x2::tx_context::sender(arg1)), 2);
    }

    fun update_metadata(arg0: &Guardian, arg1: &mut 0x2::coin::CoinMetadata<ARCA>, arg2: &mut ExtraCoinMeta, arg3: Metadata, arg4: &mut 0x2::tx_context::TxContext) {
        if (!0x1::string::is_empty(&arg3.name) && 0x2::coin::get_name<ARCA>(arg1) != arg3.name) {
            0x2::coin::update_name<ARCA>(&arg0.treasury_cap, arg1, arg3.name);
        };
        if (!0x1::string::is_empty(&arg3.symbol) && 0x2::coin::get_symbol<ARCA>(arg1) != 0x1::string::to_ascii(arg3.symbol)) {
            0x2::coin::update_symbol<ARCA>(&arg0.treasury_cap, arg1, 0x1::string::to_ascii(arg3.symbol));
        };
        if (!0x1::string::is_empty(&arg3.description) && 0x2::coin::get_description<ARCA>(arg1) != arg3.description) {
            0x2::coin::update_description<ARCA>(&arg0.treasury_cap, arg1, arg3.description);
        };
        let v0 = if (!0x1::string::is_empty(&arg3.icon_url)) {
            let v1 = 0x2::coin::get_icon_url<ARCA>(arg1);
            if (0x1::option::is_none<0x2::url::Url>(&v1)) {
                true
            } else {
                let v2 = 0x2::coin::get_icon_url<ARCA>(arg1);
                0x1::option::extract<0x2::url::Url>(&mut v2) != 0x2::url::new_unsafe(0x1::string::to_ascii(arg3.icon_url))
            }
        } else {
            false
        };
        if (v0) {
            0x2::coin::update_icon_url<ARCA>(&arg0.treasury_cap, arg1, 0x1::string::to_ascii(arg3.icon_url));
        };
        if (arg2.max_supply != arg3.max_supply) {
            arg2.max_supply = arg3.max_supply;
        };
    }

    public entry fun update_metadata_execute(arg0: &mut Guardian, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: &mut 0x2::coin::CoinMetadata<ARCA>, arg3: &mut ExtraCoinMeta, arg4: u256, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : bool {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg6);
        if (arg5) {
            let (v0, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_approved(arg1, arg4);
            if (v0) {
                let v2 = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::borrow_proposal_request<UpdateMetadataRequest>(arg1, &arg4, arg6);
                let v3 = Metadata{
                    name        : v2.name,
                    symbol      : v2.symbol,
                    description : v2.description,
                    icon_url    : v2.icon_url,
                    max_supply  : v2.max_supply,
                };
                update_metadata(arg0, arg2, arg3, v3, arg6);
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg4, arg6);
                return true
            };
        } else {
            let (v4, _) = 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::is_proposal_rejected(arg1, arg4);
            if (v4) {
                0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::mark_proposal_complete(arg1, arg4, arg6);
                return true
            };
        };
        abort 4
    }

    public entry fun update_metadata_request(arg0: &mut Guardian, arg1: &mut 0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::MultiSignature, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        only_multi_sig_scope(arg1, arg0);
        only_participant(arg1, arg7);
        let v0 = UpdateMetadataRequest{
            id          : 0x2::object::new(arg7),
            name        : arg2,
            symbol      : arg3,
            description : arg4,
            icon_url    : arg5,
            max_supply  : arg6,
        };
        let v1 = 0x2::address::to_string(0x2::object::id_address<UpdateMetadataRequest>(&v0));
        0xb44a3f380e4886da6be8af7c7ea416bf7e2d2462ba2fe105fa3d48eed6b4d388::multisig::create_proposal<UpdateMetadataRequest>(arg1, *0x1::string::bytes(&v1), 3, v0, arg7);
    }

    // decompiled from Move bytecode v6
}

