module 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::mazu {
    struct MAZU has drop {
        dummy_field: bool,
    }

    struct TransferRequest has store {
        stakeholder: 0x1::string::String,
        amount: u64,
        recipient: address,
    }

    struct UpdateMetadataRequest has store {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<MAZU>,
        start: u64,
        community: u64,
        team: u64,
        strategy: u64,
        private_sale: u64,
        public_sale: u64,
    }

    public fun burn(arg0: &mut Vault, arg1: 0x2::coin::Coin<MAZU>) {
        0x2::coin::burn<MAZU>(&mut arg0.cap, arg1);
    }

    public(friend) fun supply_mut(arg0: &mut Vault) : &mut 0x2::balance::Supply<MAZU> {
        0x2::coin::supply_mut<MAZU>(&mut arg0.cap)
    }

    fun assert_in_vault(arg0: 0x1::string::String) {
        let v0 = if (arg0 == 0x1::string::utf8(b"community")) {
            true
        } else if (arg0 == 0x1::string::utf8(b"strategy")) {
            true
        } else {
            arg0 == 0x1::string::utf8(b"public_sale")
        };
        assert!(v0, 1);
    }

    public(friend) fun cap_mut(arg0: &mut Vault) : &mut 0x2::coin::TreasuryCap<MAZU> {
        &mut arg0.cap
    }

    public fun complete_transfer(arg0: &mut Vault, arg1: TransferRequest, arg2: &mut 0x2::tx_context::TxContext) {
        let TransferRequest {
            stakeholder : v0,
            amount      : v1,
            recipient   : v2,
        } = arg1;
        handle_stakeholder(arg0, v0, v1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAZU>>(0x2::coin::mint<MAZU>(&mut arg0.cap, v1, arg2), v2);
    }

    public fun complete_update_metadata(arg0: &Vault, arg1: &mut 0x2::coin::CoinMetadata<MAZU>, arg2: UpdateMetadataRequest) {
        let UpdateMetadataRequest {
            name        : v0,
            symbol      : v1,
            description : v2,
            icon_url    : v3,
        } = arg2;
        0x2::coin::update_name<MAZU>(&arg0.cap, arg1, v0);
        0x2::coin::update_symbol<MAZU>(&arg0.cap, arg1, 0x1::string::to_ascii(v1));
        0x2::coin::update_description<MAZU>(&arg0.cap, arg1, v2);
        0x2::coin::update_icon_url<MAZU>(&arg0.cap, arg1, 0x1::string::to_ascii(v3));
    }

    public(friend) fun handle_stakeholder(arg0: &mut Vault, arg1: 0x1::string::String, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let (v0, v1, v2) = vesting_for_stakeholder(arg1);
        let v3 = if (0x2::tx_context::epoch(arg3) - arg0.start < v2) {
            0x2::tx_context::epoch(arg3) - arg0.start
        } else {
            v2
        };
        if (arg1 == 0x1::string::utf8(b"community")) {
            assert!(0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(v0 + 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::mul_div_down(v3, v1, v2), 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(124444444444444444, arg0.community)) >= arg2, 0);
            arg0.community = 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(arg0.community, arg2);
        } else if (arg1 == 0x1::string::utf8(b"team")) {
            assert!(0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(v0 + 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::mul_div_down(v3, v1, v2), 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(106666666666666667, arg0.team)) >= arg2, 0);
            arg0.team = 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(arg0.team, arg2);
        } else if (arg1 == 0x1::string::utf8(b"strategy")) {
            assert!(0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(v0 + 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::mul_div_down(v3, v1, v2), 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(128000000000000000, arg0.strategy)) >= arg2, 0);
            arg0.strategy = 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(arg0.strategy, arg2);
        } else if (arg1 == 0x1::string::utf8(b"private_sale")) {
            assert!(0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(v0 + 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::mul_div_down(v3, v1, v2), 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(75822222222222222, arg0.private_sale)) >= arg2, 0);
            arg0.private_sale = 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(arg0.private_sale, arg2);
        } else if (arg1 == 0x1::string::utf8(b"public_sale")) {
            assert!(0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(v0 + 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::mul_div_down(v3, v1, v2), 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(133333333333333333, arg0.public_sale)) >= arg2, 0);
            arg0.public_sale = 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::math::sub(arg0.public_sale, arg2);
        };
    }

    fun init(arg0: MAZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAZU>(arg0, 9, b"MAZU", b"Mazu", b"Simplifying Yield Farming in the Sui Ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/7KgZBFW/mazu-logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAZU>(&mut v2, 6222222222222222, @0x0, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAZU>>(v1);
        let v3 = Vault{
            id           : 0x2::object::new(arg1),
            cap          : v2,
            start        : 0x2::tx_context::epoch(arg1),
            community    : 124444444444444444,
            team         : 106666666666666667,
            strategy     : 128000000000000000,
            private_sale : 75822222222222222,
            public_sale  : 133333333333333333,
        };
        0x2::transfer::share_object<Vault>(v3);
    }

    public fun propose_transfer(arg0: &mut 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::Multisig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert_in_vault(arg2);
        let v0 = TransferRequest{
            stakeholder : arg2,
            amount      : arg3,
            recipient   : arg4,
        };
        0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::create_proposal<TransferRequest>(arg0, arg1, v0, arg5);
    }

    public fun propose_update_metadata(arg0: &mut 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::Multisig, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateMetadataRequest{
            name        : arg2,
            symbol      : arg3,
            description : arg4,
            icon_url    : arg5,
        };
        0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::create_proposal<UpdateMetadataRequest>(arg0, arg1, v0, arg6);
    }

    public fun start_transfer(arg0: 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::Proposal) : TransferRequest {
        0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::get_request<TransferRequest>(arg0)
    }

    public fun start_update_metadata(arg0: 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::Proposal) : UpdateMetadataRequest {
        0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::get_request<UpdateMetadataRequest>(arg0)
    }

    public(friend) fun vesting_for_stakeholder(arg0: 0x1::string::String) : (u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        if (arg0 == 0x1::string::utf8(b"community")) {
            let v3 = 124444444444444444 / 20;
            v2 = v3;
            v1 = 124444444444444444 - v3;
            v0 = 1096;
        } else if (arg0 == 0x1::string::utf8(b"team")) {
            v2 = 106666666666666667;
            v0 = 1;
        } else if (arg0 == 0x1::string::utf8(b"strategy")) {
            v2 = 128000000000000000;
            v0 = 1;
        } else if (arg0 == 0x1::string::utf8(b"private_sale")) {
            v2 = 75822222222222222;
            v0 = 1;
        } else if (arg0 == 0x1::string::utf8(b"public_sale")) {
            v2 = 133333333333333333;
            v0 = 1;
        };
        (v2, v1, v0)
    }

    // decompiled from Move bytecode v6
}

