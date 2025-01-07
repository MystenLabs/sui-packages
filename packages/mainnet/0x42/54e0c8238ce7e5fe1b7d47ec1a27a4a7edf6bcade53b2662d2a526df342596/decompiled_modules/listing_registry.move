module 0x4254e0c8238ce7e5fe1b7d47ec1a27a4a7edf6bcade53b2662d2a526df342596::listing_registry {
    struct ListingRegistry has key {
        id: 0x2::object::UID,
    }

    struct ListingInfo has drop, store {
        kiosk_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct ListingRegistered has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct ListingUpdated has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        price: u64,
        seller: address,
    }

    struct ListingRemoved has copy, drop {
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
    }

    public fun get_listing_info(arg0: &ListingRegistry, arg1: 0x2::object::ID) : (0x2::object::ID, u64, address) {
        assert!(0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1), 1);
        let v0 = 0x2::dynamic_field::borrow<0x2::object::ID, ListingInfo>(&arg0.id, arg1);
        (v0.kiosk_id, v0.price, v0.seller)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ListingRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<ListingRegistry>(v0);
    }

    public fun is_listed(arg0: &ListingRegistry, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)
    }

    public(friend) fun register_or_update_listing(arg0: &mut ListingRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: address) {
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<0x2::object::ID, ListingInfo>(&mut arg0.id, arg1);
            let v0 = ListingUpdated{
                nft_id   : arg1,
                kiosk_id : arg2,
                price    : arg3,
                seller   : arg4,
            };
            0x2::event::emit<ListingUpdated>(v0);
        };
        let v1 = ListingInfo{
            kiosk_id : arg2,
            price    : arg3,
            seller   : arg4,
        };
        0x2::dynamic_field::add<0x2::object::ID, ListingInfo>(&mut arg0.id, arg1, v1);
        if (!0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            let v2 = ListingRegistered{
                nft_id   : arg1,
                kiosk_id : arg2,
                price    : arg3,
                seller   : arg4,
            };
            0x2::event::emit<ListingRegistered>(v2);
        };
    }

    public fun remove_listing(arg0: &mut ListingRegistry, arg1: 0x2::object::ID) {
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            let ListingInfo {
                kiosk_id : v0,
                price    : _,
                seller   : _,
            } = 0x2::dynamic_field::remove<0x2::object::ID, ListingInfo>(&mut arg0.id, arg1);
            let v3 = ListingRemoved{
                nft_id   : arg1,
                kiosk_id : v0,
            };
            0x2::event::emit<ListingRemoved>(v3);
        };
    }

    public fun verify_kiosk(arg0: &ListingRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID) : bool {
        if (0x2::dynamic_field::exists_<0x2::object::ID>(&arg0.id, arg1)) {
            return 0x2::dynamic_field::borrow<0x2::object::ID, ListingInfo>(&arg0.id, arg1).kiosk_id == arg2
        };
        false
    }

    // decompiled from Move bytecode v6
}

