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

    public fun assert_is_permissionless(arg0: &0x2::kiosk::Kiosk) {
        assert!(is_permissionless(arg0), 9);
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
        assert_ref_not_exclusively_listed(nft_ref(arg0, arg1));
    }

    public fun assert_not_listed(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID) {
        assert_ref_not_listed(nft_ref(arg0, arg1));
    }

    public fun assert_owner_address(arg0: &0x2::kiosk::Kiosk, arg1: address) {
        assert!(0x2::kiosk::owner(arg0) == arg1, 7);
    }

    public fun assert_permission(arg0: &0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg1)), 7);
    }

    fun assert_ref_not_exclusively_listed(arg0: &NftRef) {
        assert!(!arg0.is_exclusively_listed, 2);
    }

    fun assert_ref_not_listed(arg0: &NftRef) {
        assert!(0x2::vec_set::size<address>(&arg0.auths) == 0, 3);
    }

    fun assert_version(arg0: &0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        assert!(*0x2::dynamic_field::borrow<VersionDfKey, u64>(arg0, v0) == 3, 1000);
    }

    fun assert_version_and_upgrade(arg0: &mut 0x2::object::UID) {
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(arg0, v0);
        if (*v1 < 3) {
            *v1 = 3;
        };
        assert_version(arg0);
    }

    public fun auth_exclusive_transfer(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::object::UID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_permission(arg0, arg3);
        let v1 = nft_ref_mut(arg0, arg1);
        assert_ref_not_exclusively_listed(v1);
        v1.auths = 0x2::vec_set::singleton<address>(0x2::object::uid_to_address(arg2));
        v1.is_exclusively_listed = true;
    }

    public fun auth_transfer(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_permission(arg0, arg3);
        let v1 = nft_ref_mut(arg0, arg1);
        assert_ref_not_exclusively_listed(v1);
        0x2::vec_set::insert<address>(&mut v1.auths, arg2);
    }

    fun borrow_cap(arg0: &0x2::kiosk::Kiosk) : &0x2::kiosk::KioskOwnerCap {
        let v0 = KioskOwnerCapDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<KioskOwnerCapDfKey, 0x2::kiosk::KioskOwnerCap>(0x2::kiosk::uid(arg0), v0)
    }

    public fun borrow_nft<T0: store + key>(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : &T0 {
        assert_version(0x2::kiosk::uid(arg0));
        0x2::kiosk::borrow<T0>(arg0, borrow_cap(arg0), arg1)
    }

    public fun borrow_nft_mut<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x1::option::Option<0x1::type_name::TypeName>, arg3: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<Witness, T0> {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        let v1 = pop_cap(arg0);
        let (v2, v3) = 0x2::kiosk::borrow_val<T0>(arg0, &v1, arg1);
        set_cap(arg0, v1);
        let v4 = Witness{dummy_field: false};
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::new<Witness, T0>(v4, v2, 0x2::tx_context::sender(arg3), arg2, v3, arg3)
    }

    public fun can_deposit<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg1) == 0x2::kiosk::owner(arg0) || can_deposit_permissionlessly<T0>(arg0)
    }

    public fun can_deposit_permissionlessly<T0>(arg0: &mut 0x2::kiosk::Kiosk) : bool {
        if (is_permissionless(arg0)) {
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
        assert!(is_owner(arg0, 0x2::tx_context::sender(arg3)) || 0x2::vec_set::contains<address>(&v1.auths, &arg1), 8);
    }

    public fun create_for_address(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = new_for_address(arg0, arg1);
        let v2 = v0;
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v2);
        (0x2::object::id<0x2::kiosk::Kiosk>(&v2), v1)
    }

    public fun create_for_sender(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let v0 = 0x2::tx_context::sender(arg0);
        create_for_address(v0, arg0)
    }

    public fun create_permissionless(arg0: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_permissionless(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::object::id<0x2::kiosk::Kiosk>(&v0)
    }

    public fun delegate_auth(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::object::UID, arg3: address) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, NftRef>(nft_refs_mut(arg0), arg1);
        let v2 = 0x2::object::uid_to_address(arg2);
        assert!(0x2::vec_set::contains<address>(&v1.auths, &v2), 8);
        let v3 = 0x2::object::uid_to_address(arg2);
        0x2::vec_set::remove<address>(&mut v1.auths, &v3);
        0x2::vec_set::insert<address>(&mut v1.auths, arg3);
    }

    public fun delist_nft_as_owner(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_permission(arg0, arg2);
        let v1 = nft_ref_mut(arg0, arg1);
        assert_ref_not_exclusively_listed(v1);
        v1.auths = 0x2::vec_set::empty<address>();
    }

    public entry fun deposit<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_can_deposit<T0>(arg0, arg2);
        let v1 = pop_cap(arg0);
        deposit_<T0>(arg0, &v1, arg1);
        set_cap(arg0, v1);
    }

    fun deposit_<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: T0) {
        let v0 = nft_refs_mut(arg0);
        let v1 = NftRef{
            auths                 : 0x2::vec_set::empty<address>(),
            is_exclusively_listed : false,
        };
        0x2::table::add<0x2::object::ID, NftRef>(v0, 0x2::object::id<T0>(&arg2), v1);
        0x2::kiosk::place<T0>(arg0, arg1, arg2);
    }

    public fun deposit_batch<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: vector<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_can_deposit<T0>(arg0, arg2);
        let v1 = pop_cap(arg0);
        while (!0x1::vector::is_empty<T0>(&arg1)) {
            deposit_<T0>(arg0, &v1, 0x1::vector::pop_back<T0>(&mut arg1));
        };
        0x1::vector::destroy_empty<T0>(arg1);
        set_cap(arg0, v1);
    }

    fun deposit_setting_mut(arg0: &mut 0x2::kiosk::Kiosk) : &mut DepositSetting {
        assert_is_ob_kiosk(arg0);
        let v0 = DepositSettingDfKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<DepositSettingDfKey, DepositSetting>(0x2::kiosk::uid_mut(arg0), v0)
    }

    public entry fun disable_deposits_of_collection<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_permission(arg0, arg1);
        let v1 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut deposit_setting_mut(arg0).collections_with_enabled_deposits, &v1);
    }

    public entry fun enable_any_deposit(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_permission(arg0, arg1);
        deposit_setting_mut(arg0).enable_any_deposit = true;
    }

    public entry fun enable_deposits_of_collection<T0>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        assert_permission(arg0, arg1);
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut deposit_setting_mut(arg0).collections_with_enabled_deposits, 0x1::type_name::get<T0>());
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
        install_extension_(arg0, arg1, arg2);
        let v0 = OwnerToken{
            id    : 0x2::object::new(arg2),
            kiosk : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            owner : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::transfer<OwnerToken>(v0, 0x2::tx_context::sender(arg2));
    }

    fun install_extension_(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg0, &arg1), 7);
        let v0 = is_ob_kiosk(arg0);
        assert!(!v0, 15);
        0x2::kiosk::set_allow_extensions(arg0, &arg1, true);
        let v1 = 0x2::kiosk::uid_mut(arg0);
        let v2 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::add<VersionDfKey, u64>(v1, v2, 3);
        let v3 = KioskOwnerCapDfKey{dummy_field: false};
        0x2::dynamic_field::add<KioskOwnerCapDfKey, 0x2::kiosk::KioskOwnerCap>(v1, v3, arg1);
        let v4 = NftRefsDfKey{dummy_field: false};
        0x2::dynamic_field::add<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(v1, v4, 0x2::table::new<0x2::object::ID, NftRef>(arg2));
        let v5 = DepositSettingDfKey{dummy_field: false};
        let v6 = DepositSetting{
            enable_any_deposit                : true,
            collections_with_enabled_deposits : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        0x2::dynamic_field::add<DepositSettingDfKey, DepositSetting>(v1, v5, v6);
    }

    public fun is_ob_kiosk(arg0: &mut 0x2::kiosk::Kiosk) : bool {
        let v0 = NftRefsDfKey{dummy_field: false};
        0x2::dynamic_field::exists_<NftRefsDfKey>(0x2::kiosk::uid(arg0), v0)
    }

    fun is_ob_kiosk_imut(arg0: &0x2::kiosk::Kiosk) : bool {
        let v0 = NftRefsDfKey{dummy_field: false};
        0x2::dynamic_field::exists_<NftRefsDfKey>(0x2::kiosk::uid(arg0), v0)
    }

    public fun is_owner(arg0: &0x2::kiosk::Kiosk, arg1: address) : bool {
        let v0 = 0x2::kiosk::owner(arg0);
        v0 == @0xb || v0 == arg1
    }

    public fun is_permissionless(arg0: &0x2::kiosk::Kiosk) : bool {
        0x2::kiosk::owner(arg0) == @0xb
    }

    entry fun migrate(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        assert_permission(arg0, arg1);
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(0x2::kiosk::uid_mut(arg0), v0);
        assert!(*v1 < 3, 999);
        *v1 = 3;
    }

    entry fun migrate_as_pub(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<0x95a441d389b07437d00dd07e0b6f05f513d7659b13fd7c5d3923c7d9d847199b::kiosk::KIOSK>(arg1), 0);
        let v0 = VersionDfKey{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<VersionDfKey, u64>(0x2::kiosk::uid_mut(arg0), v0);
        assert!(*v1 < 3, 999);
        *v1 = 3;
    }

    fun new_(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::Kiosk {
        let (v0, v1) = 0x2::kiosk::new(arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::kiosk::set_owner_custom(&mut v3, &v2, arg0);
        let v4 = &mut v3;
        install_extension_(v4, v2, arg1);
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

    fun nft_ref(arg0: &0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : &NftRef {
        let v0 = nft_refs(arg0);
        assert!(0x2::table::contains<0x2::object::ID, NftRef>(v0, arg1), 1);
        0x2::table::borrow<0x2::object::ID, NftRef>(v0, arg1)
    }

    fun nft_ref_mut(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID) : &mut NftRef {
        let v0 = nft_refs_mut(arg0);
        assert!(0x2::table::contains<0x2::object::ID, NftRef>(v0, arg1), 1);
        0x2::table::borrow_mut<0x2::object::ID, NftRef>(v0, arg1)
    }

    public fun nft_refs(arg0: &0x2::kiosk::Kiosk) : &0x2::table::Table<0x2::object::ID, NftRef> {
        is_ob_kiosk_imut(arg0);
        let v0 = NftRefsDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(0x2::kiosk::uid(arg0), v0)
    }

    fun nft_refs_mut(arg0: &mut 0x2::kiosk::Kiosk) : &mut 0x2::table::Table<0x2::object::ID, NftRef> {
        assert_is_ob_kiosk(arg0);
        let v0 = NftRefsDfKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(0x2::kiosk::uid_mut(arg0), v0)
    }

    entry fun p2p_transfer<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_permission(arg0, arg3);
        let v1 = nft_refs_mut(arg0);
        let v2 = 0x2::table::remove<0x2::object::ID, NftRef>(v1, arg2);
        assert_ref_not_exclusively_listed(&v2);
        let v3 = pop_cap(arg0);
        let v4 = 0x2::kiosk::take<T0>(arg0, &v3, arg2);
        set_cap(arg0, v3);
        deposit<T0>(arg1, v4, arg3);
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
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_permission(arg0, arg2);
        assert_has_nft(arg0, arg1);
        assert!(!0x2::kiosk::is_listed(arg0, arg1), 12);
        let v1 = nft_refs_mut(arg0);
        assert_missing_ref(v1, arg1);
        let v2 = NftRef{
            auths                 : 0x2::vec_set::empty<address>(),
            is_exclusively_listed : false,
        };
        0x2::table::add<0x2::object::ID, NftRef>(v1, arg1, v2);
    }

    public fun remove_auth_transfer(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::object::UID) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        let v1 = 0x2::object::uid_to_address(arg2);
        let v2 = nft_ref_mut(arg0, arg1);
        0x2::vec_set::remove<address>(&mut v2.auths, &v1);
        v2.is_exclusively_listed = false;
    }

    public fun remove_auth_transfer_as_owner(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_permission(arg0, arg3);
        let v1 = nft_ref_mut(arg0, arg1);
        assert_ref_not_exclusively_listed(v1);
        0x2::vec_set::remove<address>(&mut v1.auths, &arg2);
    }

    public fun remove_auth_transfer_signed(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = nft_ref_mut(arg0, arg1);
        assert_ref_not_exclusively_listed(v2);
        0x2::vec_set::remove<address>(&mut v2.auths, &v1);
    }

    fun remove_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        check_entity_and_pop_ref(arg0, arg2, arg1, arg3);
        let v0 = pop_cap(arg0);
        let v1 = 0x2::kiosk::take<T0>(arg0, &v0, arg1);
        set_cap(arg0, v0);
        v1
    }

    public entry fun restrict_deposits(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_permission(arg0, arg1);
        deposit_setting_mut(arg0).enable_any_deposit = false;
    }

    public fun return_nft<T0: drop, T1: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BorrowRequest<Witness, T1>, arg2: &0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::Policy<0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::request::WithNft<T1, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::BORROW_REQ>>) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        let v1 = Witness{dummy_field: false};
        let (v2, v3) = 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::borrow_request::confirm<Witness, T1>(v1, arg1, arg2);
        let v4 = pop_cap(arg0);
        0x2::kiosk::return_val<T1>(arg0, v2, v3);
        set_cap(arg0, v4);
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
        assert_permission(arg0, arg3);
        transfer_between_owned_<T0>(arg0, arg1, arg2, arg3);
    }

    fun transfer_between_owned_<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert!(0x2::kiosk::owner(arg0) != @0xb, 8);
        assert!(0x2::kiosk::owner(arg0) == 0x2::kiosk::owner(arg1), 7);
        let v1 = nft_refs_mut(arg0);
        let v2 = 0x2::table::remove<0x2::object::ID, NftRef>(v1, arg2);
        assert_ref_not_exclusively_listed(&v2);
        let v3 = pop_cap(arg0);
        let v4 = 0x2::kiosk::take<T0>(arg0, &v3, arg2);
        set_cap(arg0, v3);
        deposit<T0>(arg1, v4, arg3);
    }

    public fun transfer_between_owned_with_witness<T0: store + key>(arg0: 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness::Witness<T0>, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        transfer_between_owned_<T0>(arg1, arg2, arg3, arg4);
    }

    public fun transfer_delegated<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::object::UID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        let (v1, v2) = transfer_nft_<T0>(arg0, arg2, 0x2::object::uid_to_address(arg3), arg4, arg5);
        deposit<T0>(arg1, v1, arg5);
        v2
    }

    public fun transfer_locked_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &0x2::object::UID, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        check_entity_and_pop_ref(arg0, 0x2::object::uid_to_address(arg3), arg2, arg4);
        let v1 = pop_cap(arg0);
        0x2::kiosk::list<T0>(arg0, &v1, arg2, 0);
        set_cap(arg0, v1);
        let (v2, v3) = 0x2::kiosk::purchase<T0>(arg0, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        deposit<T0>(arg1, v2, arg4);
        0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::from_sui<T0>(v3, arg2, 0x2::object::uid_to_address(arg3), arg4)
    }

    fun transfer_nft_<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0>) {
        let v0 = remove_nft<T0>(arg0, arg1, arg2, arg4);
        (v0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::new<T0>(arg1, arg2, 0x2::object::id<0x2::kiosk::Kiosk>(arg0), arg3, arg4))
    }

    public fun transfer_signed<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::transfer_request::TransferRequest<T0> {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_not_exclusively_listed(arg0, arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let (v2, v3) = transfer_nft_<T0>(arg0, arg2, v1, arg3, arg4);
        deposit<T0>(arg1, v2, arg4);
        v3
    }

    public entry fun uninstall_extension(arg0: &mut 0x2::kiosk::Kiosk, arg1: OwnerToken, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert!(arg1.kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg0), 13);
        assert_owner_address(arg0, 0x2::tx_context::sender(arg2));
        assert!(0x2::table::is_empty<0x2::object::ID, NftRef>(nft_refs(arg0)), 14);
        let v1 = 0x2::kiosk::uid_mut(arg0);
        let v2 = KioskOwnerCapDfKey{dummy_field: false};
        let v3 = NftRefsDfKey{dummy_field: false};
        0x2::table::destroy_empty<0x2::object::ID, NftRef>(0x2::dynamic_field::remove<NftRefsDfKey, 0x2::table::Table<0x2::object::ID, NftRef>>(v1, v3));
        let v4 = VersionDfKey{dummy_field: false};
        0x2::dynamic_field::remove<VersionDfKey, u64>(v1, v4);
        let v5 = DepositSettingDfKey{dummy_field: false};
        0x2::dynamic_field::remove<DepositSettingDfKey, DepositSetting>(v1, v5);
        let OwnerToken {
            id    : v6,
            kiosk : _,
            owner : _,
        } = arg1;
        0x2::object::delete(v6);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(0x2::dynamic_field::remove<KioskOwnerCapDfKey, 0x2::kiosk::KioskOwnerCap>(v1, v2), 0x2::tx_context::sender(arg2));
    }

    public fun withdraw_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &0x2::object::UID, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        withdraw_nft_<T0>(arg0, arg1, 0x2::object::uid_to_address(arg2), arg3)
    }

    fun withdraw_nft_<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let v0 = remove_nft<T0>(arg0, arg1, arg2, arg3);
        (v0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::new<T0>(arg2, arg3))
    }

    public fun withdraw_nft_signed<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : (T0, 0xe2c7a6843cb13d9549a9d2dc1c266b572ead0b4b9f090e7c3c46de2714102b43::withdraw_request::WithdrawRequest<T0>) {
        let v0 = 0x2::kiosk::uid_mut(arg0);
        assert_version_and_upgrade(v0);
        assert_not_exclusively_listed(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg2);
        withdraw_nft_<T0>(arg0, arg1, v1, arg2)
    }

    // decompiled from Move bytecode v6
}

