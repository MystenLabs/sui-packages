module 0x89626d8df1eef823926da9bb721f4123ea8d05bce7614b958c1e2c59d8b7d48f::marketplace {
    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    struct MarketPlace has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        baseFee: u16,
        personalFee: 0x2::vec_map::VecMap<address, u16>,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SItemWithPurchaseCap<phantom T0: store + key> has key {
        id: 0x2::object::UID,
        kioskId: 0x2::object::ID,
        purchaseCap: 0x2::kiosk::PurchaseCap<T0>,
        item_id: 0x2::object::ID,
        min_price: u64,
        owner: address,
        royalty_fee: u64,
        marketplace_fee: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketPlaceCreatedEvent has copy, drop {
        name: 0x1::string::String,
        id: 0x2::object::ID,
    }

    struct KioskCreatedEvent has copy, drop {
        kiosk: 0x2::object::ID,
        personal_kiosk_cap: 0x2::object::ID,
        owner: address,
    }

    struct PersonalFeeSetEvent has copy, drop {
        recipient: address,
        fee: u16,
    }

    struct ItemListedEvent<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        shared_purchaseCap: 0x2::object::ID,
        item: 0x2::object::ID,
        price: u64,
        marketplace_fee: u64,
        royalty_fee: u64,
        owner: address,
    }

    struct ItemUpdatedEvent<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        item: 0x2::object::ID,
        shared_purchaseCap: 0x2::object::ID,
        price: u64,
        marketplace_fee: u64,
        royalty_fee: u64,
        owner: address,
    }

    struct ItemDelistedEvent<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        item: 0x2::object::ID,
        shared_purchaseCap: 0x2::object::ID,
        owner: address,
    }

    struct ItemBoughtEvent<phantom T0> has copy, drop {
        kiosk: 0x2::object::ID,
        item: 0x2::object::ID,
        price: u64,
        shared_purchaseCap: 0x2::object::ID,
        buyer: address,
    }

    public fun add_admin(arg0: &0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::OwnerCap<MARKETPLACE>, arg1: &mut 0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::SRoles<MARKETPLACE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::add_role<MARKETPLACE, AdminCap>(arg0, arg1, arg2, arg3);
    }

    public fun add_balance(arg0: &mut MarketPlace, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    public(friend) fun add_simple_offer<T0: copy + drop + store, T1: store + key>(arg0: &mut MarketPlace, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public fun buy<T0: store + key>(arg0: &mut MarketPlace, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::object::ID, arg6: SItemWithPurchaseCap<T0>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1);
        let SItemWithPurchaseCap {
            id              : v1,
            kioskId         : v2,
            purchaseCap     : v3,
            item_id         : _,
            min_price       : v5,
            owner           : _,
            royalty_fee     : v7,
            marketplace_fee : v8,
        } = arg6;
        let v9 = v3;
        let v10 = 0x2::kiosk::purchase_cap_item<T0>(&v9);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg7) >= v5 + v7 + v8, 403);
        assert!(v2 == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 401);
        assert!(v10 == arg5, 402);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(arg7, v8, arg8));
        let (v11, v12) = 0x2::kiosk::purchase_with_cap<T0>(arg3, v9, 0x2::coin::split<0x2::sui::SUI>(arg7, v5, arg8));
        let v13 = v12;
        let v14 = ItemBoughtEvent<T0>{
            kiosk              : v2,
            item               : v10,
            price              : v5,
            shared_purchaseCap : 0x2::object::id<SItemWithPurchaseCap<T0>>(&arg6),
            buyer              : 0x2::tx_context::sender(arg8),
        };
        0x2::event::emit<ItemBoughtEvent<T0>>(v14);
        0x2::object::delete(v1);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::Rule>(arg4)) {
            0x2::kiosk::lock<T0>(arg2, v0, arg4, v11);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<T0>(&mut v13, arg2);
        } else {
            0x2::transfer::public_transfer<T0>(v11, 0x2::tx_context::sender(arg8));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg4)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<T0>(arg4, &mut v13, 0x2::coin::split<0x2::sui::SUI>(arg7, v7, arg8));
        };
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::Rule>(arg4)) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::floor_price_rule::prove<T0>(arg4, &mut v13);
        };
        v13
    }

    public fun confirm_purchase<T0: store + key>(arg0: 0x2::transfer_policy::TransferRequest<T0>, arg1: &0x2::transfer_policy::TransferPolicy<T0>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg1, arg0);
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::object::ID) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::object::id<0x2::kiosk::Kiosk>(&v3);
        0x2::kiosk::set_owner(&mut v3, &v2, arg0);
        let v5 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::new(&mut v3, v2, arg0);
        let v6 = 0x2::object::id<0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap>(&v5);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::transfer_to_sender(v5, arg0);
        let v7 = KioskCreatedEvent{
            kiosk              : v4,
            personal_kiosk_cap : v6,
            owner              : 0x2::tx_context::sender(arg0),
        };
        0x2::event::emit<KioskCreatedEvent>(v7);
        (v4, v6)
    }

    public fun delist<T0: store + key>(arg0: SItemWithPurchaseCap<T0>, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        let SItemWithPurchaseCap {
            id              : v0,
            kioskId         : v1,
            purchaseCap     : v2,
            item_id         : _,
            min_price       : _,
            owner           : v5,
            royalty_fee     : _,
            marketplace_fee : _,
        } = arg0;
        let v8 = v2;
        let v9 = v0;
        assert!(0x2::tx_context::sender(arg4) == v5, 400);
        let v10 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        assert!(0x2::kiosk::has_access(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1)), 400);
        let v11 = 0x2::kiosk::purchase_cap_item<T0>(&v8);
        assert!(v10 == v1, 401);
        assert!(v11 == arg3, 402);
        0x2::kiosk::return_purchase_cap<T0>(arg2, v8);
        let v12 = ItemDelistedEvent<T0>{
            kiosk              : v10,
            item               : v11,
            shared_purchaseCap : 0x2::object::uid_to_inner(&v9),
            owner              : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ItemDelistedEvent<T0>>(v12);
        0x2::object::delete(v9);
    }

    public(friend) fun emit_buy_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x2::object::ID, arg4: address) {
        let v0 = ItemBoughtEvent<T0>{
            kiosk              : arg0,
            item               : arg1,
            price              : arg2,
            shared_purchaseCap : arg3,
            buyer              : arg4,
        };
        0x2::event::emit<ItemBoughtEvent<T0>>(v0);
    }

    public(friend) fun emit_delist_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address) {
        let v0 = ItemDelistedEvent<T0>{
            kiosk              : arg0,
            item               : arg1,
            shared_purchaseCap : arg2,
            owner              : arg3,
        };
        0x2::event::emit<ItemDelistedEvent<T0>>(v0);
    }

    public(friend) fun emit_listing_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: address) {
        let v0 = ItemListedEvent<T0>{
            kiosk              : arg0,
            shared_purchaseCap : arg1,
            item               : arg2,
            price              : arg3,
            marketplace_fee    : arg4,
            royalty_fee        : 0,
            owner              : arg5,
        };
        0x2::event::emit<ItemListedEvent<T0>>(v0);
    }

    public(friend) fun emit_update_event<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: address) {
        let v0 = ItemUpdatedEvent<T0>{
            kiosk              : arg0,
            item               : arg1,
            shared_purchaseCap : arg2,
            price              : arg3,
            marketplace_fee    : arg4,
            royalty_fee        : 0,
            owner              : arg5,
        };
        0x2::event::emit<ItemUpdatedEvent<T0>>(v0);
    }

    public fun get_balance(arg0: &MarketPlace, arg1: &0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::SRoles<MARKETPLACE>, arg2: &0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::RoleCap<AdminCap>) : u64 {
        assert!(0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::has_cap_access<MARKETPLACE, AdminCap>(arg1, arg2), 400);
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_fee(arg0: &MarketPlace, arg1: address) : u16 {
        if (0x2::vec_map::contains<address, u16>(&arg0.personalFee, &arg1)) {
            return *0x2::vec_map::get<address, u16>(&arg0.personalFee, &arg1)
        };
        arg0.baseFee
    }

    public fun get_fee_by_pc<T0: store + key>(arg0: &SItemWithPurchaseCap<T0>) : u64 {
        arg0.marketplace_fee + arg0.royalty_fee
    }

    public fun get_item_id<T0: store + key>(arg0: &SItemWithPurchaseCap<T0>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun get_kiosk_id<T0: store + key>(arg0: &SItemWithPurchaseCap<T0>) : 0x2::object::ID {
        arg0.kioskId
    }

    public fun get_owner<T0: store + key>(arg0: &SItemWithPurchaseCap<T0>) : address {
        arg0.owner
    }

    public fun get_price<T0: store + key>(arg0: &SItemWithPurchaseCap<T0>) : u64 {
        arg0.min_price
    }

    public fun get_purchase_cap_id<T0: store + key>(arg0: &SItemWithPurchaseCap<T0>) : 0x2::object::ID {
        0x2::object::id<0x2::kiosk::PurchaseCap<T0>>(&arg0.purchaseCap)
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = MarketPlace{
            id          : v0,
            name        : 0x1::string::utf8(b"Hokko"),
            baseFee     : 200,
            personalFee : 0x2::vec_map::empty<address, u16>(),
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MarketPlace>(v1);
        0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::new<MARKETPLACE>(&arg0, arg1);
        0x2::package::claim_and_keep<MARKETPLACE>(arg0, arg1);
        let v2 = MarketPlaceCreatedEvent{
            name : 0x1::string::utf8(b"Hokko"),
            id   : 0x2::object::uid_to_inner(&v0),
        };
        0x2::event::emit<MarketPlaceCreatedEvent>(v2);
    }

    public fun list<T0: store + key>(arg0: &MarketPlace, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: T0, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg4);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        let v2 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1);
        0x2::kiosk::place<T0>(arg2, v2, arg4);
        let v3 = 0;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg3)) {
            v3 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg3, arg5);
        };
        let v4 = (((get_fee(arg0, 0x2::tx_context::sender(arg6)) as u128) * (arg5 as u128) / 10000) as u64);
        let v5 = 0x2::object::new(arg6);
        let v6 = SItemWithPurchaseCap<T0>{
            id              : v5,
            kioskId         : v1,
            purchaseCap     : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, v2, v0, arg5, arg6),
            item_id         : v0,
            min_price       : arg5,
            owner           : 0x2::tx_context::sender(arg6),
            royalty_fee     : v3,
            marketplace_fee : v4,
        };
        0x2::transfer::share_object<SItemWithPurchaseCap<T0>>(v6);
        let v7 = ItemListedEvent<T0>{
            kiosk              : v1,
            shared_purchaseCap : 0x2::object::uid_to_inner(&v5),
            item               : v0,
            price              : arg5 + v3 + v4,
            marketplace_fee    : v4,
            royalty_fee        : v3,
            owner              : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ItemListedEvent<T0>>(v7);
    }

    public fun list_kiosk_item<T0: store + key>(arg0: &MarketPlace, arg1: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(arg2);
        let v1 = 0;
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg3)) {
            v1 = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg3, arg5);
        };
        let v2 = (((get_fee(arg0, 0x2::tx_context::sender(arg6)) as u128) * (arg5 as u128) / 10000) as u64);
        let v3 = 0x2::object::new(arg6);
        let v4 = SItemWithPurchaseCap<T0>{
            id              : v3,
            kioskId         : v0,
            purchaseCap     : 0x2::kiosk::list_with_purchase_cap<T0>(arg2, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg1), arg4, arg5, arg6),
            item_id         : arg4,
            min_price       : arg5,
            owner           : 0x2::tx_context::sender(arg6),
            royalty_fee     : v1,
            marketplace_fee : v2,
        };
        0x2::transfer::share_object<SItemWithPurchaseCap<T0>>(v4);
        let v5 = ItemListedEvent<T0>{
            kiosk              : v0,
            shared_purchaseCap : 0x2::object::uid_to_inner(&v3),
            item               : arg4,
            price              : arg5 + v1 + v2,
            marketplace_fee    : v2,
            royalty_fee        : v1,
            owner              : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ItemListedEvent<T0>>(v5);
    }

    public(friend) fun remove_simple_offer<T0: copy + drop + store, T1: store + key>(arg0: &mut MarketPlace, arg1: T0) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    public fun revoke_admin(arg0: &0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::OwnerCap<MARKETPLACE>, arg1: &mut 0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::SRoles<MARKETPLACE>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::revoke_role_access<MARKETPLACE>(arg0, arg1, arg2, arg3);
    }

    public fun set_base_fee(arg0: &mut MarketPlace, arg1: &0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::RoleCap<AdminCap>, arg2: &0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::SRoles<MARKETPLACE>, arg3: u16) {
        assert!(0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::has_cap_access<MARKETPLACE, AdminCap>(arg2, arg1), 400);
        arg0.baseFee = arg3;
    }

    public fun set_personal_fee(arg0: &mut MarketPlace, arg1: &0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::RoleCap<AdminCap>, arg2: &0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::SRoles<MARKETPLACE>, arg3: address, arg4: u16) {
        assert!(0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::has_cap_access<MARKETPLACE, AdminCap>(arg2, arg1), 400);
        0x2::vec_map::insert<address, u16>(&mut arg0.personalFee, arg3, arg4);
        let v0 = PersonalFeeSetEvent{
            recipient : arg3,
            fee       : arg4,
        };
        0x2::event::emit<PersonalFeeSetEvent>(v0);
    }

    public fun update_listing<T0: store + key>(arg0: &MarketPlace, arg1: &mut SItemWithPurchaseCap<T0>, arg2: &0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::has_access(arg3, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow(arg2));
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = arg1.kioskId;
        assert!(v0 == arg1.owner, 400);
        assert!(arg1.item_id == arg5, 402);
        assert!(v1 == 0x2::object::id<0x2::kiosk::Kiosk>(arg3), 401);
        if (0x2::transfer_policy::has_rule<T0, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::Rule>(arg4)) {
            arg1.royalty_fee = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<T0>(arg4, arg6);
        };
        arg1.marketplace_fee = (((get_fee(arg0, 0x2::tx_context::sender(arg7)) as u128) * (arg6 as u128) / 10000) as u64);
        arg1.min_price = arg6;
        let v2 = ItemUpdatedEvent<T0>{
            kiosk              : v1,
            item               : arg5,
            shared_purchaseCap : 0x2::object::uid_to_inner(&arg1.id),
            price              : arg6,
            marketplace_fee    : arg1.marketplace_fee,
            royalty_fee        : arg1.royalty_fee,
            owner              : v0,
        };
        0x2::event::emit<ItemUpdatedEvent<T0>>(v2);
    }

    public fun withdraw_profit(arg0: &0xb2bcc2f98f2dca101e74ff12d00584bc1de682a33db5c05b2545ee21642b8ebf::access_control::RoleCap<AdminCap>, arg1: &mut MarketPlace, arg2: 0x1::option::Option<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            let v1 = 0x1::option::destroy_some<u64>(arg2);
            assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), 403);
            v1
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg1.balance)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

