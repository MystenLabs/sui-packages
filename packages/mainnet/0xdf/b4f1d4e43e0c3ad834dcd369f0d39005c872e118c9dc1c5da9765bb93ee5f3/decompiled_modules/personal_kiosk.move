module 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk {
    struct PersonalKioskCap has key {
        id: 0x2::object::UID,
        cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
    }

    struct Borrow {
        cap_id: 0x2::object::ID,
        owned_id: 0x2::object::ID,
    }

    struct OwnerMarker has copy, drop, store {
        dummy_field: bool,
    }

    struct NewPersonalKiosk has copy, drop {
        kiosk_id: 0x2::object::ID,
    }

    public fun borrow(arg0: &PersonalKioskCap) : &0x2::kiosk::KioskOwnerCap {
        0x1::option::borrow<0x2::kiosk::KioskOwnerCap>(&arg0.cap)
    }

    public fun borrow_mut(arg0: &mut PersonalKioskCap) : &mut 0x2::kiosk::KioskOwnerCap {
        0x1::option::borrow_mut<0x2::kiosk::KioskOwnerCap>(&mut arg0.cap)
    }

    public fun new(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) : PersonalKioskCap {
        let v0 = 0x2::tx_context::sender(arg2);
        create(arg0, arg1, v0, arg2)
    }

    public fun borrow_val(arg0: &mut PersonalKioskCap) : (0x2::kiosk::KioskOwnerCap, Borrow) {
        let v0 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg0.cap);
        let v1 = Borrow{
            cap_id   : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v0),
            owned_id : 0x2::object::id<PersonalKioskCap>(arg0),
        };
        (v0, v1)
    }

    fun create(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : PersonalKioskCap {
        assert!(0x2::kiosk::has_access(arg0, &arg1), 3);
        0x2::kiosk::set_owner_custom(arg0, &arg1, arg2);
        let v0 = OwnerMarker{dummy_field: false};
        0x2::dynamic_field::add<OwnerMarker, address>(0x2::kiosk::uid_mut_as_owner(arg0, &arg1), v0, arg2);
        let v1 = NewPersonalKiosk{kiosk_id: 0x2::object::id<0x2::kiosk::Kiosk>(arg0)};
        0x2::event::emit<NewPersonalKiosk>(v1);
        PersonalKioskCap{
            id  : 0x2::object::new(arg3),
            cap : 0x1::option::some<0x2::kiosk::KioskOwnerCap>(arg1),
        }
    }

    public fun create_for(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<PersonalKioskCap>(create(arg0, arg1, arg2, arg3), arg2);
    }

    entry fun default(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new(arg0, arg1, arg2);
        transfer_to_sender(v0, arg2);
    }

    public fun is_personal(arg0: &0x2::kiosk::Kiosk) : bool {
        let v0 = OwnerMarker{dummy_field: false};
        0x2::dynamic_field::exists_<OwnerMarker>(0x2::kiosk::uid(arg0), v0)
    }

    public fun owner(arg0: &0x2::kiosk::Kiosk) : address {
        assert!(is_personal(arg0), 2);
        let v0 = OwnerMarker{dummy_field: false};
        *0x2::dynamic_field::borrow<OwnerMarker, address>(0x2::kiosk::uid(arg0), v0)
    }

    public fun return_val(arg0: &mut PersonalKioskCap, arg1: 0x2::kiosk::KioskOwnerCap, arg2: Borrow) {
        let Borrow {
            cap_id   : v0,
            owned_id : v1,
        } = arg2;
        assert!(0x2::object::id<PersonalKioskCap>(arg0) == v1, 1);
        assert!(0x2::object::id<0x2::kiosk::KioskOwnerCap>(&arg1) == v0, 0);
        0x1::option::fill<0x2::kiosk::KioskOwnerCap>(&mut arg0.cap, arg1);
    }

    public fun transfer_to_sender(arg0: PersonalKioskCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<PersonalKioskCap>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun try_owner(arg0: &0x2::kiosk::Kiosk) : 0x1::option::Option<address> {
        if (is_personal(arg0)) {
            0x1::option::some<address>(owner(arg0))
        } else {
            0x1::option::none<address>()
        }
    }

    // decompiled from Move bytecode v6
}

