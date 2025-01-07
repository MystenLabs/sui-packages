module 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::accessories_v2 {
    struct ACCESSORIES_V2 has drop {
        dummy_field: bool,
    }

    struct Wardrobe has key {
        id: 0x2::object::UID,
        publisher: 0x2::borrow::Referent<0x2::package::Publisher>,
        version: u8,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct LockedPromise {
        item_id: 0x2::object::ID,
    }

    struct Accessory<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        type: 0x1::string::String,
    }

    struct AllowedAccessoryTypeKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct AccessoryConfig<phantom T0: drop> has store {
        display: 0x2::borrow::Referent<0x2::display::Display<Accessory<T0>>>,
        unlock_policy: 0x2::transfer_policy::TransferPolicy<Accessory<T0>>,
        unlock_cap: 0x2::transfer_policy::TransferPolicyCap<Accessory<T0>>,
        cap: 0x2::transfer_policy::TransferPolicyCap<Accessory<T0>>,
        royalty_commission: u16,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AuthorizedStore<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct CreatorCap<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    public fun admin_borrow_display<T0: drop>(arg0: &mut Wardrobe, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap) : (0x2::display::Display<Accessory<T0>>, 0x2::borrow::Borrow) {
        assert_type_is_authorized<T0>(arg0);
        let v0 = AllowedAccessoryTypeKey<T0>{dummy_field: false};
        0x2::borrow::borrow<0x2::display::Display<Accessory<T0>>>(&mut 0x2::dynamic_field::borrow_mut<AllowedAccessoryTypeKey<T0>, AccessoryConfig<T0>>(&mut arg0.id, v0).display)
    }

    public fun admin_return_display<T0: drop>(arg0: &mut Wardrobe, arg1: 0x2::display::Display<Accessory<T0>>, arg2: 0x2::borrow::Borrow) {
        let v0 = AllowedAccessoryTypeKey<T0>{dummy_field: false};
        0x2::borrow::put_back<0x2::display::Display<Accessory<T0>>>(&mut 0x2::dynamic_field::borrow_mut<AllowedAccessoryTypeKey<T0>, AccessoryConfig<T0>>(&mut arg0.id, v0).display, arg1, arg2);
    }

    public fun admin_royalties_split<T0: drop>(arg0: &mut Wardrobe, arg1: &mut 0x2::transfer_policy::TransferPolicy<Accessory<T0>>, arg2: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        internal_split_royalties<T0>(arg0, arg1, arg3);
    }

    public fun admin_withdraw(arg0: &mut Wardrobe, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg2)
    }

    fun assert_package_versioning(arg0: &Wardrobe) {
        assert!(arg0.version == 1, 7);
    }

    public fun assert_store_is_authorized<T0: drop, T1: store>(arg0: &0x2::object::UID) {
        assert!(is_store_authorized<T0, T1>(arg0), 8);
    }

    public fun assert_type_is_authorized<T0: drop>(arg0: &Wardrobe) {
        assert!(is_type_authorized<T0>(arg0), 2);
    }

    public fun authorize_accessory_type<T0: drop>(arg0: &mut Wardrobe, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg2: u16, arg3: u64, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) : CreatorCap<T0> {
        assert_package_versioning(arg0);
        assert!(!is_type_authorized<T0>(arg0), 3);
        assert!(0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::commission::is_valid_commission(arg4), 9);
        let (v0, v1) = 0x2::borrow::borrow<0x2::package::Publisher>(&mut arg0.publisher);
        let v2 = v0;
        let (v3, v4) = 0x2::transfer_policy::new<Accessory<T0>>(&v2, arg5);
        let (v5, v6) = 0x2::transfer_policy::new<Accessory<T0>>(&v2, arg5);
        let v7 = v6;
        let v8 = v5;
        0x2::borrow::put_back<0x2::package::Publisher>(&mut arg0.publisher, v2, v1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Accessory<T0>>(&mut v8, &v7);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Accessory<T0>>(&mut v8, &v7, arg2, arg3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Accessory<T0>>>(v8);
        let v9 = AllowedAccessoryTypeKey<T0>{dummy_field: false};
        let v10 = AccessoryConfig<T0>{
            display            : 0x2::borrow::new<0x2::display::Display<Accessory<T0>>>(0x2::display::new<Accessory<T0>>(&v2, arg5), arg5),
            unlock_policy      : v3,
            unlock_cap         : v4,
            cap                : v7,
            royalty_commission : arg4,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::dynamic_field::add<AllowedAccessoryTypeKey<T0>, AccessoryConfig<T0>>(&mut arg0.id, v9, v10);
        CreatorCap<T0>{id: 0x2::object::new(arg5)}
    }

    public fun creator_withdraw_royalties<T0: drop>(arg0: &mut Wardrobe, arg1: &mut 0x2::transfer_policy::TransferPolicy<Accessory<T0>>, arg2: &CreatorCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        internal_split_royalties<T0>(arg0, arg1, arg3);
        let v0 = AllowedAccessoryTypeKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<AllowedAccessoryTypeKey<T0>, AccessoryConfig<T0>>(&mut arg0.id, v0);
        0x2::coin::take<0x2::sui::SUI>(&mut v1.balance, 0x2::balance::value<0x2::sui::SUI>(&v1.balance), arg3)
    }

    public fun equip<T0, T1: drop>(arg0: &mut Wardrobe, arg1: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: Accessory<T1>, arg3: 0x2::transfer_policy::TransferRequest<Accessory<T1>>) {
        assert_package_versioning(arg0);
        assert_type_is_authorized<T1>(arg0);
        assert!(!0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::has_accessory_type<T0>(arg1, type<T1>(&arg2)), 4);
        let v0 = AllowedAccessoryTypeKey<T1>{dummy_field: false};
        let (v1, _, _) = 0x2::transfer_policy::confirm_request<Accessory<T1>>(&0x2::dynamic_field::borrow<AllowedAccessoryTypeKey<T1>, AccessoryConfig<T1>>(&arg0.id, v0).unlock_policy, arg3);
        assert!(v1 == 0x2::object::id<Accessory<T1>>(&arg2), 6);
        0x2::dynamic_object_field::add<0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::AccessoryKey, Accessory<T1>>(0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg1), 0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::app_new_accessory_key(&mut arg0.id, type<T1>(&arg2)), arg2);
    }

    fun init(arg0: ACCESSORIES_V2, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Wardrobe{
            id        : 0x2::object::new(arg1),
            publisher : 0x2::borrow::new<0x2::package::Publisher>(0x2::package::claim<ACCESSORIES_V2>(arg0, arg1), arg1),
            version   : 1,
            balance   : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Wardrobe>(v0);
    }

    fun internal_split_royalties<T0: drop>(arg0: &mut Wardrobe, arg1: &mut 0x2::transfer_policy::TransferPolicy<Accessory<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_type_is_authorized<T0>(arg0);
        let v0 = AllowedAccessoryTypeKey<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::borrow_mut<AllowedAccessoryTypeKey<T0>, AccessoryConfig<T0>>(&mut arg0.id, v0);
        let v2 = 0x2::transfer_policy::withdraw<Accessory<T0>>(arg1, &v1.cap, 0x1::option::none<u64>(), arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut v1.balance, 0x8a711e344fdfcfacd9d4f34683e75dd653d44dab9f2a4744196e6df3291141a::commission::split_commission(&mut v2, v1.royalty_commission, arg2));
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v2);
    }

    public fun is_store_authorized<T0: drop, T1: store>(arg0: &0x2::object::UID) : bool {
        let v0 = AuthorizedStore<T0>{dummy_field: false};
        0x2::dynamic_field::exists_with_type<AuthorizedStore<T0>, T1>(arg0, v0)
    }

    public fun is_type_authorized<T0: drop>(arg0: &Wardrobe) : bool {
        let v0 = AllowedAccessoryTypeKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AllowedAccessoryTypeKey<T0>>(&arg0.id, v0)
    }

    public fun mint<T0: drop>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : (Accessory<T0>, LockedPromise) {
        let v0 = AuthorizedStore<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<AuthorizedStore<T0>>(arg0, v0), 8);
        let v1 = Accessory<T0>{
            id   : 0x2::object::new(arg3),
            name : arg1,
            type : arg2,
        };
        let v2 = LockedPromise{item_id: 0x2::object::id<Accessory<T0>>(&v1)};
        (v1, v2)
    }

    public fun name<T0: drop>(arg0: &Accessory<T0>) : 0x1::string::String {
        arg0.name
    }

    public fun prove(arg0: &0x2::kiosk::Kiosk, arg1: LockedPromise) {
        let LockedPromise { item_id: v0 } = arg1;
        assert!(0x2::kiosk::is_locked(arg0, v0), 1);
    }

    public fun prove_equipped<T0, T1: drop>(arg0: &mut Wardrobe, arg1: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: 0x1::string::String, arg3: LockedPromise) {
        assert_package_versioning(arg0);
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg1);
        let v1 = 0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::app_new_accessory_key(&mut arg0.id, arg2);
        assert!(0x2::dynamic_object_field::exists_with_type<0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::AccessoryKey, Accessory<T1>>(v0, v1), 5);
        let LockedPromise { item_id: v2 } = arg3;
        assert!(v2 == 0x2::object::id<Accessory<T1>>(0x2::dynamic_object_field::borrow<0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::AccessoryKey, Accessory<T1>>(v0, v1)), 1);
    }

    public fun set_version(arg0: &mut Wardrobe, arg1: u8, arg2: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap) {
        arg0.version = arg1;
    }

    public fun store_config<T0: drop, T1: store>(arg0: &0x2::object::UID) : &T1 {
        assert_store_is_authorized<T0, T1>(arg0);
        let v0 = AuthorizedStore<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<AuthorizedStore<T0>, T1>(arg0, v0)
    }

    public fun store_config_mut<T0: drop, T1: store>(arg0: &mut 0x2::object::UID) : &mut T1 {
        assert_store_is_authorized<T0, T1>(arg0);
        let v0 = AuthorizedStore<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AuthorizedStore<T0>, T1>(arg0, v0)
    }

    public fun store_install<T0: drop, T1: store>(arg0: &Wardrobe, arg1: &mut 0x2::object::UID, arg2: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap, arg3: T1) {
        assert_package_versioning(arg0);
        assert_type_is_authorized<T0>(arg0);
        let v0 = AuthorizedStore<T0>{dummy_field: false};
        0x2::dynamic_field::add<AuthorizedStore<T0>, T1>(arg1, v0, arg3);
    }

    public fun store_uninstall<T0: drop, T1: store>(arg0: &mut 0x2::object::UID, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap) : T1 {
        assert_store_is_authorized<T0, T1>(arg0);
        let v0 = AuthorizedStore<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AuthorizedStore<T0>, T1>(arg0, v0)
    }

    public fun type<T0: drop>(arg0: &Accessory<T0>) : 0x1::string::String {
        arg0.type
    }

    public fun unequip<T0, T1: drop>(arg0: &mut Wardrobe, arg1: &mut 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::SuiFren<T0>, arg2: 0x1::string::String) : (Accessory<T1>, LockedPromise) {
        assert_package_versioning(arg0);
        let v0 = 0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::uid_mut<T0>(arg1);
        let v1 = 0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::app_new_accessory_key(&mut arg0.id, arg2);
        assert!(0x2::dynamic_object_field::exists_with_type<0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::AccessoryKey, Accessory<T1>>(v0, v1), 5);
        let v2 = 0x2::dynamic_object_field::remove<0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::AccessoryKey, Accessory<T1>>(v0, v1);
        let v3 = LockedPromise{item_id: 0x2::object::id<Accessory<T1>>(&v2)};
        (v2, v3)
    }

    public fun v1_authorize(arg0: &mut Wardrobe, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap) {
        0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::authorize_app(arg1, &mut arg0.id);
    }

    public fun v1_deauthorize(arg0: &mut Wardrobe, arg1: &0xee496a0cc04d06a345982ba6697c90c619020de9e274408c7819f787ff66e1a1::suifrens::AdminCap) {
        0x7aee872d77cade27e7d9b79bf9c67ac40bfb1b797e8b7438ee73f0af21bb4664::accessories::deauthorize_app(arg1, &mut arg0.id);
    }

    // decompiled from Move bytecode v6
}

