module 0x26c5fe4e0d89e61e5cac3fab552c3895dc9cd5e04682db3258428c5096197aee::flux_vip_nft {
    struct FluxVipNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        metadata_url: 0x2::url::Url,
        attributes: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
        token_id: u64,
        approved_for_staking: bool,
        approved_staking_contract: address,
    }

    struct FLUX_VIP_NFT has drop {
        dummy_field: bool,
    }

    struct FluxVipNFTCollection has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        minted: u64,
        mint_price: u64,
        approved_staking_contracts: vector<address>,
        treasury: address,
    }

    struct MintingCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct StakingManagerCap has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
    }

    struct MintEvent has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        owner: address,
        price: u64,
    }

    struct ApproveForStakingEvent has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        staking_contract: address,
        timestamp: u64,
    }

    struct CancelStakingApprovalEvent has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct StakingContractAddedEvent has copy, drop {
        staking_contract: address,
        admin: address,
    }

    struct StakingContractRemovedEvent has copy, drop {
        staking_contract: address,
        admin: address,
    }

    struct PriceUpdateEvent has copy, drop {
        old_price: u64,
        new_price: u64,
    }

    struct PlacedInKioskEvent has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct TakenFromKioskEvent has copy, drop {
        nft_id: 0x2::object::ID,
        owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct TreasuryUpdateEvent has copy, drop {
        old_treasury: address,
        new_treasury: address,
        admin: address,
    }

    struct StakingEvent has copy, drop {
        nft_id: 0x2::object::ID,
        staking_contract: address,
        timestamp: u64,
    }

    public entry fun approve_for_staking(arg0: &FluxVipNFTCollection, arg1: &mut FluxVipNFT, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.approved_for_staking, 5);
        assert!(is_approved_staking_contract(arg0, arg2), 3);
        arg1.approved_for_staking = true;
        arg1.approved_staking_contract = arg2;
        let v0 = ApproveForStakingEvent{
            nft_id           : 0x2::object::id<FluxVipNFT>(arg1),
            owner            : 0x2::tx_context::sender(arg3),
            staking_contract : arg2,
            timestamp        : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<ApproveForStakingEvent>(v0);
    }

    public entry fun approve_staking_contract(arg0: &StakingManagerCap, arg1: &mut FluxVipNFTCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::contains<address>(&arg1.approved_staking_contracts, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.approved_staking_contracts, arg2);
            let v0 = StakingContractAddedEvent{
                staking_contract : arg2,
                admin            : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<StakingContractAddedEvent>(v0);
        };
    }

    public entry fun cancel_staking_approval(arg0: &mut FluxVipNFT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.approved_for_staking, 4);
        arg0.approved_for_staking = false;
        arg0.approved_staking_contract = @0x0;
        let v0 = CancelStakingApprovalEvent{
            nft_id    : 0x2::object::id<FluxVipNFT>(arg0),
            owner     : 0x2::tx_context::sender(arg1),
            timestamp : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<CancelStakingApprovalEvent>(v0);
    }

    fun create_ipfs_url(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : 0x1::ascii::String {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, b"ipfs://");
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, b"/");
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x1::ascii::string(v0)
    }

    public fun get_approved_staking_contract(arg0: &FluxVipNFT) : address {
        arg0.approved_staking_contract
    }

    public fun get_image_url(arg0: &FluxVipNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public fun get_metadata_url(arg0: &FluxVipNFT) : &0x2::url::Url {
        &arg0.metadata_url
    }

    public fun get_mint_price(arg0: &FluxVipNFTCollection) : u64 {
        arg0.mint_price
    }

    public fun get_minted_count(arg0: &FluxVipNFTCollection) : u64 {
        arg0.minted
    }

    public fun get_name(arg0: &FluxVipNFTCollection) : &0x1::string::String {
        &arg0.name
    }

    public fun get_token_id(arg0: &FluxVipNFT) : u64 {
        arg0.token_id
    }

    fun init(arg0: FLUX_VIP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FLUX_VIP_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"token_id"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"metadata_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"external_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"collection_name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://fluxzone.online"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{metadata_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://ipfs.io/ipfs/bafybeiff7c7p24lgkgkbmaw3mq75dom24xnyxpwro4dagibuosorap6ew4/{token_id}.json"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"FLUX VIP Membership Collection"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Flux Zone"));
        let v5 = 0x2::display::new_with_fields<FluxVipNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<FluxVipNFT>(&mut v5);
        let v6 = FluxVipNFTCollection{
            id                         : 0x2::object::new(arg1),
            name                       : 0x1::string::utf8(b"FLUX VIP Membership Collection"),
            description                : 0x1::string::utf8(b"The FLUX VIP Membership Pass is your exclusive gateway to the FLUX ecosystem on Sui Network. As a valued first-generation member, you enjoy premium benefits across our platform: 50% reduced trading fees, enhanced staking rewards up to 30% APR boost, priority farming yield multipliers, and early access to new features. All 300 membership passes provide identical privileges, ensuring a fair and equitable experience for everyone in our community. Your pass grants you voting rights in special governance decisions, access to exclusive events, advanced analytics tools, priority notifications, enhanced liquidity provider incentives, and first access to experimental features."),
            minted                     : 0,
            mint_price                 : 25000000000,
            approved_staking_contracts : 0x1::vector::empty<address>(),
            treasury                   : 0x2::tx_context::sender(arg1),
        };
        let v7 = 0x2::object::id<FluxVipNFTCollection>(&v6);
        let v8 = MintingCap{
            id            : 0x2::object::new(arg1),
            collection_id : v7,
        };
        let v9 = StakingManagerCap{
            id            : 0x2::object::new(arg1),
            collection_id : v7,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<FluxVipNFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<MintingCap>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<StakingManagerCap>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<FluxVipNFTCollection>(v6);
    }

    public fun is_approved_for_staking(arg0: &FluxVipNFT) : bool {
        arg0.approved_for_staking
    }

    fun is_approved_staking_contract(arg0: &FluxVipNFTCollection, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.approved_staking_contracts, &arg1)
    }

    public entry fun mint(arg0: &mut FluxVipNFTCollection, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < 300, 1);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.mint_price, 0);
        if (v0 > arg0.mint_price) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, v0 - arg0.mint_price, arg2), 0x2::tx_context::sender(arg2));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0.treasury);
        let v1 = arg0.minted + 1;
        let v2 = token_id_to_bytes(v1);
        let v3 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg2);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v3, 0x1::string::utf8(b"Membership Type"), 0x1::string::utf8(b"VIP"));
        let v4 = 0x1::string::utf8(b"FLUX VIP Membership #");
        0x1::string::append(&mut v4, 0x1::string::utf8(v2));
        let v5 = FluxVipNFT{
            id                        : 0x2::object::new(arg2),
            name                      : v4,
            description               : 0x1::string::utf8(b"The FLUX VIP Membership Pass is your exclusive gateway to the FLUX ecosystem on Sui Network. As a valued first-generation member, you enjoy premium benefits across our platform: 50% reduced trading fees, enhanced staking rewards up to 30% APR boost, priority farming yield multipliers, and early access to new features. All 300 membership passes provide identical privileges, ensuring a fair and equitable experience for everyone in our community. Your pass grants you voting rights in special governance decisions, access to exclusive events, advanced analytics tools, priority notifications, enhanced liquidity provider incentives, and first access to experimental features."),
            image_url                 : 0x2::url::new_unsafe(0x1::ascii::string(b"ipfs://bafybeibsqcl6xmbz4pjpnbio7k65dpkejyc7ylzfmqijybmipjwwx76ehq")),
            metadata_url              : 0x2::url::new_unsafe(create_ipfs_url(b"bafybeiff7c7p24lgkgkbmaw3mq75dom24xnyxpwro4dagibuosorap6ew4", v2, b".json")),
            attributes                : v3,
            token_id                  : v1,
            approved_for_staking      : false,
            approved_staking_contract : @0x0,
        };
        arg0.minted = arg0.minted + 1;
        if (arg0.minted % 50 == 0) {
            let v6 = arg0.mint_price;
            arg0.mint_price = v6 + v6 * 10 / 100;
            let v7 = PriceUpdateEvent{
                old_price : v6,
                new_price : arg0.mint_price,
            };
            0x2::event::emit<PriceUpdateEvent>(v7);
        };
        let v8 = MintEvent{
            nft_id   : 0x2::object::id<FluxVipNFT>(&v5),
            token_id : v1,
            owner    : 0x2::tx_context::sender(arg2),
            price    : arg0.mint_price,
        };
        0x2::event::emit<MintEvent>(v8);
        0x2::transfer::public_transfer<FluxVipNFT>(v5, 0x2::tx_context::sender(arg2));
    }

    public fun name_equals(arg0: &FluxVipNFTCollection, arg1: &0x1::string::String) : bool {
        &arg0.name == arg1
    }

    public entry fun place_in_kiosk(arg0: FluxVipNFT, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::kiosk::owner(arg1) == v0, 6);
        0x2::kiosk::place<FluxVipNFT>(arg1, arg2, arg0);
        let v1 = PlacedInKioskEvent{
            nft_id   : 0x2::object::id<FluxVipNFT>(&arg0),
            owner    : v0,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
        };
        0x2::event::emit<PlacedInKioskEvent>(v1);
    }

    public entry fun remove_staking_contract(arg0: &StakingManagerCap, arg1: &mut FluxVipNFTCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.approved_staking_contracts, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.approved_staking_contracts, v1);
            let v2 = StakingContractRemovedEvent{
                staking_contract : arg2,
                admin            : 0x2::tx_context::sender(arg3),
            };
            0x2::event::emit<StakingContractRemovedEvent>(v2);
        };
    }

    public entry fun take_from_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::kiosk::owner(arg0) == v0, 6);
        let v1 = 0x2::kiosk::take<FluxVipNFT>(arg0, arg1, arg2);
        let v2 = TakenFromKioskEvent{
            nft_id   : 0x2::object::id<FluxVipNFT>(&v1),
            owner    : v0,
            kiosk_id : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
        };
        0x2::event::emit<TakenFromKioskEvent>(v2);
        0x2::transfer::public_transfer<FluxVipNFT>(v1, v0);
    }

    fun token_id_to_bytes(arg0: u64) : vector<u8> {
        if (arg0 == 0) {
            return b"0"
        };
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 10;
        while (arg0 > 0) {
            let v2 = arg0 % v1;
            arg0 = arg0 / v1;
            0x1::vector::push_back<u8>(&mut v0, ((v2 + 48) as u8));
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun transfer_to_staking(arg0: FluxVipNFT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.approved_for_staking, 4);
        let v0 = arg0.approved_staking_contract;
        assert!(0x2::tx_context::sender(arg1) == v0, 3);
        arg0.approved_for_staking = false;
        arg0.approved_staking_contract = @0x0;
        0x2::transfer::public_transfer<FluxVipNFT>(arg0, v0);
        let v1 = StakingEvent{
            nft_id           : 0x2::object::id<FluxVipNFT>(&arg0),
            staking_contract : v0,
            timestamp        : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<StakingEvent>(v1);
    }

    public entry fun update_treasury(arg0: &MintingCap, arg1: &mut FluxVipNFTCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.treasury = arg2;
        let v0 = TreasuryUpdateEvent{
            old_treasury : arg1.treasury,
            new_treasury : arg2,
            admin        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TreasuryUpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

