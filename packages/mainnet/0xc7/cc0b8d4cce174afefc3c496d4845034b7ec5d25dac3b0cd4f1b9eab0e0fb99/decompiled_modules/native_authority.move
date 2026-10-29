module 0xc7cc0b8d4cce174afefc3c496d4845034b7ec5d25dac3b0cd4f1b9eab0e0fb99::native_authority {
    struct Authority has store {
        cap: 0x2::kiosk::KioskOwnerCap,
        kiosk: 0x2::object::ID,
        owner: address,
        closed_digest: vector<u8>,
    }

    public fun borrow<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : &T0 {
        assert_pair(arg0, arg1, arg3);
        0x2::kiosk::borrow<T0>(arg0, &arg1.cap, arg2)
    }

    public fun borrow_mut<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : &mut T0 {
        open(arg0, arg1, arg3);
        0x2::kiosk::borrow_mut<T0>(arg0, &arg1.cap, arg2)
    }

    public fun list<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        open(arg0, arg1, arg4);
        0x2::kiosk::list<T0>(arg0, &arg1.cap, arg2, arg3);
    }

    public fun lock<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: T0, arg4: &0x2::tx_context::TxContext) {
        open(arg0, arg1, arg4);
        0x2::kiosk::lock<T0>(arg0, &arg1.cap, arg2, arg3);
    }

    public fun owner(arg0: &Authority) : address {
        arg0.owner
    }

    public fun place<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: T0, arg3: &0x2::tx_context::TxContext) {
        open(arg0, arg1, arg3);
        0x2::kiosk::place<T0>(arg0, &arg1.cap, arg2);
    }

    public fun take<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : T0 {
        open(arg0, arg1, arg3);
        0x2::kiosk::take<T0>(arg0, &arg1.cap, arg2)
    }

    public fun withdraw(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        open(arg0, arg1, arg3);
        0x2::kiosk::withdraw(arg0, &arg1.cap, arg2, arg3)
    }

    public fun add_extension<T0: drop>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &Authority, arg3: &mut 0x2::tx_context::TxContext) {
        open(arg1, arg2, arg3);
        0x2::kiosk_extension::add<T0>(arg0, arg1, &arg2.cap, 0, arg3);
    }

    public fun assert_legacy_disabled(arg0: &0x2::kiosk::Kiosk) {
        let v0 = 0x1::bcs::to_bytes<0x2::kiosk::Kiosk>(arg0);
        assert!(0x1::vector::length<u8>(&v0) == 77, 14);
        let v1 = 0x2::bcs::new(v0);
        let v2 = 0x2::bcs::peel_u8(&mut v1);
        let v3 = if (v2 <= 1) {
            let v4 = 0x2::bcs::into_remainder_bytes(v1);
            0x1::vector::is_empty<u8>(&v4)
        } else {
            false
        };
        assert!(v3, 14);
        let v5 = 0x2::object::id<0x2::kiosk::Kiosk>(arg0);
        let v6 = if (0x2::bcs::peel_address(&mut v1) == 0x2::object::id_to_address(&v5)) {
            if (0x2::bcs::peel_u64(&mut v1) == 0x2::kiosk::profits_amount(arg0)) {
                if (0x2::bcs::peel_address(&mut v1) == 0x2::kiosk::owner(arg0)) {
                    0x2::bcs::peel_u32(&mut v1) == 0x2::kiosk::item_count(arg0)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v6, 14);
        assert!(v2 == 0, 13);
    }

    public fun assert_pair(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 1);
        let v0 = if (arg1.kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg0)) {
            if (0x2::kiosk::owner(arg0) == arg1.owner) {
                0x2::kiosk::has_access(arg0, &arg1.cap)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
    }

    public(friend) fun borrow_locked_for_creation<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut Authority, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : &mut T0 {
        assert_pair(arg0, arg1, arg3);
        assert_legacy_disabled(arg0);
        assert!(0x2::kiosk::is_locked(arg0, arg2) && !0x2::kiosk::is_listed(arg0, arg2), 2);
        arg1.closed_digest = *0x2::tx_context::digest(arg3);
        0x2::kiosk::borrow_mut<T0>(arg0, &arg1.cap, arg2)
    }

    public fun cap_id(arg0: &Authority) : 0x2::object::ID {
        0x2::object::id<0x2::kiosk::KioskOwnerCap>(&arg0.cap)
    }

    public fun disable_extension<T0: drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: &0x2::tx_context::TxContext) {
        open(arg0, arg1, arg2);
        0x2::kiosk_extension::disable<T0>(arg0, &arg1.cap);
    }

    public fun enable_extension<T0: drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: &0x2::tx_context::TxContext) {
        open(arg0, arg1, arg2);
        0x2::kiosk_extension::enable<T0>(arg0, &arg1.cap);
    }

    public fun kiosk_id(arg0: &Authority) : 0x2::object::ID {
        arg0.kiosk
    }

    public fun list_exclusively<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) : 0x2::kiosk::PurchaseCap<T0> {
        open(arg0, arg1, arg3);
        0x2::kiosk::list_with_purchase_cap<T0>(arg0, &arg1.cap, arg2, 0, arg3)
    }

    public(friend) fun lock_creation<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut Authority, arg2: &0x2::transfer_policy::TransferPolicy<T0>, arg3: T0, arg4: &0x2::tx_context::TxContext) {
        assert_pair(arg0, arg1, arg4);
        assert_legacy_disabled(arg0);
        arg1.closed_digest = *0x2::tx_context::digest(arg4);
        0x2::kiosk::lock<T0>(arg0, &arg1.cap, arg2, arg3);
    }

    fun open(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: &0x2::tx_context::TxContext) {
        assert_pair(arg0, arg1, arg2);
        assert!(arg1.closed_digest != *0x2::tx_context::digest(arg2), 15);
    }

    public fun remove_extension<T0: drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: &0x2::tx_context::TxContext) {
        open(arg0, arg1, arg2);
        0x2::kiosk_extension::remove<T0>(arg0, &arg1.cap);
    }

    public fun seal(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::kiosk::KioskOwnerCap, arg2: &0x2::tx_context::TxContext) : Authority {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg2) && 0x2::kiosk::has_access(arg0, &arg1), 2);
        assert_legacy_disabled(arg0);
        Authority{
            cap           : arg1,
            kiosk         : 0x2::object::id<0x2::kiosk::Kiosk>(arg0),
            owner         : 0x2::tx_context::sender(arg2),
            closed_digest : b"",
        }
    }

    public(friend) fun service_borrow_root<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &Authority, arg2: 0x2::object::ID) : &mut T0 {
        let v0 = if (arg1.kiosk == 0x2::object::id<0x2::kiosk::Kiosk>(arg0)) {
            if (0x2::kiosk::owner(arg0) == arg1.owner) {
                0x2::kiosk::has_access(arg0, &arg1.cap)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        assert_legacy_disabled(arg0);
        assert!(0x2::kiosk::is_locked(arg0, arg2) && !0x2::kiosk::is_listed(arg0, arg2), 2);
        0x2::kiosk::borrow_mut<T0>(arg0, &arg1.cap, arg2)
    }

    // decompiled from Move bytecode v7
}

