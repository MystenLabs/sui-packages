module 0x7755b7c5cea698b003c775b16ed2c8f9a4a26743cecbe689ef44dc093af5b633::lending_storage {
    struct LENDING_STORAGE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LendingStorage has key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        admin_cap_id: 0x2::object::ID,
        version: u64,
        collections: 0x2::object_bag::ObjectBag,
    }

    struct CollectionTypeInfo has store {
        package_address: 0x1::ascii::String,
        module_name: 0x1::ascii::String,
    }

    struct Collection<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        offers: 0x2::object_table::ObjectTable<0x2::object::ID, Offer>,
        interest: u64,
        name: 0x1::ascii::String,
        url: 0x1::ascii::String,
        type_info: CollectionTypeInfo,
    }

    struct Offer has store, key {
        id: 0x2::object::UID,
        collection: 0x1::ascii::String,
        creator: address,
        value: u64,
        interest: u64,
        start_time: u64,
        period: u64,
        is_started: bool,
        is_repaid: bool,
        is_claimed: bool,
    }

    struct KioskData has store, key {
        id: 0x2::object::UID,
        owner: address,
        kiosk_id: 0x2::object::ID,
    }

    struct OfferResponse has copy, drop {
        id: 0x2::object::ID,
        collection_name: 0x1::ascii::String,
        lender: address,
        borrower: address,
        value: u64,
        interest: u64,
        start_time: u64,
        period: u64,
        is_started: bool,
        is_repaid: bool,
        is_claimed: bool,
    }

    public(friend) fun borrow_collection<T0>(arg0: &mut LendingStorage, arg1: 0x1::ascii::String) : &mut Collection<T0> {
        0x2::object_bag::borrow_mut<0x1::ascii::String, Collection<T0>>(&mut arg0.collections, arg1)
    }

    public(friend) fun borrow_offer<T0>(arg0: &mut Collection<T0>, arg1: 0x2::object::ID) : &mut Offer {
        0x2::object_table::borrow_mut<0x2::object::ID, Offer>(&mut arg0.offers, arg1)
    }

    public fun check_offer_active_status(arg0: &Offer, arg1: &0x2::clock::Clock) : bool {
        arg0.is_started && arg0.start_time + convert_period_to_ms(arg0.period) > 0x2::clock::timestamp_ms(arg1)
    }

    public fun check_offer_finished_status(arg0: &Offer, arg1: &0x2::clock::Clock) : bool {
        arg0.is_started && arg0.start_time + convert_period_to_ms(arg0.period) < 0x2::clock::timestamp_ms(arg1)
    }

    public(friend) fun close_kiosk<T0: store + key>(arg0: 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: 0x2::transfer_policy::TransferPolicy<T0>, arg3: 0x2::transfer_policy::TransferPolicyCap<T0>, arg4: 0x2::kiosk::PurchaseCap<T0>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(&mut arg0, arg4, 0x2::coin::zero<0x2::sui::SUI>(arg6));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(&arg2, v1);
        0x2::transfer::public_transfer<T0>(v0, arg5);
        0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::kiosk::close_and_withdraw(arg0, arg1, arg6));
        0x2::coin::destroy_zero<0x2::sui::SUI>(0x2::transfer_policy::destroy_and_withdraw<T0>(arg2, arg3, arg6));
    }

    fun convert_period_to_ms(arg0: u64) : u64 {
        arg0 * 24 * 60 * 60 * 1000
    }

    public(friend) fun create_collection<T0, T1: store + key>(arg0: &mut LendingStorage, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = CollectionTypeInfo{
            package_address : 0x1::type_name::get_address(&v0),
            module_name     : 0x1::type_name::get_module(&v0),
        };
        let v2 = Collection<T0>{
            id        : 0x2::object::new(arg4),
            balance   : 0x2::balance::zero<T0>(),
            offers    : 0x2::object_table::new<0x2::object::ID, Offer>(arg4),
            interest  : arg3,
            name      : arg1,
            url       : arg2,
            type_info : v1,
        };
        0x2::object_bag::add<0x1::ascii::String, Collection<T0>>(&mut arg0.collections, arg1, v2);
        0x2::object::uid_to_inner(&v2.id)
    }

    public(friend) fun create_kiosk<T0: store + key>(arg0: &LendingStorage, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap, 0x2::transfer_policy::TransferPolicy<T0>, 0x2::transfer_policy::TransferPolicyCap<T0>, 0x2::kiosk::PurchaseCap<T0>) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(&arg0.publisher, arg2);
        let (v2, v3) = 0x2::kiosk::new(arg2);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::place<T0>(&mut v5, &v4, arg1);
        (v5, v4, v0, v1, 0x2::kiosk::list_with_purchase_cap<T0>(&mut v5, &v4, 0x2::object::id<T0>(&arg1), 0, arg2))
    }

    public(friend) fun create_kiosk_data<T0: store + key>(arg0: &mut Offer, arg1: address, arg2: 0x2::kiosk::Kiosk, arg3: 0x2::kiosk::KioskOwnerCap, arg4: 0x2::transfer_policy::TransferPolicy<T0>, arg5: 0x2::transfer_policy::TransferPolicyCap<T0>, arg6: 0x2::kiosk::PurchaseCap<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<0x2::kiosk::Kiosk>(&arg2);
        let v1 = KioskData{
            id       : 0x2::object::new(arg7),
            owner    : arg1,
            kiosk_id : v0,
        };
        0x2::object::uid_to_inner(&v1.id);
        0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::Kiosk>(&mut v1.id, b"kiosk", arg2);
        0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::KioskOwnerCap>(&mut v1.id, b"kiosk_owner_cap", arg3);
        0x2::dynamic_object_field::add<vector<u8>, 0x2::transfer_policy::TransferPolicy<T0>>(&mut v1.id, b"policy", arg4);
        0x2::dynamic_object_field::add<vector<u8>, 0x2::transfer_policy::TransferPolicyCap<T0>>(&mut v1.id, b"policy_cap", arg5);
        0x2::dynamic_object_field::add<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v1.id, b"purchase_cap", arg6);
        0x2::dynamic_object_field::add<bool, KioskData>(&mut arg0.id, true, v1);
        v0
    }

    public(friend) fun create_offer<T0>(arg0: &mut LendingStorage, arg1: 0x1::ascii::String, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = borrow_collection<T0>(arg0, arg1);
        assert!(v0 > 5000000, 101);
        let v2 = Offer{
            id         : 0x2::object::new(arg5),
            collection : arg1,
            creator    : 0x2::tx_context::sender(arg5),
            value      : v0,
            interest   : get_collection_interest<T0>(v1),
            start_time : arg3,
            period     : arg4,
            is_started : false,
            is_repaid  : false,
            is_claimed : false,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x2::object_table::add<0x2::object::ID, Offer>(&mut v1.offers, v3, v2);
        0x2::balance::join<T0>(&mut v1.balance, 0x2::coin::into_balance<T0>(arg2));
        v3
    }

    public fun create_offer_response<T0>(arg0: 0x1::ascii::String, arg1: &Offer) : OfferResponse {
        OfferResponse{
            id              : 0x2::object::id<Offer>(arg1),
            collection_name : arg0,
            lender          : arg1.creator,
            borrower        : get_offer_borrower(arg1),
            value           : arg1.value,
            interest        : arg1.interest,
            start_time      : arg1.start_time,
            period          : arg1.period,
            is_started      : arg1.is_started,
            is_repaid       : arg1.is_repaid,
            is_claimed      : arg1.is_claimed,
        }
    }

    public(friend) fun destructure_offer(arg0: Offer) : 0x2::object::ID {
        let Offer {
            id         : v0,
            collection : _,
            creator    : _,
            value      : _,
            interest   : _,
            start_time : _,
            period     : _,
            is_started : _,
            is_repaid  : _,
            is_claimed : _,
        } = arg0;
        let v10 = v0;
        0x2::object::delete(v10);
        0x2::object::uid_to_inner(&v10)
    }

    public fun get_collection_interest<T0>(arg0: &Collection<T0>) : u64 {
        arg0.interest
    }

    public fun get_collection_type_info<T0>(arg0: &Collection<T0>) : (0x1::ascii::String, 0x1::ascii::String) {
        (arg0.type_info.package_address, arg0.type_info.module_name)
    }

    public fun get_offer_borrower(arg0: &Offer) : address {
        let v0 = @0x0;
        if (0x2::dynamic_object_field::exists_<bool>(&arg0.id, true)) {
            v0 = 0x2::dynamic_object_field::borrow<bool, KioskData>(&arg0.id, true).owner;
        };
        v0
    }

    public fun get_offer_interest(arg0: &Offer) : u64 {
        arg0.interest
    }

    public fun get_offer_is_claimed(arg0: &Offer) : bool {
        arg0.is_claimed
    }

    public fun get_offer_is_repaid(arg0: &Offer) : bool {
        arg0.is_repaid
    }

    public fun get_offer_is_started(arg0: &Offer) : bool {
        arg0.is_started
    }

    public fun get_offer_owner(arg0: &Offer) : address {
        arg0.creator
    }

    public fun get_offer_period(arg0: &Offer) : u64 {
        arg0.period
    }

    public fun get_offer_start_time(arg0: &Offer) : u64 {
        arg0.start_time
    }

    public fun get_offer_value(arg0: &Offer) : u64 {
        arg0.value
    }

    public fun get_offer_value_from_collection<T0>(arg0: &LendingStorage, arg1: 0x1::ascii::String, arg2: 0x2::object::ID) : u64 {
        0x2::object_table::borrow<0x2::object::ID, Offer>(&read_collection<T0>(arg0, arg1).offers, arg2).value
    }

    fun init(arg0: LENDING_STORAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<AdminCap>(v0);
        let v1 = LendingStorage{
            id           : 0x2::object::new(arg1),
            publisher    : 0x2::package::claim<LENDING_STORAGE>(arg0, arg1),
            admin_cap_id : 0x2::object::uid_to_inner(&v0.id),
            version      : 1,
            collections  : 0x2::object_bag::new(arg1),
        };
        0x2::transfer::share_object<LendingStorage>(v1);
    }

    public(friend) fun join_collection_balance<T0>(arg0: &mut Collection<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun read_collection<T0>(arg0: &LendingStorage, arg1: 0x1::ascii::String) : &Collection<T0> {
        0x2::object_bag::borrow<0x1::ascii::String, Collection<T0>>(&arg0.collections, arg1)
    }

    public fun read_offer<T0>(arg0: &Collection<T0>, arg1: 0x2::object::ID) : &Offer {
        0x2::object_table::borrow<0x2::object::ID, Offer>(&arg0.offers, arg1)
    }

    public(friend) fun remove_kiosk_data<T0: store + key>(arg0: &mut Offer, arg1: &mut 0x2::tx_context::TxContext) : (address, 0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap, 0x2::transfer_policy::TransferPolicy<T0>, 0x2::transfer_policy::TransferPolicyCap<T0>, 0x2::kiosk::PurchaseCap<T0>) {
        let KioskData {
            id       : v0,
            owner    : v1,
            kiosk_id : v2,
        } = 0x2::dynamic_object_field::remove<bool, KioskData>(&mut arg0.id, true);
        let v3 = v0;
        0x2::object::delete(v3);
        let v4 = KioskData{
            id       : 0x2::object::new(arg1),
            owner    : v1,
            kiosk_id : v2,
        };
        0x2::dynamic_object_field::add<bool, KioskData>(&mut arg0.id, true, v4);
        (v1, 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::Kiosk>(&mut v3, b"kiosk"), 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::KioskOwnerCap>(&mut v3, b"kiosk_owner_cap"), 0x2::dynamic_object_field::remove<vector<u8>, 0x2::transfer_policy::TransferPolicy<T0>>(&mut v3, b"policy"), 0x2::dynamic_object_field::remove<vector<u8>, 0x2::transfer_policy::TransferPolicyCap<T0>>(&mut v3, b"policy_cap"), 0x2::dynamic_object_field::remove<vector<u8>, 0x2::kiosk::PurchaseCap<T0>>(&mut v3, b"purchase_cap"))
    }

    public(friend) fun remove_offer<T0>(arg0: &mut Collection<T0>, arg1: 0x2::object::ID) : Offer {
        0x2::object_table::remove<0x2::object::ID, Offer>(&mut arg0.offers, arg1)
    }

    public(friend) fun set_kiosk_owner(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: address) {
        0x2::kiosk::set_owner_custom(arg0, arg1, arg2);
    }

    public(friend) fun set_offer_as_claimed(arg0: &mut Offer) {
        arg0.is_claimed = true;
    }

    public(friend) fun set_offer_as_paid(arg0: &mut Offer) {
        arg0.is_repaid = true;
    }

    public(friend) fun split_collection_balance<T0>(arg0: &mut Collection<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, arg1), arg2)
    }

    public(friend) fun start_offer(arg0: &mut Offer, arg1: &0x2::clock::Clock) {
        arg0.start_time = 0x2::clock::timestamp_ms(arg1);
        arg0.is_started = true;
    }

    // decompiled from Move bytecode v6
}

