module 0x6e0dbcca8aacf1847da359137d9039142c76b8942e45c80b881b1c042b2eb592::kiosk {
    struct TShirt has store, key {
        id: 0x2::object::UID,
    }

    struct KIOSK has drop {
        dummy_field: bool,
    }

    public fun confirm_request(arg0: &0x2::transfer_policy::TransferPolicy<TShirt>, arg1: 0x2::transfer_policy::TransferRequest<TShirt>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<TShirt>(arg0, arg1);
    }

    public fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (TShirt, 0x2::transfer_policy::TransferRequest<TShirt>) {
        0x2::kiosk::purchase<TShirt>(arg0, arg1, arg2)
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<KIOSK>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let (v0, v1) = 0x2::kiosk::new(arg1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun new_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<TShirt>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TShirt>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TShirt>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun new_tshirt(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TShirt{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<TShirt>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun place_and_list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: TShirt, arg3: u64) {
        0x2::kiosk::place<TShirt>(arg0, arg1, arg2);
        0x2::kiosk::list<TShirt>(arg0, arg1, 0x2::object::id<TShirt>(&arg2), arg3);
    }

    public entry fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<TShirt>(0x2::kiosk::take<TShirt>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

