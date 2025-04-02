module 0x999a5e4e5cadf76be0ffa5203086a39bbd6eb983d70e708f62562bc78d3f9484::kiosk {
    struct TShirt has store, key {
        id: 0x2::object::UID,
    }

    struct KIOSK has drop {
        dummy_field: bool,
    }

    public fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<TShirt>(arg0, arg1, arg2, arg3);
    }

    public fun place(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: TShirt) {
        0x2::kiosk::place<TShirt>(arg0, arg1, arg2);
    }

    public fun confirm_request(arg0: &0x2::transfer_policy::TransferPolicy<TShirt>, arg1: 0x2::transfer_policy::TransferRequest<TShirt>) {
        let (_, _, _) = 0x2::transfer_policy::confirm_request<TShirt>(arg0, arg1);
    }

    public fun buy(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>) : (TShirt, 0x2::transfer_policy::TransferRequest<TShirt>) {
        0x2::kiosk::purchase<TShirt>(arg0, arg1, arg2)
    }

    fun init(arg0: KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://placehold.co/600x400/"));
        let v4 = 0x2::package::claim<KIOSK>(arg0, arg1);
        new_policy(&v4, arg1);
        let v5 = 0x2::display::new_with_fields<TShirt>(&v4, v0, v2, arg1);
        0x2::display::update_version<TShirt>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TShirt>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = new_tshirt(arg1);
        0x2::transfer::public_transfer<TShirt>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun lock_into_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<TShirt>, arg3: TShirt) {
        0x2::kiosk::lock<TShirt>(arg0, arg1, arg2, arg3);
    }

    public fun new_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun new_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<TShirt>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<TShirt>(&mut v3, &v2, 5000, 1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<TShirt>(&mut v3, &v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<TShirt>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<TShirt>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun new_tshirt(arg0: &mut 0x2::tx_context::TxContext) : TShirt {
        TShirt{id: 0x2::object::new(arg0)}
    }

    public fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : TShirt {
        0x2::kiosk::take<TShirt>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v6
}

