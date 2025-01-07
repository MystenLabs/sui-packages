module 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::mint {
    struct MINT has drop {
        dummy_field: bool,
    }

    struct DestroyMintReceiptCap has key {
        id: 0x2::object::UID,
        number: u16,
    }

    struct MigrationTicket has store, key {
        id: 0x2::object::UID,
        number: u16,
    }

    struct MigrationWarehouse has key {
        id: 0x2::object::UID,
        pfps: 0x2::object_table::ObjectTable<u16, 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>,
        is_initialized: bool,
    }

    struct Mint has key {
        id: 0x2::object::UID,
        number: u16,
        pfp: 0x1::option::Option<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>,
        payment: 0x1::option::Option<0x2::coin::Coin<0x2::sui::SUI>>,
        is_revealed: bool,
        minted_by: address,
        claim_expiration_epoch: u64,
    }

    struct MintReceipt has key {
        id: 0x2::object::UID,
        number: u16,
        mint_id: 0x2::object::ID,
    }

    struct MintSettings has key {
        id: 0x2::object::UID,
        price: u64,
        phase: u8,
        status: u8,
    }

    struct MintWarehouse has key {
        id: 0x2::object::UID,
        pfps: 0x2::table_vec::TableVec<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>,
        is_initialized: bool,
    }

    struct RevealMintCap has key {
        id: 0x2::object::UID,
        number: u16,
        pfp_id: 0x2::object::ID,
        mint_id: 0x2::object::ID,
        create_image_cap_id: 0x2::object::ID,
    }

    struct WhitelistTicket has key {
        id: 0x2::object::UID,
        phase: u8,
    }

    struct MintClaimedEvent has copy, drop {
        pfp_id: 0x2::object::ID,
        pfp_number: u16,
        claimed_by: address,
        kiosk_id: 0x2::object::ID,
    }

    struct MintEvent has copy, drop {
        mint_id: 0x2::object::ID,
        pfp_id: 0x2::object::ID,
        pfp_number: u16,
        minted_by: address,
    }

    public fun admin_add_to_migration_warehouse(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: vector<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>, arg2: &mut MigrationWarehouse, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2.is_initialized == false, 13);
        while (!0x1::vector::is_empty<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&arg1)) {
            let v0 = 0x1::vector::pop_back<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg1);
            0x2::object_table::add<u16, 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg2.pfps, 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::number(&v0), v0);
        };
        if ((0x2::object_table::length<u16, 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&arg2.pfps) as u16) == 2029) {
            arg2.is_initialized = true;
        };
        0x1::vector::destroy_empty<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(arg1);
    }

    public fun admin_add_to_mint_warehouse(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: vector<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>, arg2: &mut MintWarehouse, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2.is_initialized == false, 19);
        while (!0x1::vector::is_empty<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&arg1)) {
            0x2::table_vec::push_back<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg2.pfps, 0x1::vector::pop_back<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg1));
        };
        if ((0x2::table_vec::length<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&arg2.pfps) as u16) == 1304) {
            arg2.is_initialized = true;
        };
        0x1::vector::destroy_empty<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(arg1);
    }

    public fun admin_destroy_migration_warehouse(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: MigrationWarehouse, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::object_table::is_empty<u16, 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&arg1.pfps), 14);
        assert!(arg1.is_initialized == true, 15);
        let MigrationWarehouse {
            id             : v0,
            pfps           : v1,
            is_initialized : _,
        } = arg1;
        0x2::object_table::destroy_empty<u16, 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(v1);
        0x2::object::delete(v0);
    }

    public fun admin_destroy_mint_warehouse(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: MintWarehouse, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table_vec::is_empty<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&arg1.pfps), 20);
        assert!(arg1.is_initialized == true, 21);
        let MintWarehouse {
            id             : v0,
            pfps           : v1,
            is_initialized : _,
        } = arg1;
        0x2::table_vec::destroy_empty<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(v1);
        0x2::object::delete(v0);
    }

    public fun admin_issue_migration_ticket(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: u16, arg2: address, arg3: &MigrationWarehouse, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.is_initialized == true, 12);
        assert!(0x2::object_table::contains<u16, 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&arg3.pfps, arg1), 3);
        let v0 = MigrationTicket{
            id     : 0x2::object::new(arg4),
            number : arg1,
        };
        0x2::transfer::transfer<MigrationTicket>(v0, arg2);
    }

    public fun admin_issue_whitelist_ticket(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: u8, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 1 || arg1 == 2, 11);
        let v0 = WhitelistTicket{
            id    : 0x2::object::new(arg3),
            phase : arg1,
        };
        0x2::transfer::transfer<WhitelistTicket>(v0, arg2);
    }

    public fun admin_refund_mint(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: Mint, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg5) > arg1.claim_expiration_epoch, 16);
        let v0 = DestroyMintReceiptCap{
            id     : 0x2::object::new(arg5),
            number : arg1.number,
        };
        0x2::kiosk::lock<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(arg2, arg3, arg4, 0x1::option::extract<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg1.pfp));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.payment), arg1.minted_by);
        0x2::transfer::transfer<DestroyMintReceiptCap>(v0, arg1.minted_by);
        destroy_mint_internal(arg1);
    }

    public fun admin_reveal_mint(arg0: RevealMintCap, arg1: &mut Mint, arg2: 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::image::Image) {
        assert!(arg0.mint_id == 0x2::object::id<Mint>(arg1), 7);
        0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::image::verify_image_chunks_registered(&arg2);
        0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::set_image(0x1::option::borrow_mut<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg1.pfp), arg2);
        arg1.is_revealed = true;
        let RevealMintCap {
            id                  : v0,
            number              : _,
            pfp_id              : _,
            mint_id             : _,
            create_image_cap_id : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun admin_set_mint_phase(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: u8, arg2: &mut MintSettings, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 >= 1 && arg1 <= 3, 5);
        arg2.phase = arg1;
    }

    public fun admin_set_mint_price(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: u64, arg2: &mut MintSettings, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 6);
        arg2.price = arg1;
    }

    public fun admin_set_mint_status(arg0: &0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::admin::AdminCap, arg1: u8, arg2: &mut MintSettings, arg3: &0x2::tx_context::TxContext) {
        assert!(arg2.status == 0 || arg2.status == 1, 9);
        arg2.status = arg1;
    }

    public fun claim_mint(arg0: MintReceipt, arg1: Mint, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>, arg5: &0x2::tx_context::TxContext) {
        assert!(arg0.mint_id == 0x2::object::id<Mint>(&arg1), 8);
        assert!(arg1.is_revealed == true, 22);
        let v0 = 0x1::option::extract<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg1.pfp);
        let v1 = MintClaimedEvent{
            pfp_id     : 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::id(&v0),
            pfp_number : 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::number(&v0),
            claimed_by : 0x2::tx_context::sender(arg5),
            kiosk_id   : 0x2::object::id<0x2::kiosk::Kiosk>(arg2),
        };
        0x2::event::emit<MintClaimedEvent>(v1);
        0x2::kiosk::lock<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(arg2, arg3, arg4, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x1::option::extract<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg1.payment), 0x2::tx_context::sender(arg5));
        destroy_mint_internal(arg1);
        let MintReceipt {
            id      : v2,
            number  : _,
            mint_id : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    public fun destroy_migration_ticket(arg0: MigrationTicket) {
        let MigrationTicket {
            id     : v0,
            number : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun destroy_mint_internal(arg0: Mint) {
        let Mint {
            id                     : v0,
            number                 : _,
            pfp                    : v2,
            payment                : v3,
            is_revealed            : _,
            minted_by              : _,
            claim_expiration_epoch : _,
        } = arg0;
        0x1::option::destroy_none<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(v2);
        0x1::option::destroy_none<0x2::coin::Coin<0x2::sui::SUI>>(v3);
        0x2::object::delete(v0);
    }

    public fun destroy_mint_receipt(arg0: DestroyMintReceiptCap, arg1: MintReceipt) {
        assert!(arg0.number == arg1.number, 2);
        let DestroyMintReceiptCap {
            id     : v0,
            number : _,
        } = arg0;
        0x2::object::delete(v0);
        let MintReceipt {
            id      : v2,
            number  : _,
            mint_id : _,
        } = arg1;
        0x2::object::delete(v2);
    }

    public fun destroy_whitelist_ticket(arg0: WhitelistTicket) {
        let WhitelistTicket {
            id    : v0,
            phase : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: MINT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MINT>(arg0, arg1);
        let v1 = 0x2::display::new<MigrationTicket>(&v0, arg1);
        0x2::display::add<MigrationTicket>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Prime Machin Migration Ticket #{number}"));
        0x2::display::add<MigrationTicket>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A ticket that can be used to migrate Prime Machin #{number} from ICON to Sui."));
        0x2::display::add<MigrationTicket>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<MigrationTicket>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://prime.nozomi.world/images/migration-ticket.webp"));
        0x2::display::update_version<MigrationTicket>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<MigrationTicket>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::display::new<MintReceipt>(&v0, arg1);
        0x2::display::add<MintReceipt>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Prime Machin Mint Receipt #{number}"));
        0x2::display::add<MintReceipt>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A receipt that can be used to claim Prime Machin #{number}."));
        0x2::display::add<MintReceipt>(&mut v2, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<MintReceipt>(&mut v2, 0x1::string::utf8(b"mint_id"), 0x1::string::utf8(b"{mint_id}"));
        0x2::display::add<MintReceipt>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://prime.nozomi.world/images/mint-receipt.webp"));
        0x2::display::update_version<MintReceipt>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<MintReceipt>>(v2, 0x2::tx_context::sender(arg1));
        let v3 = 0x2::display::new<WhitelistTicket>(&v0, arg1);
        0x2::display::add<WhitelistTicket>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Prime Machin Whitelist Ticket (Phase {phase})"));
        0x2::display::add<WhitelistTicket>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A Phase {phase} whitelist ticket for the Prime Machin collection by Studio Mirai."));
        0x2::display::add<WhitelistTicket>(&mut v3, 0x1::string::utf8(b"phase"), 0x1::string::utf8(b"{phase}"));
        0x2::display::add<WhitelistTicket>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://prime.nozomi.world/images/wl-ticket-phase-{phase}.webp"));
        0x2::display::update_version<WhitelistTicket>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<WhitelistTicket>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = MintSettings{
            id     : 0x2::object::new(arg1),
            price  : 0,
            phase  : 0,
            status : 0,
        };
        let v5 = MintWarehouse{
            id             : 0x2::object::new(arg1),
            pfps           : 0x2::table_vec::empty<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(arg1),
            is_initialized : false,
        };
        let v6 = MigrationWarehouse{
            id             : 0x2::object::new(arg1),
            pfps           : 0x2::object_table::new<u16, 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(arg1),
            is_initialized : false,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MigrationWarehouse>(v6);
        0x2::transfer::share_object<MintSettings>(v4);
        0x2::transfer::share_object<MintWarehouse>(v5);
    }

    public fun migration_mint(arg0: MigrationTicket, arg1: &mut MigrationWarehouse, arg2: &MintSettings, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.status == 1, 17);
        assert!(arg2.phase != 0, 18);
        let v0 = 0x2::coin::zero<0x2::sui::SUI>(arg3);
        let MigrationTicket {
            id     : v1,
            number : _,
        } = arg0;
        0x2::object::delete(v1);
        mint_internal(0x2::object_table::remove<u16, 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg1.pfps, arg0.number), v0, arg3);
    }

    fun mint_internal(arg0: 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Mint{
            id                     : 0x2::object::new(arg2),
            number                 : 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::number(&arg0),
            pfp                    : 0x1::option::none<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(),
            payment                : 0x1::option::some<0x2::coin::Coin<0x2::sui::SUI>>(arg1),
            is_revealed            : false,
            minted_by              : 0x2::tx_context::sender(arg2),
            claim_expiration_epoch : 0x2::tx_context::epoch(arg2) + 30,
        };
        let v1 = MintReceipt{
            id      : 0x2::object::new(arg2),
            number  : 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::number(&arg0),
            mint_id : 0x2::object::id<Mint>(&v0),
        };
        let v2 = 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::image::issue_create_image_cap(0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::number(&arg0), 0, 0x2::object::id<Mint>(&v0), arg2);
        let v3 = RevealMintCap{
            id                  : 0x2::object::new(arg2),
            number              : 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::number(&arg0),
            pfp_id              : 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::id(&arg0),
            mint_id             : 0x2::object::id<Mint>(&v0),
            create_image_cap_id : 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::image::create_image_cap_id(&v2),
        };
        let v4 = MintEvent{
            mint_id    : 0x2::object::id<Mint>(&v0),
            pfp_id     : 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::id(&arg0),
            pfp_number : 0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::number(&arg0),
            minted_by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<MintEvent>(v4);
        0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::set_minted_by_address(&mut arg0, 0x2::tx_context::sender(arg2));
        0x1::option::fill<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut v0.pfp, arg0);
        0x2::transfer::transfer<MintReceipt>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::transfer<RevealMintCap>(v3, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::image::CreateImageCap>(v2, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<Mint>(v0);
    }

    public fun public_mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut MintWarehouse, arg2: &MintSettings, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table_vec::length<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&arg1.pfps) > 0, 23);
        assert!(arg2.status == 1, 17);
        assert!(arg2.phase == 3, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) == arg2.price, 4);
        mint_internal(0x2::table_vec::pop_back<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg1.pfps), arg0, arg3);
    }

    public fun whitelist_mint(arg0: WhitelistTicket, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut MintWarehouse, arg3: &MintSettings, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.status == 1, 17);
        assert!(arg0.phase == arg3.phase, 10);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == arg3.price, 4);
        mint_internal(0x2::table_vec::pop_back<0xf454ecf89ef39c1d85ea15dec01655ea78f76ef12f8828722be4c344eb0a59a6::factory::Chakra>(&mut arg2.pfps), arg1, arg4);
        let WhitelistTicket {
            id    : v0,
            phase : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

