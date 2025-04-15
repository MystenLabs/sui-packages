module 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::marketplace {
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

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OfferCap has key {
        id: 0x2::object::UID,
        offer: 0x2::object::ID,
        itemType: 0x1::string::String,
    }

    struct Receipt has key {
        id: 0x2::object::UID,
        offer_cap: 0x2::object::ID,
        itemType: 0x1::string::String,
    }

    struct KioskCreatedEvent has copy, drop {
        kiosk: 0x2::object::ID,
        personal_kiosk_cap: 0x2::object::ID,
        owner: address,
    }

    struct PersonalFeeSetEvent has copy, drop {
        recipient: vector<address>,
        fee: vector<u16>,
    }

    struct PersonalFeeRemovalEvent has copy, drop {
        recipient: vector<address>,
    }

    struct ReceiptCreatedEvent has copy, drop {
        receipt_id: 0x2::object::ID,
        offer_cap: 0x2::object::ID,
    }

    struct ReceiptDestroyedEvent has copy, drop {
        receipt_id: 0x2::object::ID,
        offer_cap: 0x2::object::ID,
    }

    public fun add_admin(arg0: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::OwnerCap<MARKETPLACE>, arg1: &mut 0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::SRoles<MARKETPLACE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::add_role<MARKETPLACE, AdminCap>(arg0, arg1, arg2, arg3);
    }

    public fun add_balance(arg0: &mut MarketPlace, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, arg1);
    }

    fun add_personal(arg0: &mut MarketPlace, arg1: address, arg2: u16) {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow_mut<address, u16>(&mut arg0.id, arg1) = arg2;
        } else {
            0x2::dynamic_field::add<address, u16>(&mut arg0.id, arg1, arg2);
        };
    }

    public(friend) fun add_to_marketplace<T0: copy + drop + store, T1: store + key>(arg0: &mut MarketPlace, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun assert_offer_match(arg0: &OfferCap, arg1: 0x2::object::ID) {
        assert!(arg0.offer == arg1, 406);
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

    public(friend) fun create_offer_cap<T0>(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : OfferCap {
        OfferCap{
            id       : 0x2::object::new(arg1),
            offer    : arg0,
            itemType : 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::utils::type_to_string<T0>(),
        }
    }

    public(friend) fun create_receipt<T0: store + key>(arg0: 0x2::object::ID, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Receipt{
            id        : 0x2::object::new(arg2),
            offer_cap : arg0,
            itemType  : 0x66a422f94f320db5f541fa1b7fa0c097fabbd9024e9496b3b0f3e45d5558ec51::utils::type_to_string<T0>(),
        };
        let v1 = ReceiptCreatedEvent{
            receipt_id : 0x2::object::id<Receipt>(&v0),
            offer_cap  : arg0,
        };
        0x2::event::emit<ReceiptCreatedEvent>(v1);
        0x2::transfer::transfer<Receipt>(v0, arg1);
    }

    public(friend) fun delete_cap(arg0: OfferCap) {
        let OfferCap {
            id       : v0,
            offer    : _,
            itemType : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_receipt(arg0: OfferCap, arg1: Receipt) {
        let OfferCap {
            id       : v0,
            offer    : _,
            itemType : v2,
        } = arg0;
        let v3 = v0;
        let Receipt {
            id        : v4,
            offer_cap : v5,
            itemType  : v6,
        } = arg1;
        let v7 = v4;
        assert!(v2 == v6, 405);
        assert!(0x2::object::uid_to_inner(&v3) == v5, 405);
        let v8 = ReceiptDestroyedEvent{
            receipt_id : 0x2::object::uid_to_inner(&v7),
            offer_cap  : 0x2::object::uid_to_inner(&v3),
        };
        0x2::event::emit<ReceiptDestroyedEvent>(v8);
        0x2::object::delete(v7);
        0x2::object::delete(v3);
    }

    public fun get_balance(arg0: &MarketPlace, arg1: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::SRoles<MARKETPLACE>, arg2: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::RoleCap<AdminCap>) : u64 {
        assert!(0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::has_cap_access<MARKETPLACE, AdminCap>(arg1, arg2), 400);
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public fun get_fee(arg0: &MarketPlace, arg1: address) : u16 {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            0x1::u16::min(*0x2::dynamic_field::borrow<address, u16>(&arg0.id, arg1), arg0.baseFee)
        } else {
            arg0.baseFee
        }
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketPlace{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Hokko"),
            baseFee     : 200,
            personalFee : 0x2::vec_map::empty<address, u16>(),
            balance     : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MarketPlace>(v0);
        0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::default<MARKETPLACE>(&arg0, arg1);
        0x2::package::claim_and_keep<MARKETPLACE>(arg0, arg1);
    }

    public(friend) fun remove_from_marketplace<T0: copy + drop + store, T1: store + key>(arg0: &mut MarketPlace, arg1: T0) : T1 {
        0x2::dynamic_object_field::remove<T0, T1>(&mut arg0.id, arg1)
    }

    fun remove_personal(arg0: &mut MarketPlace, arg1: address) {
        if (0x2::dynamic_field::exists_<address>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<address, u16>(&mut arg0.id, arg1);
        };
    }

    public fun remove_personal_fee(arg0: &mut MarketPlace, arg1: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::RoleCap<AdminCap>, arg2: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::SRoles<MARKETPLACE>, arg3: vector<address>) {
        assert!(0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::has_cap_access<MARKETPLACE, AdminCap>(arg2, arg1), 400);
        0x1::vector::reverse<address>(&mut arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            remove_personal(arg0, 0x1::vector::pop_back<address>(&mut arg3));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg3);
        let v1 = PersonalFeeRemovalEvent{recipient: arg3};
        0x2::event::emit<PersonalFeeRemovalEvent>(v1);
    }

    public fun revoke_admin(arg0: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::OwnerCap<MARKETPLACE>, arg1: &mut 0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::SRoles<MARKETPLACE>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::revoke_role_access<MARKETPLACE>(arg0, arg1, arg2, arg3);
    }

    public fun set_base_fee(arg0: &mut MarketPlace, arg1: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::RoleCap<AdminCap>, arg2: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::SRoles<MARKETPLACE>, arg3: u16) {
        assert!(0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::has_cap_access<MARKETPLACE, AdminCap>(arg2, arg1), 400);
        arg0.baseFee = arg3;
    }

    public fun set_personal_fee(arg0: &mut MarketPlace, arg1: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::RoleCap<AdminCap>, arg2: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::SRoles<MARKETPLACE>, arg3: vector<address>, arg4: vector<u16>) {
        assert!(0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::has_cap_access<MARKETPLACE, AdminCap>(arg2, arg1), 400);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u16>(&arg4), 404);
        0x1::vector::reverse<u16>(&mut arg4);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u16>(&arg4), 13906834857243181055);
        0x1::vector::reverse<address>(&mut arg3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg3)) {
            add_personal(arg0, 0x1::vector::pop_back<address>(&mut arg3), 0x1::vector::pop_back<u16>(&mut arg4));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg3);
        0x1::vector::destroy_empty<u16>(arg4);
        let v1 = PersonalFeeSetEvent{
            recipient : arg3,
            fee       : arg4,
        };
        0x2::event::emit<PersonalFeeSetEvent>(v1);
    }

    public(friend) fun transfer_offer_cap(arg0: OfferCap, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<OfferCap>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_profit(arg0: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::RoleCap<AdminCap>, arg1: &0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::SRoles<MARKETPLACE>, arg2: &mut MarketPlace, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xeb04131cc0b54fb5d50d48113a734d95f7c5ff30a2c1021cf259f3f77accd2fc::access_control::has_cap_access<MARKETPLACE, AdminCap>(arg1, arg0), 400);
        let v0 = if (0x1::option::is_some<u64>(&arg3)) {
            let v1 = 0x1::option::destroy_some<u64>(arg3);
            assert!(v1 <= 0x2::balance::value<0x2::sui::SUI>(&arg2.balance), 403);
            v1
        } else {
            0x2::balance::value<0x2::sui::SUI>(&arg2.balance)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg2.balance, v0, arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

