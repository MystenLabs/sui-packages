module 0xa6553b86fae037ffcc60a6df0bdf3019d441e01a14fccf0fbe75a52c14bd254e::minter {
    struct MINTER has drop {
        dummy_field: bool,
    }

    struct NameService has store, key {
        id: 0x2::object::UID,
        names: vector<vector<u8>>,
        company_wallet: address,
        company_second_wallet_for_verification: address,
        activated: bool,
        paused: bool,
        pending_wallet_update: 0x1::option::Option<address>,
        pending_wallet_verification: bool,
        pending_admin_transfer: 0x1::option::Option<PendingAdminTransfer>,
        pending_admin_transfer_verification: bool,
    }

    struct AdminCapability has key {
        id: 0x2::object::UID,
    }

    struct NameMinted has copy, drop {
        name: vector<u8>,
        owner: address,
    }

    struct NameBurned has copy, drop {
        name: vector<u8>,
        owner: address,
    }

    struct NameNFT has key {
        id: 0x2::object::UID,
        name: vector<u8>,
        owner: address,
    }

    struct NameTransferred has copy, drop {
        name: vector<u8>,
        from: address,
        to: address,
    }

    struct WalletUpdated has copy, drop {
        old_wallet: address,
        new_wallet: address,
        update_time: u64,
    }

    struct PendingAdminTransfer has drop, store {
        new_admin: address,
    }

    struct AdminTransferred has copy, drop {
        old_admin: address,
        new_admin: address,
        transfer_time: u64,
    }

    public entry fun activate_name_service(arg0: &AdminCapability, arg1: address, arg2: address, arg3: &mut NameService, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg3.activated, 2);
        assert!(arg1 != arg2, 0);
        arg3.company_wallet = arg1;
        arg3.company_second_wallet_for_verification = arg2;
        arg3.activated = true;
    }

    fun burn_name_internal(arg0: NameNFT, arg1: &mut NameService, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.paused, 9);
        assert!(arg1.activated, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 11);
        let (v1, v2) = 0x1::vector::index_of<vector<u8>>(&arg1.names, &arg0.name);
        assert!(v1, 5);
        0x1::vector::remove<vector<u8>>(&mut arg1.names, v2);
        let v3 = NameBurned{
            name  : arg0.name,
            owner : v0,
        };
        0x2::event::emit<NameBurned>(v3);
        let NameNFT {
            id    : v4,
            name  : _,
            owner : _,
        } = arg0;
        0x2::object::delete(v4);
    }

    public entry fun burn_name_without_fee(arg0: &AdminCapability, arg1: NameNFT, arg2: &mut NameService, arg3: &mut 0x2::tx_context::TxContext) {
        burn_name_internal(arg1, arg2, arg3);
    }

    public entry fun complete_admin_transfer(arg0: &AdminCapability, arg1: &mut NameService, arg2: AdminCapability, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.activated, 1);
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg1.pending_admin_transfer), 12);
        assert!(arg1.pending_admin_transfer_verification, 12);
        let v0 = 0x1::option::extract<PendingAdminTransfer>(&mut arg1.pending_admin_transfer);
        0x2::transfer::transfer<AdminCapability>(arg2, v0.new_admin);
        let v1 = AdminTransferred{
            old_admin     : 0x2::tx_context::sender(arg3),
            new_admin     : v0.new_admin,
            transfer_time : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<AdminTransferred>(v1);
        arg1.pending_admin_transfer = 0x1::option::none<PendingAdminTransfer>();
        arg1.pending_admin_transfer_verification = false;
    }

    public entry fun complete_wallet_update_by_company_second_wallet(arg0: &mut NameService, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.activated, 1);
        assert!(0x1::option::is_some<address>(&arg0.pending_wallet_update), 0);
        assert!(arg0.pending_wallet_verification, 0);
        assert!(0x2::tx_context::sender(arg1) == arg0.company_second_wallet_for_verification, 0);
        let v0 = 0x1::option::extract<address>(&mut arg0.pending_wallet_update);
        arg0.company_wallet = v0;
        arg0.pending_wallet_update = 0x1::option::none<address>();
        arg0.pending_wallet_verification = false;
        let v1 = WalletUpdated{
            old_wallet  : arg0.company_wallet,
            new_wallet  : v0,
            update_time : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<WalletUpdated>(v1);
    }

    fun init(arg0: MINTER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = NameService{
            id                                     : 0x2::object::new(arg1),
            names                                  : 0x1::vector::empty<vector<u8>>(),
            company_wallet                         : v0,
            company_second_wallet_for_verification : v0,
            activated                              : false,
            paused                                 : false,
            pending_wallet_update                  : 0x1::option::none<address>(),
            pending_wallet_verification            : false,
            pending_admin_transfer                 : 0x1::option::none<PendingAdminTransfer>(),
            pending_admin_transfer_verification    : false,
        };
        let v2 = AdminCapability{id: 0x2::object::new(arg1)};
        let v3 = 0x2::package::claim<MINTER>(arg0, arg1);
        let v4 = 0x2::display::new<NameNFT>(&v3, arg1);
        0x2::display::add<NameNFT>(&mut v4, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Moseiki App handle"));
        0x2::display::add<NameNFT>(&mut v4, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://moseiki.app/_next/image?url=%2Flogo.svg&w=256&q=75"));
        0x2::display::add<NameNFT>(&mut v4, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://moseiki.app"));
        0x2::display::add<NameNFT>(&mut v4, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Moseiki App"));
        0x2::display::add<NameNFT>(&mut v4, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://moseiki.app/?loginRedirect=/claim-handle?search={id}"));
        0x2::display::update_version<NameNFT>(&mut v4);
        0x2::transfer::transfer<AdminCapability>(v2, v0);
        0x2::transfer::public_transfer<0x2::display::Display<NameNFT>>(v4, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v3, v0);
        0x2::transfer::share_object<NameService>(v1);
    }

    public entry fun initiate_admin_transfer(arg0: &mut NameService, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.activated, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.company_wallet, 11);
        assert!(arg1 != v0, 13);
        assert!(arg1 != arg0.company_second_wallet_for_verification, 13);
        let v1 = PendingAdminTransfer{new_admin: arg1};
        arg0.pending_admin_transfer = 0x1::option::some<PendingAdminTransfer>(v1);
        arg0.pending_admin_transfer_verification = false;
    }

    public entry fun initiate_wallet_update_by_admin(arg0: &AdminCapability, arg1: &mut NameService, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.activated, 1);
        assert!(arg2 != 0x2::tx_context::sender(arg3), 0);
        assert!(arg2 != arg1.company_second_wallet_for_verification, 0);
        arg1.pending_wallet_update = 0x1::option::some<address>(arg2);
        arg1.pending_wallet_verification = false;
    }

    public entry fun is_activated(arg0: &NameService) : bool {
        arg0.activated
    }

    public entry fun is_name_minted(arg0: vector<u8>, arg1: &NameService) : bool {
        assert!(!arg1.paused, 9);
        assert!(arg1.activated, 1);
        0x1::vector::contains<vector<u8>>(&arg1.names, &arg0)
    }

    fun mint_name_internal(arg0: vector<u8>, arg1: address, arg2: &mut NameService, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.paused, 9);
        assert!(arg2.activated, 1);
        assert!(!0x1::vector::contains<vector<u8>>(&arg2.names, &arg0), 4);
        assert!(0x1::vector::length<u8>(&arg0) <= 256, 7);
        assert!(0x1::vector::length<u8>(&arg0) >= 1, 8);
        let v0 = 0x1::string::try_utf8(arg0);
        assert!(0x1::option::is_some<0x1::string::String>(&v0), 10);
        let v1 = NameNFT{
            id    : 0x2::object::new(arg3),
            name  : arg0,
            owner : arg1,
        };
        0x1::vector::push_back<vector<u8>>(&mut arg2.names, arg0);
        0x2::transfer::transfer<NameNFT>(v1, arg1);
        let v2 = NameMinted{
            name  : arg0,
            owner : arg1,
        };
        0x2::event::emit<NameMinted>(v2);
    }

    public entry fun mint_name_without_fee(arg0: &AdminCapability, arg1: vector<u8>, arg2: address, arg3: &mut NameService, arg4: &mut 0x2::tx_context::TxContext) {
        mint_name_internal(arg1, arg2, arg3, arg4);
    }

    public entry fun pause_service(arg0: &AdminCapability, arg1: &mut NameService) {
        arg1.paused = true;
    }

    fun transfer_name_internal(arg0: NameNFT, arg1: address, arg2: &mut NameService, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg2.paused, 9);
        assert!(arg2.activated, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.owner == v0, 11);
        arg0.owner = arg1;
        0x2::transfer::transfer<NameNFT>(arg0, arg1);
        let v1 = NameTransferred{
            name : arg0.name,
            from : v0,
            to   : arg1,
        };
        0x2::event::emit<NameTransferred>(v1);
    }

    public entry fun transfer_name_without_fee(arg0: &AdminCapability, arg1: NameNFT, arg2: address, arg3: &mut NameService, arg4: &mut 0x2::tx_context::TxContext) {
        transfer_name_internal(arg1, arg2, arg3, arg4);
    }

    public entry fun unpause_service(arg0: &AdminCapability, arg1: &mut NameService) {
        arg1.paused = false;
    }

    public entry fun update_display(arg0: &AdminCapability, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new<NameNFT>(arg1, arg2);
        0x2::display::add<NameNFT>(&mut v0, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Moseiki App handle"));
        0x2::display::add<NameNFT>(&mut v0, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://moseiki.app/_next/image?url=%2Flogo.svg&w=256&q=75"));
        0x2::display::add<NameNFT>(&mut v0, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://moseiki.app"));
        0x2::display::add<NameNFT>(&mut v0, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Moseiki App"));
        0x2::display::add<NameNFT>(&mut v0, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://moseiki.app/?loginRedirect=/claim-handle?search={id}"));
        0x2::display::update_version<NameNFT>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<NameNFT>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun verify_admin_transfer(arg0: &mut NameService, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.activated, 1);
        assert!(0x1::option::is_some<PendingAdminTransfer>(&arg0.pending_admin_transfer), 12);
        assert!(0x2::tx_context::sender(arg1) == arg0.company_second_wallet_for_verification, 11);
        arg0.pending_admin_transfer_verification = true;
    }

    public entry fun verify_wallet_update_by_company_wallet(arg0: &mut NameService, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.activated, 1);
        assert!(0x1::option::is_some<address>(&arg0.pending_wallet_update), 0);
        assert!(0x2::tx_context::sender(arg1) == arg0.company_wallet, 0);
        arg0.pending_wallet_verification = true;
    }

    // decompiled from Move bytecode v6
}

