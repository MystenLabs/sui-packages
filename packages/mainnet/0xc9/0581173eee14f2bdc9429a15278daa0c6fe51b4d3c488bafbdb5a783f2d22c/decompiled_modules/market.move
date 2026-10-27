module 0xc90581173eee14f2bdc9429a15278daa0c6fe51b4d3c488bafbdb5a783f2d22c::market {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        royalty_bps: u64,
        receiver: address,
    }

    struct Sold<phantom T0> has copy, drop {
        item: 0x2::object::ID,
        seller: 0x2::object::ID,
        buyer: 0x2::object::ID,
        price: u64,
        royalty: u64,
    }

    struct Gifted<phantom T0> has copy, drop {
        item: 0x2::object::ID,
        from: 0x2::object::ID,
        to: 0x2::object::ID,
        recipient: address,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u64, arg3: address) {
        assert!(arg2 <= 10000, 13891353308322332673);
        assert!(arg3 != @0x0, 13891634787594141699);
        let v0 = Rule{dummy_field: false};
        let v1 = Config{
            royalty_bps : arg2,
            receiver    : arg3,
        };
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    public fun buy<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::transfer_policy::TransferPolicy<T0>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = royalty<T0>(arg4, arg2);
        let (v1, v2) = 0x2::kiosk::purchase<T0>(arg0, arg1, 0x2::coin::split<0x2::sui::SUI>(arg3, arg2, arg7));
        let v3 = v2;
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v0, arg7), receiver<T0>(arg4));
        };
        0x2::kiosk::lock<T0>(arg5, arg6, arg4, v1);
        let v4 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v4, &mut v3);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg4, v3);
        let v8 = Sold<T0>{
            item    : arg1,
            seller  : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            buyer   : 0x2::object::id<0x2::kiosk::Kiosk>(arg5),
            price   : arg2,
            royalty : v0,
        };
        0x2::event::emit<Sold<T0>>(v8);
    }

    public fun gift<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 != @0x0, 13891635002342506499);
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg0, 0x2::kiosk::list_with_purchase_cap<T0>(arg0, arg1, arg2, 0, arg5), 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v2 = v1;
        let (v3, v4) = 0x2::kiosk::new(arg5);
        let v5 = v4;
        let v6 = v3;
        0x2::kiosk::set_owner_custom(&mut v6, &v5, arg4);
        0x2::kiosk::lock<T0>(&mut v6, &v5, arg3, v0);
        let v7 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v7, &mut v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v2);
        let v11 = Gifted<T0>{
            item      : arg2,
            from      : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            to        : 0x2::object::id<0x2::kiosk::Kiosk>(&v6),
            recipient : arg4,
        };
        0x2::event::emit<Gifted<T0>>(v11);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, arg4);
    }

    public fun receiver<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : address {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).receiver
    }

    public fun remove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
    }

    public fun royalty<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: u64) : u64 {
        let v0 = Rule{dummy_field: false};
        (((arg1 as u128) * (0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).royalty_bps as u128) / (10000 as u128)) as u64)
    }

    public fun royalty_bps<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>) : u64 {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).royalty_bps
    }

    // decompiled from Move bytecode v7
}

