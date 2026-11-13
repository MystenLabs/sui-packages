module 0xdc393697a95fb61c93060014ac162f93674bf36f95c22ff3b65a128f31d7dddc::seal {
    struct SiaynoqSeal has store, key {
        id: 0x2::object::UID,
        serial: u64,
        order_id: 0x1::string::String,
        issued_ms: u64,
    }

    struct SealIssuerCap has store, key {
        id: 0x2::object::UID,
    }

    struct SealRegistry has key {
        id: 0x2::object::UID,
        issued: u64,
        orders: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
    }

    struct SealIssued has copy, drop {
        seal_id: 0x2::object::ID,
        serial: u64,
        order_id: 0x1::string::String,
        kiosk_id: 0x2::object::ID,
        recipient: address,
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : (SealIssuerCap, SealRegistry) {
        let v0 = SealIssuerCap{id: 0x2::object::new(arg0)};
        let v1 = SealRegistry{
            id     : 0x2::object::new(arg0),
            issued : 0,
            orders : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
        };
        (v0, v1)
    }

    fun deliver(arg0: SiaynoqSeal, arg1: &0x2::transfer_policy::TransferPolicy<SiaynoqSeal>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::id<SiaynoqSeal>(&arg0);
        let (v1, v2) = 0x2::kiosk::new(arg3);
        let v3 = v2;
        let v4 = v1;
        0x2::kiosk::set_owner_custom(&mut v4, &v3, arg2);
        let v5 = SealIssued{
            seal_id   : v0,
            serial    : arg0.serial,
            order_id  : arg0.order_id,
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(&v4),
            recipient : arg2,
        };
        0x2::event::emit<SealIssued>(v5);
        0x2::kiosk::lock<SiaynoqSeal>(&mut v4, &v3, arg1, arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v3, arg2);
        v0
    }

    public(friend) fun issue_at_publish(arg0: &mut SealRegistry, arg1: &0x2::transfer_policy::TransferPolicy<SiaynoqSeal>, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v1 = new_seal_at(arg0, arg2, v0, arg4);
        deliver(v1, arg1, arg3, arg4)
    }

    public fun issue_into(arg0: &SealIssuerCap, arg1: &mut SealRegistry, arg2: &0x2::transfer_policy::TransferPolicy<SiaynoqSeal>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: 0x1::string::String, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_seal(arg1, arg5, arg6, arg7);
        let v1 = 0x2::object::id<SiaynoqSeal>(&v0);
        let v2 = SealIssued{
            seal_id   : v1,
            serial    : v0.serial,
            order_id  : v0.order_id,
            kiosk_id  : 0x2::object::id<0x2::kiosk::Kiosk>(arg3),
            recipient : 0x2::tx_context::sender(arg7),
        };
        0x2::event::emit<SealIssued>(v2);
        0x2::kiosk::lock<SiaynoqSeal>(arg3, arg4, arg2, v0);
        v1
    }

    public fun issue_to(arg0: &SealIssuerCap, arg1: &mut SealRegistry, arg2: &0x2::transfer_policy::TransferPolicy<SiaynoqSeal>, arg3: 0x1::string::String, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = new_seal(arg1, arg3, arg5, arg6);
        deliver(v0, arg2, arg4, arg6)
    }

    public fun issued(arg0: &SealRegistry) : u64 {
        arg0.issued
    }

    public fun issued_ms(arg0: &SiaynoqSeal) : u64 {
        arg0.issued_ms
    }

    fun new_seal(arg0: &mut SealRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : SiaynoqSeal {
        new_seal_at(arg0, arg1, 0x2::clock::timestamp_ms(arg2), arg3)
    }

    fun new_seal_at(arg0: &mut SealRegistry, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SiaynoqSeal {
        assert!(0x1::string::length(&arg1) > 0, 3);
        assert!(!0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.orders, arg1), 2);
        arg0.issued = arg0.issued + 1;
        let v0 = SiaynoqSeal{
            id        : 0x2::object::new(arg3),
            serial    : arg0.issued,
            order_id  : arg1,
            issued_ms : arg2,
        };
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.orders, arg1, 0x2::object::id<SiaynoqSeal>(&v0));
        v0
    }

    public fun order_id(arg0: &SiaynoqSeal) : 0x1::string::String {
        arg0.order_id
    }

    public fun order_used(arg0: &SealRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.orders, arg1)
    }

    public fun prove(arg0: &0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) : &SiaynoqSeal {
        assert!(0x2::kiosk::has_item_with_type<SiaynoqSeal>(arg0, arg2), 1);
        0x2::kiosk::borrow<SiaynoqSeal>(arg0, arg1, arg2)
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID) {
        prove(arg1, arg2, arg3);
    }

    public fun serial(arg0: &SiaynoqSeal) : u64 {
        arg0.serial
    }

    public(friend) fun share_registry(arg0: SealRegistry) {
        0x2::transfer::share_object<SealRegistry>(arg0);
    }

    // decompiled from Move bytecode v7
}

