module 0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::ob_kiosk {
    struct VersionDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct OwnerToken has key {
        id: 0x2::object::UID,
        kiosk: 0x2::object::ID,
        owner: address,
    }

    struct NftRef has drop, store {
        auths: 0x2::vec_set::VecSet<address>,
        is_exclusively_listed: bool,
    }

    struct DepositSetting has drop, store {
        enable_any_deposit: bool,
        collections_with_enabled_deposits: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct NftRefsDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct KioskOwnerCapDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DepositSettingDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthTransferRequestDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OB_KIOSK has drop {
        dummy_field: bool,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::object::ID) {
        let v0 = 0x2::tx_context::sender(arg0);
        new_for_address(v0, arg0)
    }

    public fun assert_can_deposit<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(can_deposit<T0>(arg0, arg1), 11);
    }

    public fun assert_can_deposit_permissionlessly<T0>(arg0: &mut 0x2::kiosk::Kiosk) {
        assert!(can_deposit_permissionlessly<T0>(arg0), 4);
    }

    public fun assert_has_nft(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) {
        assert!(0x2::kiosk::has_item(arg0, arg1), 1);
    }

    public fun assert_is_ob_kiosk(arg0: &mut 0x2::kiosk::Kiosk) {
        assert!(is_ob_kiosk(arg0), 5);
    }

    public fun assert_kiosk_id(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) {
        assert!(0x2::object::id<0x2::kiosk::Kiosk>(arg0) == arg1, 6);
    }

    public fun assert_missing_ref(arg0: &0x2::table::Table<0x2::object::ID, NftRef>, arg1: 0x2::object::ID) {
        assert!(!0x2::table::contains<0x2::object::ID, NftRef>(arg0, arg1), 1);
    }

    public fun assert_nft_type<T0: store + key>(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) {
        assert!(0x2::kiosk::has_item_with_type<T0>(arg0, arg1), 10);
    }

    public fun assert_not_exclusively_listed(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID) {
        let v0 = NftRefsDfKey{dummy_field: false};
        assert_ref_not_exclusively_listed(0x2::table::borrow<0x2::object::ID, NftRef>(0x2::dynamic_field::borrow<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(0x2::kiosk::uid_mut(arg0), v0), arg1));
    }

    public fun assert_not_listed(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID) {
        let v0 = NftRefsDfKey{dummy_field: false};
        assert_ref_not_listed(0x2::table::borrow<0x2::object::ID, NftRef>(0x2::dynamic_field::borrow<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(0x2::kiosk::uid_mut(arg0), v0), arg1));
    }

    public fun assert_owner_address(arg0: &0x2::kiosk::Kiosk, arg1: address) {
        assert!(0x2::kiosk::owner(arg0) == arg1, 7);
    }

    public fun assert_permission(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::owner(arg0);
        assert!(v0 == @0xb || v0 == 0x2::tx_context::sender(arg1), 7);
    }

    fun assert_ref_not_exclusively_listed(arg0: &NftRef) {
        assert!(!arg0.is_exclusively_listed, 2);
    }

    fun assert_ref_not_listed(arg0: &NftRef) {
        assert!(0x2::vec_set::size<address>(&arg0.auths) == 0, 3);
    }

    fun assert_version(arg0: &0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<VersionDfKey, u64>(arg0, v0) == 1, 1000);
    }

    public fun auth_exclusive_transfer(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::object::UID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, NftRef>(nft_refs_mut(arg0), arg1);
        assert_ref_not_listed(v0);
        0x2::vec_set::insert<address>(&mut v0.auths, 0x2::object::uid_to_address(arg2));
        v0.is_exclusively_listed = true;
    }

    public fun auth_transfer(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, NftRef>(nft_refs_mut(arg0), arg1);
        assert_ref_not_exclusively_listed(v0);
        0x2::vec_set::insert<address>(&mut v0.auths, arg2);
    }

    public fun borrow_nft_mut<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x1::type_name::TypeName>, arg3: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<Witness, T0> {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_not_listed(arg0, arg1);
        let v0 = pop_cap(arg0);
        let (v1, v2) = 0x2::kiosk::borrow_val<T0>(arg0, &v0, arg1);
        set_cap(arg0, v0);
        let v3 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::new<Witness, T0>(v3, v1, 0x2::tx_context::sender(arg3), arg2, v2, arg3)
    }

    public fun can_deposit<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg1) == 0x2::kiosk::owner(arg0) || can_deposit_permissionlessly<T0>(arg0)
    }

    public fun can_deposit_permissionlessly<T0>(arg0: &mut 0x2::kiosk::Kiosk) : bool {
        if (0x2::kiosk::owner(arg0) == @0xb) {
            return true
        };
        let v0 = deposit_setting_mut(arg0);
        if (v0.enable_any_deposit) {
            true
        } else {
            let v2 = 0x1::type_name::get<T0>();
            0x2::vec_set::contains<0x1::type_name::TypeName>(&v0.collections_with_enabled_deposits, &v2)
        }
    }

    fun check_entity_and_pop_ref(arg0: &mut 0x2::kiosk::Kiosk, arg1: address, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = nft_refs_mut(arg0);
        let v1 = 0x2::table::remove<0x2::object::ID, NftRef>(v0, arg2);
        assert!(0x2::tx_context::sender(arg3) == 0x2::kiosk::owner(arg0) || 0x2::vec_set::contains<address>(&v1.auths, &arg1), 8);
    }

    public fun create_for_address(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = new_for_address(arg0, arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        (0x2::object::id<0x2::kiosk::Kiosk>(&v2), v1)
    }

    public fun create_for_sender(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = new(arg0);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        (0x2::object::id<0x2::kiosk::Kiosk>(&v2), v1)
    }

    public fun create_permissionless(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_permissionless(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::object::id<0x2::kiosk::Kiosk>(&v0)
    }

    public fun delist_nft_as_owner(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg2);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, NftRef>(nft_refs_mut(arg0), arg1);
        assert_ref_not_exclusively_listed(v0);
        v0.auths = 0x2::vec_set::empty<address>();
    }

    public entry fun deposit<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_can_deposit<T0>(arg0, arg2);
        let v0 = nft_refs_mut(arg0);
        let v1 = NftRef{
            auths                 : 0x2::vec_set::empty<address>(),
            is_exclusively_listed : false,
        };
        0x2::table::add<0x2::object::ID, NftRef>(v0, 0x2::object::id<T0>(&arg1), v1);
        let v2 = pop_cap(arg0);
        0x2::kiosk::place<T0>(arg0, &v2, arg1);
        set_cap(arg0, v2);
    }

    public fun deposit_batch<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_can_deposit<T0>(arg0, arg2);
        let v0 = pop_cap(arg0);
        let v1 = 0x1::vector::length<T0>(&arg1);
        while (v1 > 0) {
            let v2 = 0x1::vector::pop_back<T0>(&mut arg1);
            let v3 = nft_refs_mut(arg0);
            let v4 = NftRef{
                auths                 : 0x2::vec_set::empty<address>(),
                is_exclusively_listed : false,
            };
            0x2::table::add<0x2::object::ID, NftRef>(v3, 0x2::object::id<T0>(&v2), v4);
            0x2::kiosk::place<T0>(arg0, &v0, v2);
            v1 = v1 - 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
        set_cap(arg0, v0);
    }

    fun deposit_setting_mut(arg0: &mut 0x2::kiosk::Kiosk) : &mut DepositSetting {
        let v0 = DepositSettingDfKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<DepositSettingDfKey, DepositSetting>(0x2::kiosk::uid_mut(arg0), v0)
    }

    public entry fun disable_deposits_of_collection<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg1);
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut deposit_setting_mut(arg0).collections_with_enabled_deposits, &v0);
    }

    public entry fun enable_any_deposit(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg1);
        deposit_setting_mut(arg0).enable_any_deposit = true;
    }

    public entry fun enable_deposits_of_collection<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        assert_permission(arg0, arg1);
        assert_version(0x2::kiosk::uid_mut(arg0));
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut deposit_setting_mut(arg0).collections_with_enabled_deposits, 0x1::type_name::get<T0>());
    }

    fun get_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        check_entity_and_pop_ref(arg0, arg2, arg1, arg3);
        let v0 = pop_cap(arg0);
        let v1 = 0x2::kiosk::take<T0>(arg0, &v0, arg1);
        set_cap(arg0, v0);
        v1
    }

    public fun get_transfer_request_auth<T0>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>) : &0x1::type_name::TypeName {
        let v0 = AuthTransferRequestDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<AuthTransferRequestDfKey, 0x1::type_name::TypeName>(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::metadata<T0>(arg0), v0)
    }

    public fun get_transfer_request_auth_<T0, T1>(arg0: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::RequestBody<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>) : &0x1::type_name::TypeName {
        let v0 = AuthTransferRequestDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<AuthTransferRequestDfKey, 0x1::type_name::TypeName>(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::metadata<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>(arg0), v0)
    }

    fun init(arg0: OB_KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<OB_KIOSK>(arg0, arg1);
        let v1 = 0x2::display::new<OwnerToken>(&v0, arg1);
        0x2::display::add<OwnerToken>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Originbyte Kiosk"));
        0x2::display::add<OwnerToken>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://docs.originbyte.io"));
        0x2::display::add<OwnerToken>(&mut v1, 0x1::string::utf8(b"owner"), 0x1::string::utf8(b"{owner}"));
        0x2::display::add<OwnerToken>(&mut v1, 0x1::string::utf8(b"kiosk"), 0x1::string::utf8(b"{kiosk}"));
        0x2::display::add<OwnerToken>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Stores NFTs, manages listings, sales and more!"));
        0x2::display::update_version<OwnerToken>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<OwnerToken>>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::burn_publisher(v0);
    }

    public entry fun init_for_address(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let (_, _) = create_for_address(arg0, arg1);
    }

    public entry fun init_for_sender(arg0: &mut 0x2::tx_context::TxContext) {
        let (_, _) = create_for_sender(arg0);
    }

    public entry fun init_permissionless(arg0: &mut 0x2::tx_context::TxContext) {
        create_permissionless(arg0);
    }

    public entry fun install_extension(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        let v1 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::add<VersionDfKey, u64>(v0, v1, 1);
        let v2 = KioskOwnerCapDfKey{dummy_field: false};
        0x2::dynamic_field::add<KioskOwnerCapDfKey, 0x2::kiosk::KioskOwnerCap>(v0, v2, arg1);
        let v3 = NftRefsDfKey{dummy_field: false};
        0x2::dynamic_field::add<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(v0, v3, 0x2::table::new<0x2::object::ID, NftRef>(arg2));
        let v4 = DepositSettingDfKey{dummy_field: false};
        let v5 = DepositSetting{
            enable_any_deposit                : true,
            collections_with_enabled_deposits : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::dynamic_field::add<DepositSettingDfKey, DepositSetting>(v0, v4, v5);
        let v6 = OwnerToken{
            id    : 0x2::object::new(arg2),
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            owner : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::transfer<OwnerToken>(v6, 0x2::tx_context::sender(arg2));
    }

    public fun is_ob_kiosk(arg0: &mut 0x2::kiosk::Kiosk) : bool {
        let v0 = NftRefsDfKey{dummy_field: false};
        0x2::dynamic_field::exists_<NftRefsDfKey>(0x2::kiosk::uid_mut(arg0), v0)
    }

    entry fun migrate(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        assert_permission(arg0, arg1);
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(0x2::kiosk::uid_mut(arg0), v0);
        assert!(*v1 < 1, 999);
        *v1 = 1;
    }

    entry fun migrate_as_pub(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::kiosk::KIOSK>(arg1), 0);
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(0x2::kiosk::uid_mut(arg0), v0);
        assert!(*v1 < 1, 999);
        *v1 = 1;
    }

    fun new_(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::Kiosk {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk::set_owner_custom(&mut v3, &v2, arg0);
        let v4 = 0x2::kiosk::uid_mut(&mut v3);
        let v5 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::add<VersionDfKey, u64>(v4, v5, 1);
        let v6 = KioskOwnerCapDfKey{dummy_field: false};
        0x2::dynamic_field::add<KioskOwnerCapDfKey, 0x2::kiosk::KioskOwnerCap>(v4, v6, v2);
        let v7 = NftRefsDfKey{dummy_field: false};
        0x2::dynamic_field::add<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(v4, v7, 0x2::table::new<0x2::object::ID, NftRef>(arg1));
        let v8 = DepositSettingDfKey{dummy_field: false};
        let v9 = DepositSetting{
            enable_any_deposit                : true,
            collections_with_enabled_deposits : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::dynamic_field::add<DepositSettingDfKey, DepositSetting>(v4, v8, v9);
        v3
    }

    public fun new_for_address(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::object::ID) {
        let v0 = new_(arg0, arg1);
        let v1 = 0x2::object::new(arg1);
        let v2 = OwnerToken{
            id    : v1,
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(&v0),
            owner : arg0,
        };
        0x2::transfer::transfer<OwnerToken>(v2, arg0);
        (v0, 0x2::object::uid_to_inner(&v1))
    }

    public fun new_permissionless(arg0: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::Kiosk {
        new_(@0xb, arg0)
    }

    fun nft_refs_mut(arg0: &mut 0x2::kiosk::Kiosk) : &mut 0x2::table::Table<0x2::object::ID, NftRef> {
        let v0 = NftRefsDfKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(0x2::kiosk::uid_mut(arg0), v0)
    }

    entry fun p2p_transfer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg3);
        let v0 = NftRefsDfKey{dummy_field: false};
        let v1 = 0x2::table::remove<0x2::object::ID, NftRef>(0x2::dynamic_field::borrow_mut<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(0x2::kiosk::uid_mut(arg0), v0), arg2);
        assert_ref_not_exclusively_listed(&v1);
        let v2 = pop_cap(arg0);
        let v3 = 0x2::kiosk::take<T0>(arg0, &v2, arg2);
        set_cap(arg0, v2);
        deposit<T0>(arg1, v3, arg3);
    }

    entry fun p2p_transfer_and_create_target_kiosk<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: address, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = new_for_address(arg1, arg3);
        let v2 = v0;
        let v3 = &mut v2;
        p2p_transfer<T0>(arg0, v3, arg2, arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        (0x2::object::id<0x2::kiosk::Kiosk>(&v2), v1)
    }

    fun pop_cap(arg0: &mut 0x2::kiosk::Kiosk) : 0x2::kiosk::KioskOwnerCap {
        let v0 = KioskOwnerCapDfKey{dummy_field: false};
        0x2::dynamic_field::remove<KioskOwnerCapDfKey, 0x2::kiosk::KioskOwnerCap>(0x2::kiosk::uid_mut(arg0), v0)
    }

    public entry fun register_nft<T0: key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg2);
        assert_has_nft(arg0, arg1);
        assert!(!0x2::kiosk::is_listed(arg0, arg1), 12);
        let v0 = nft_refs_mut(arg0);
        assert_missing_ref(v0, arg1);
        let v1 = NftRef{
            auths                 : 0x2::vec_set::empty<address>(),
            is_exclusively_listed : false,
        };
        0x2::table::add<0x2::object::ID, NftRef>(v0, arg1, v1);
    }

    public fun remove_auth_transfer(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::object::UID) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        let v0 = 0x2::object::uid_to_address(arg2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, NftRef>(nft_refs_mut(arg0), arg1);
        0x2::vec_set::remove<address>(&mut v1.auths, &v0);
        v1.is_exclusively_listed = false;
    }

    public fun remove_auth_transfer_as_owner(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, NftRef>(nft_refs_mut(arg0), arg1);
        assert_ref_not_exclusively_listed(v0);
        0x2::vec_set::remove<address>(&mut v0.auths, &arg2);
    }

    public entry fun restrict_deposits(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg1);
        deposit_setting_mut(arg0).enable_any_deposit = false;
    }

    public fun return_nft<T0: drop, T1: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<Witness, T1>, arg2: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T1, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        let v0 = Witness{dummy_field: false};
        let (v1, v2) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::confirm<Witness, T1>(v0, arg1, arg2);
        let v3 = pop_cap(arg0);
        0x2::kiosk::return_val<T1>(arg0, v1, v2);
        set_cap(arg0, v3);
    }

    fun set_cap(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap) {
        let v0 = KioskOwnerCapDfKey{dummy_field: false};
        0x2::dynamic_field::add<KioskOwnerCapDfKey, 0x2::kiosk::KioskOwnerCap>(0x2::kiosk::uid_mut(arg0), v0, arg1);
    }

    public entry fun set_permissionless_to_permissioned(arg0: &mut 0x2::kiosk::Kiosk, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == @0xb, 9);
        let v0 = pop_cap(arg0);
        0x2::kiosk::set_owner_custom(arg0, &v0, arg1);
        set_cap(arg0, v0);
        let v1 = OwnerToken{
            id    : 0x2::object::new(arg2),
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            owner : arg1,
        };
        0x2::transfer::transfer<OwnerToken>(v1, arg1);
    }

    public fun set_transfer_request_auth<T0, T1>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>, arg1: &T1) {
        let v0 = AuthTransferRequestDfKey{dummy_field: false};
        0x2::dynamic_field::add<AuthTransferRequestDfKey, 0x1::type_name::TypeName>(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::metadata_mut<T0>(arg0), v0, 0x1::type_name::get<T1>());
    }

    public fun set_transfer_request_auth_<T0, T1, T2>(arg0: &mut 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::RequestBody<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>, arg1: &T2) {
        let v0 = AuthTransferRequestDfKey{dummy_field: false};
        0x2::dynamic_field::add<AuthTransferRequestDfKey, 0x1::type_name::TypeName>(0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::metadata_mut<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T0, T1>>(arg0), v0, 0x1::type_name::get<T2>());
    }

    public fun transfer_between_owned<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert_permission(arg0, arg3);
        assert!(0x2::kiosk::owner(arg0) != @0xb, 8);
        assert!(0x2::kiosk::owner(arg0) == 0x2::kiosk::owner(arg1), 7);
        let v0 = NftRefsDfKey{dummy_field: false};
        let v1 = 0x2::table::remove<0x2::object::ID, NftRef>(0x2::dynamic_field::borrow_mut<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(0x2::kiosk::uid_mut(arg0), v0), arg2);
        assert_ref_not_exclusively_listed(&v1);
        let v2 = pop_cap(arg0);
        let v3 = 0x2::kiosk::take<T0>(arg0, &v2, arg2);
        set_cap(arg0, v2);
        deposit<T0>(arg1, v3, arg3);
    }

    public fun transfer_delegated<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::object::UID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        assert_version(0x2::kiosk::uid_mut(arg0));
        let (v0, v1) = transfer_nft_<T0>(arg0, arg2, 0x2::object::uid_to_address(arg3), arg4, arg5);
        deposit<T0>(arg1, v0, arg5);
        v1
    }

    public fun transfer_locked_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::object::UID, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        assert_version(0x2::kiosk::uid_mut(arg0));
        check_entity_and_pop_ref(arg0, 0x2::object::uid_to_address(arg3), arg2, arg4);
        let v0 = pop_cap(arg0);
        0x2::kiosk::list<T0>(arg0, &v0, arg2, 0);
        set_cap(arg0, v0);
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg0, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        deposit<T0>(arg1, v1, arg4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::from_sui<T0>(v2, arg2, 0x2::object::uid_to_address(arg3), arg4)
    }

    fun transfer_nft_<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>) {
        let v0 = get_nft<T0>(arg0, arg1, arg2, arg4);
        (v0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::new<T0>(arg1, arg2, 0x2::object::id<0x2::kiosk::Kiosk>(arg0), arg3, arg4))
    }

    public fun transfer_signed<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        assert_version(0x2::kiosk::uid_mut(arg0));
        let v0 = 0x2::tx_context::sender(arg4);
        let (v1, v2) = transfer_nft_<T0>(arg0, arg2, v0, arg3, arg4);
        deposit<T0>(arg1, v1, arg4);
        v2
    }

    public entry fun uninstall_extension(arg0: &mut 0x2::kiosk::Kiosk, arg1: OwnerToken, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        assert!(arg1.kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg0), 13);
        assert_owner_address(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0x2::kiosk::uid_mut(arg0);
        let v1 = NftRefsDfKey{dummy_field: false};
        assert!(0x2::table::is_empty<0x2::object::ID, NftRef>(0x2::dynamic_field::borrow<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(v0, v1)), 14);
        let v2 = KioskOwnerCapDfKey{dummy_field: false};
        let v3 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::remove<VersionDfKey, u64>(v0, v3);
        let v4 = NftRefsDfKey{dummy_field: false};
        0x2::table::destroy_empty<0x2::object::ID, NftRef>(0x2::dynamic_field::remove<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(v0, v4));
        let v5 = DepositSettingDfKey{dummy_field: false};
        0x2::dynamic_field::remove<DepositSettingDfKey, DepositSetting>(v0, v5);
        let OwnerToken {
            id    : v6,
            kiosk : _,
            owner : _,
        } = arg1;
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_field::remove<KioskOwnerCapDfKey, 0x2::kiosk::KioskOwnerCap>(v0, v2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::object::UID, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        withdraw_nft_<T0>(arg0, arg1, 0x2::object::uid_to_address(arg2), arg3)
    }

    fun withdraw_nft_<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let v0 = get_nft<T0>(arg0, arg1, arg2, arg3);
        (v0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::new<T0>(arg2, arg3))
    }

    public fun withdraw_nft_signed<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : (T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        assert_version(0x2::kiosk::uid_mut(arg0));
        let v0 = 0x2::tx_context::sender(arg2);
        withdraw_nft_<T0>(arg0, arg1, v0, arg2)
    }

    // decompiled from Move bytecode v6
}

