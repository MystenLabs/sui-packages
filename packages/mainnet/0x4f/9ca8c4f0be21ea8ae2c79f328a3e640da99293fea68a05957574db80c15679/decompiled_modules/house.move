module 0x4f9ca8c4f0be21ea8ae2c79f328a3e640da99293fea68a05957574db80c15679::house {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct House has store, key {
        id: 0x2::object::UID,
        fee_percentage: u64,
        fee_balance: 0x2::bag::Bag,
        kiosk_owner_cap: 0x2::kiosk::KioskOwnerCap,
    }

    public fun change_fee_percentage(arg0: &AdminCap, arg1: &mut House, arg2: u64) {
        assert!(arg2 <= 10000, 2);
        arg1.fee_percentage = arg2;
    }

    public(friend) fun deposit_item<T0: store + key>(arg0: &House, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0) {
        0x2::kiosk::place<T0>(arg1, &arg0.kiosk_owner_cap, arg2);
    }

    public(friend) fun deposit_item_with_lock<T0: store + key>(arg0: &House, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: T0) {
        0x2::kiosk::lock<T0>(arg1, &arg0.kiosk_owner_cap, arg2, arg3);
    }

    public(friend) fun get_fee_from_payment<T0>(arg0: &mut House, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.fee_balance, v0)) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balance, v0, 0x2::balance::zero<T0>());
        };
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.fee_balance, v0), 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, 0x4f9ca8c4f0be21ea8ae2c79f328a3e640da99293fea68a05957574db80c15679::utils::mul_div_u64(0x2::coin::value<T0>(arg1), arg0.fee_percentage, 10000), arg2)));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        let v2 = House{
            id              : 0x2::object::new(arg0),
            fee_percentage  : 0,
            fee_balance     : 0x2::bag::new(arg0),
            kiosk_owner_cap : v1,
        };
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<House>(v2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<AdminCap>(v3, 0x2::tx_context::sender(arg0));
    }

    public fun new_admin_cap(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun withdraw_fee<T0>(arg0: &AdminCap, arg1: &mut House, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.fee_balance, 0x1::type_name::get<T0>());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v0, 0x2::balance::value<T0>(v0)), arg2)
    }

    public(friend) fun withdraw_item<T0: store + key>(arg0: &House, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID) : T0 {
        0x2::kiosk::take<T0>(arg1, &arg0.kiosk_owner_cap, arg2)
    }

    public(friend) fun withdraw_item_with_lock<T0: store + key>(arg0: &House, arg1: &mut 0x2::kiosk::Kiosk, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        0x2::kiosk::list<T0>(arg1, &arg0.kiosk_owner_cap, arg2, 0);
        0x2::kiosk::purchase<T0>(arg1, arg2, 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    // decompiled from Move bytecode v6
}

