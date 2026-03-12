module 0xc6bcfc1d126b4329f190b79d31d4703923a776f498ed7ead62d4488014d69e72::referral {
    struct ProgramAdminCap has store, key {
        id: 0x2::object::UID,
        program_id: address,
    }

    struct ReferralProgram has key {
        id: 0x2::object::UID,
        creator: address,
        name: vector<u8>,
        commission_bps: u64,
        platform_fee_bps: u64,
        platform_wallet: address,
        verification_authority: address,
        total_payments: u64,
        total_referrers: u64,
        active: bool,
        created_at: u64,
    }

    struct ReferralLink has key {
        id: 0x2::object::UID,
        program_id: address,
        referrer: address,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        total_received: u64,
        referrer_claimed: u64,
        owner_claimed: u64,
        platform_claimed: u64,
        payment_count: u64,
        created_at: u64,
    }

    struct ProgramCreated has copy, drop {
        program_id: address,
        creator: address,
        name: vector<u8>,
        commission_bps: u64,
    }

    struct LinkCreated has copy, drop {
        link_id: address,
        program_id: address,
        referrer: address,
    }

    struct PaymentReceived has copy, drop {
        link_id: address,
        amount: u64,
    }

    struct NftListingCreated has copy, drop {
        listing_id: address,
        program_id: address,
        seller: address,
        price: u64,
    }

    struct NftSold has copy, drop {
        listing_id: address,
        buyer: address,
        seller: address,
        price: u64,
        referrer_share: u64,
    }

    struct NftListing has key {
        id: 0x2::object::UID,
        program_id: address,
        seller: address,
        price: u64,
        active: bool,
        created_at: u64,
    }

    entry fun buy_nft<T0: store + key>(arg0: NftListing, arg1: &ReferralProgram, arg2: &mut ReferralLink, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 10);
        assert!(arg2.program_id == 0x2::object::uid_to_address(&arg1.id), 7);
        assert!(arg0.program_id == 0x2::object::uid_to_address(&arg1.id), 7);
        let v0 = arg0.price;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= v0, 12);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = arg0.seller;
        let v3 = v0 * arg1.commission_bps / 10000;
        let v4 = v0 - v3;
        let v5 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v4), arg4), v2);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v5, v3), arg4), arg2.referrer);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v5, arg4), v1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v5);
        };
        arg2.total_received = arg2.total_received + v0;
        arg2.referrer_claimed = arg2.referrer_claimed + v3;
        arg2.owner_claimed = arg2.owner_claimed + v4;
        arg2.payment_count = arg2.payment_count + 1;
        let v6 = NftSold{
            listing_id     : 0x2::object::uid_to_address(&arg0.id),
            buyer          : v1,
            seller         : v2,
            price          : v0,
            referrer_share : v3,
        };
        0x2::event::emit<NftSold>(v6);
        let NftListing {
            id         : v7,
            program_id : _,
            seller     : _,
            price      : _,
            active     : _,
            created_at : _,
        } = arg0;
        let v13 = v7;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut v13, b"nft"), v1);
        0x2::object::delete(v13);
    }

    entry fun buy_nft_direct<T0: store + key>(arg0: NftListing, arg1: &ReferralProgram, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 10);
        assert!(arg0.program_id == 0x2::object::uid_to_address(&arg1.id), 7);
        let v0 = arg0.price;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 12);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = arg0.seller;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v0), arg3), v2);
        if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3), v1);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
        let v4 = NftSold{
            listing_id     : 0x2::object::uid_to_address(&arg0.id),
            buyer          : v1,
            seller         : v2,
            price          : v0,
            referrer_share : 0,
        };
        0x2::event::emit<NftSold>(v4);
        let NftListing {
            id         : v5,
            program_id : _,
            seller     : _,
            price      : _,
            active     : _,
            created_at : _,
        } = arg0;
        let v11 = v5;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut v11, b"nft"), v1);
        0x2::object::delete(v11);
    }

    entry fun claim_owner(arg0: &ReferralProgram, arg1: &mut ReferralLink, arg2: &ProgramAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.program_id == 0x2::object::uid_to_address(&arg0.id), 7);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.vault);
        assert!(v0 > 0, 6);
        let v1 = v0 - v0 * arg0.commission_bps / 10000 - v0 * arg0.platform_fee_bps / 10000;
        assert!(v1 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v1), arg3), arg0.creator);
        arg1.owner_claimed = arg1.owner_claimed + v1;
    }

    entry fun claim_referrer(arg0: &ReferralProgram, arg1: &mut ReferralLink, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.referrer, 7);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg1.vault);
        assert!(v1 > 0, 6);
        let v2 = v1 * arg0.commission_bps / 10000;
        assert!(v2 > 0, 6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v2), arg2), v0);
        arg1.referrer_claimed = arg1.referrer_claimed + v2;
    }

    entry fun close_link(arg0: &mut ReferralProgram, arg1: ReferralLink, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.referrer || v0 == arg0.creator, 7);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.vault) == 0, 8);
        arg0.total_referrers = arg0.total_referrers - 1;
        let ReferralLink {
            id               : v1,
            program_id       : _,
            referrer         : _,
            vault            : v4,
            total_received   : _,
            referrer_claimed : _,
            owner_claimed    : _,
            platform_claimed : _,
            payment_count    : _,
            created_at       : _,
        } = arg1;
        0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
        0x2::object::delete(v1);
    }

    entry fun close_program(arg0: ProgramAdminCap, arg1: ReferralProgram, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.program_id == 0x2::object::uid_to_address(&arg1.id), 7);
        assert!(arg1.total_referrers == 0, 9);
        let ProgramAdminCap {
            id         : v0,
            program_id : _,
        } = arg0;
        0x2::object::delete(v0);
        let ReferralProgram {
            id                     : v2,
            creator                : _,
            name                   : _,
            commission_bps         : _,
            platform_fee_bps       : _,
            platform_wallet        : _,
            verification_authority : _,
            total_payments         : _,
            total_referrers        : _,
            active                 : _,
            created_at             : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    entry fun create_program(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: address, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) > 0, 0);
        assert!(arg1 >= 1 && arg1 <= 5000, 1);
        assert!(arg2 <= 1000, 2);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = ReferralProgram{
            id                     : 0x2::object::new(arg5),
            creator                : v0,
            name                   : arg0,
            commission_bps         : arg1,
            platform_fee_bps       : arg2,
            platform_wallet        : arg3,
            verification_authority : arg4,
            total_payments         : 0,
            total_referrers        : 0,
            active                 : true,
            created_at             : 0x2::tx_context::epoch(arg5),
        };
        let v2 = 0x2::object::uid_to_address(&v1.id);
        let v3 = ProgramAdminCap{
            id         : 0x2::object::new(arg5),
            program_id : v2,
        };
        let v4 = ProgramCreated{
            program_id     : v2,
            creator        : v0,
            name           : v1.name,
            commission_bps : arg1,
        };
        0x2::event::emit<ProgramCreated>(v4);
        0x2::transfer::share_object<ReferralProgram>(v1);
        0x2::transfer::transfer<ProgramAdminCap>(v3, v0);
    }

    entry fun delist_nft<T0: store + key>(arg0: NftListing, arg1: &ProgramAdminCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.program_id == arg0.program_id, 13);
        assert!(arg0.active, 10);
        let NftListing {
            id         : v0,
            program_id : _,
            seller     : _,
            price      : _,
            active     : _,
            created_at : _,
        } = arg0;
        let v6 = v0;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut v6, b"nft"), arg0.seller);
        0x2::object::delete(v6);
    }

    entry fun distribute(arg0: &ReferralProgram, arg1: &mut ReferralLink, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.vault);
        assert!(v0 > 0, 6);
        let v1 = v0 * arg0.commission_bps / 10000;
        let v2 = v0 * arg0.platform_fee_bps / 10000;
        let v3 = v0 - v1 - v2;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v1), arg2), arg1.referrer);
            arg1.referrer_claimed = arg1.referrer_claimed + v1;
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v2), arg2), arg0.platform_wallet);
            arg1.platform_claimed = arg1.platform_claimed + v2;
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v3), arg2), arg0.creator);
            arg1.owner_claimed = arg1.owner_claimed + v3;
        };
    }

    public fun get_commission_bps(arg0: &ReferralProgram) : u64 {
        arg0.commission_bps
    }

    public fun get_link_referrer(arg0: &ReferralLink) : address {
        arg0.referrer
    }

    public fun get_link_vault_balance(arg0: &ReferralLink) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    public fun get_program_creator(arg0: &ReferralProgram) : address {
        arg0.creator
    }

    public fun get_program_name(arg0: &ReferralProgram) : vector<u8> {
        arg0.name
    }

    public fun get_total_referrers(arg0: &ReferralProgram) : u64 {
        arg0.total_referrers
    }

    public fun is_active(arg0: &ReferralProgram) : bool {
        arg0.active
    }

    entry fun join_program(arg0: &mut ReferralProgram, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 3);
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::uid_to_address(&arg0.id);
        let v2 = ReferralLink{
            id               : 0x2::object::new(arg1),
            program_id       : v1,
            referrer         : v0,
            vault            : 0x2::balance::zero<0x2::sui::SUI>(),
            total_received   : 0,
            referrer_claimed : 0,
            owner_claimed    : 0,
            platform_claimed : 0,
            payment_count    : 0,
            created_at       : 0x2::tx_context::epoch(arg1),
        };
        arg0.total_referrers = arg0.total_referrers + 1;
        let v3 = LinkCreated{
            link_id    : 0x2::object::uid_to_address(&v2.id),
            program_id : v1,
            referrer   : v0,
        };
        0x2::event::emit<LinkCreated>(v3);
        0x2::transfer::share_object<ReferralLink>(v2);
    }

    entry fun list_nft<T0: store + key>(arg0: &ReferralProgram, arg1: &ProgramAdminCap, arg2: T0, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.program_id == 0x2::object::uid_to_address(&arg0.id), 13);
        assert!(arg3 > 0, 11);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = NftListing{
            id         : 0x2::object::new(arg4),
            program_id : 0x2::object::uid_to_address(&arg0.id),
            seller     : v0,
            price      : arg3,
            active     : true,
            created_at : 0x2::tx_context::epoch(arg4),
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v1.id, b"nft", arg2);
        let v2 = NftListingCreated{
            listing_id : 0x2::object::uid_to_address(&v1.id),
            program_id : 0x2::object::uid_to_address(&arg0.id),
            seller     : v0,
            price      : arg3,
        };
        0x2::event::emit<NftListingCreated>(v2);
        0x2::transfer::share_object<NftListing>(v1);
    }

    entry fun pause_program(arg0: &ProgramAdminCap, arg1: &mut ReferralProgram, arg2: bool) {
        assert!(arg0.program_id == 0x2::object::uid_to_address(&arg1.id), 7);
        if (arg2) {
            assert!(arg1.active, 4);
            arg1.active = false;
        } else {
            assert!(!arg1.active, 5);
            arg1.active = true;
        };
    }

    entry fun pay(arg0: &mut ReferralLink, arg1: &mut ReferralProgram, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        arg0.total_received = arg0.total_received + v0;
        arg0.payment_count = arg0.payment_count + 1;
        arg1.total_payments = arg1.total_payments + 1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = PaymentReceived{
            link_id : 0x2::object::uid_to_address(&arg0.id),
            amount  : v0,
        };
        0x2::event::emit<PaymentReceived>(v1);
    }

    entry fun update_listing_price(arg0: &mut NftListing, arg1: &ProgramAdminCap, arg2: u64) {
        assert!(arg1.program_id == arg0.program_id, 13);
        assert!(arg0.active, 10);
        assert!(arg2 > 0, 11);
        arg0.price = arg2;
    }

    // decompiled from Move bytecode v6
}

