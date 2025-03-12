module 0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::marketplace {
    struct MarketPlaceCap has store, key {
        id: 0x2::object::UID,
    }

    public fun delist(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        0x2::kiosk::delist<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg0, arg1, arg2);
    }

    public fun lock(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::transfer_policy::TransferPolicy<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>, arg3: 0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item) {
        0x2::kiosk::lock<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg0, arg1, arg2, arg3);
    }

    public fun place(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::KioskOwnerCap, arg2: 0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item) {
        0x2::kiosk::place<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg0, arg1, arg2);
    }

    public fun purchase(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::marketplace_royalty_rule::calculate<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg1, arg3);
        let v1 = 0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::marketplace_royalty_rule::get(&v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg4) >= v1 + arg3, 9223372483531374593);
        let (v2, v3) = 0x2::kiosk::purchase<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg0, arg2, 0x2::coin::split<0x2::sui::SUI>(arg4, arg3, arg5));
        let v4 = v3;
        0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::marketplace_royalty_rule::handle<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg1, &mut v4, v0, 0x2::coin::split<0x2::sui::SUI>(arg4, v1, arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg1, v4);
        0x2::transfer::public_transfer<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(v2, 0x2::tx_context::sender(arg5));
    }

    public fun take(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(0x2::kiosk::take<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg0, arg1, arg2), 0x2::tx_context::sender(arg3));
    }

    public fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::kiosk::withdraw(arg0, arg1, arg2, arg3)
    }

    public fun create_kiosk(arg0: &MarketPlaceCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>, arg2: &mut 0x2::transfer_policy::TransferPolicyCap<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg3);
        0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::marketplace_lock_rule::add<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg1, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg3));
    }

    public fun create_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>>(v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketPlaceCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MarketPlaceCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun list(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::kiosk::PurchaseCap<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>>(0x2::kiosk::list_with_purchase_cap<0xa6c46e36729e1bf1e567230726b10357f0c5587e48de14b71278134f0f60e479::bravechain::Item>(arg0, arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

