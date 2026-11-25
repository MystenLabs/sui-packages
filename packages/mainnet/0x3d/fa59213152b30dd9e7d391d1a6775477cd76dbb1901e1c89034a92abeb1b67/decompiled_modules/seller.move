module 0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::seller {
    struct Seller has key {
        id: 0x2::object::UID,
        payout: address,
        name_hash: vector<u8>,
        adapter: 0x1::option::Option<0x1::type_name::TypeName>,
    }

    struct SellerCap has store, key {
        id: 0x2::object::UID,
        seller_id: 0x2::object::ID,
    }

    struct SellerRegistered has copy, drop {
        seller_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        payout: address,
    }

    struct ExternalSellerRegistered has copy, drop {
        seller_id: 0x2::object::ID,
        adapter: 0x1::type_name::TypeName,
    }

    struct PayoutChanged has copy, drop {
        seller_id: 0x2::object::ID,
        payout: address,
    }

    fun new(arg0: address, arg1: vector<u8>, arg2: 0x1::option::Option<0x1::type_name::TypeName>, arg3: &mut 0x2::tx_context::TxContext) : SellerCap {
        let v0 = Seller{
            id        : 0x2::object::new(arg3),
            payout    : arg0,
            name_hash : arg1,
            adapter   : arg2,
        };
        let v1 = 0x2::object::id<Seller>(&v0);
        let v2 = SellerCap{
            id        : 0x2::object::new(arg3),
            seller_id : v1,
        };
        let v3 = SellerRegistered{
            seller_id : v1,
            cap_id    : 0x2::object::id<SellerCap>(&v2),
            payout    : arg0,
        };
        0x2::event::emit<SellerRegistered>(v3);
        0x2::transfer::share_object<Seller>(v0);
        v2
    }

    public fun adapter(arg0: &Seller) : 0x1::option::Option<0x1::type_name::TypeName> {
        arg0.adapter
    }

    public fun cap_seller_id(arg0: &SellerCap) : 0x2::object::ID {
        arg0.seller_id
    }

    public fun payout(arg0: &Seller) : address {
        arg0.payout
    }

    public fun register(arg0: address, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : SellerCap {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        new(arg0, arg2, 0x1::option::none<0x1::type_name::TypeName>(), arg3)
    }

    public fun register_external<T0>(arg0: address, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : SellerCap {
        abort 63
    }

    public fun register_external_with_permit<T0>(arg0: address, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: vector<u8>, arg3: 0x1::internal::Permit<T0>, arg4: &mut 0x2::tx_context::TxContext) : SellerCap {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = new(arg0, arg2, 0x1::option::some<0x1::type_name::TypeName>(v0), arg4);
        let v2 = ExternalSellerRegistered{
            seller_id : v1.seller_id,
            adapter   : v0,
        };
        0x2::event::emit<ExternalSellerRegistered>(v2);
        v1
    }

    public fun set_payout(arg0: &mut Seller, arg1: &0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::Version, arg2: &SellerCap, arg3: address) {
        0xdf9873490d446acd8d50a87cb69ed68d7144a25567ed1b24a90de30e4387320::version::assert_current(arg1);
        assert!(arg2.seller_id == 0x2::object::id<Seller>(arg0), 40);
        assert!(0x1::option::is_none<0x1::type_name::TypeName>(&arg0.adapter), 48);
        arg0.payout = arg3;
        let v0 = PayoutChanged{
            seller_id : arg2.seller_id,
            payout    : arg3,
        };
        0x2::event::emit<PayoutChanged>(v0);
    }

    // decompiled from Move bytecode v7
}

