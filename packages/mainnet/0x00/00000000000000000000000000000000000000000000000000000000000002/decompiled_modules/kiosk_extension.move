module 0x2::kiosk_extension {
    struct Extension has store {
        storage: 0x2::bag::Bag,
        permissions: u128,
        is_enabled: bool,
    }

    struct ExtensionKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun add<T0: drop>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::has_access(arg1, arg2), 0);
        let v0 = ExtensionKey<T0>{dummy_field: false};
        let v1 = Extension{
            storage     : 0x2::bag::new(arg4),
            permissions : arg3,
            is_enabled  : true,
        };
        0x2::dynamic_field::add<ExtensionKey<T0>, Extension>(0x2::kiosk::uid_mut_as_owner(arg1, arg2), v0, v1);
    }

    public fun remove<T0: drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 0);
        assert!(is_installed<T0>(arg0), 3);
        let v0 = ExtensionKey<T0>{dummy_field: false};
        let Extension {
            storage     : v1,
            permissions : _,
            is_enabled  : _,
        } = 0x2::dynamic_field::remove<ExtensionKey<T0>, Extension>(0x2::kiosk::uid_mut_as_owner(arg0, arg1), v0);
        0x2::bag::destroy_empty(v1);
    }

    public fun can_lock<T0: drop>(arg0: &0x2::kiosk::Kiosk) : bool {
        is_enabled<T0>(arg0) && extension<T0>(arg0).permissions & 2 != 0
    }

    public fun can_place<T0: drop>(arg0: &0x2::kiosk::Kiosk) : bool {
        is_enabled<T0>(arg0) && extension<T0>(arg0).permissions & 1 != 0
    }

    public fun disable<T0: drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 0);
        assert!(is_installed<T0>(arg0), 3);
        extension_mut<T0>(arg0).is_enabled = false;
    }

    public fun enable<T0: drop>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap) {
        assert!(0x2::kiosk::has_access(arg0, arg1), 0);
        assert!(is_installed<T0>(arg0), 3);
        extension_mut<T0>(arg0).is_enabled = true;
    }

    fun extension<T0: drop>(arg0: &0x2::kiosk::Kiosk) : &Extension {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<ExtensionKey<T0>, Extension>(0x2::kiosk::uid(arg0), v0)
    }

    fun extension_mut<T0: drop>(arg0: &mut 0x2::kiosk::Kiosk) : &mut Extension {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ExtensionKey<T0>, Extension>(0x2::kiosk::uid_mut_internal(arg0), v0)
    }

    public fun is_enabled<T0: drop>(arg0: &0x2::kiosk::Kiosk) : bool {
        extension<T0>(arg0).is_enabled
    }

    public fun is_installed<T0: drop>(arg0: &0x2::kiosk::Kiosk) : bool {
        let v0 = ExtensionKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<ExtensionKey<T0>>(0x2::kiosk::uid(arg0), v0)
    }

    public fun lock<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: T1, arg3: &0x2::transfer_policy::TransferPolicy<T1>) {
        assert!(is_installed<T0>(arg1), 3);
        assert!(can_lock<T0>(arg1), 2);
        0x2::kiosk::lock_internal<T1>(arg1, arg2);
    }

    public fun place<T0: drop, T1: store + key>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk, arg2: T1, arg3: &0x2::transfer_policy::TransferPolicy<T1>) {
        assert!(is_installed<T0>(arg1), 3);
        assert!(can_place<T0>(arg1) || can_lock<T0>(arg1), 2);
        0x2::kiosk::place_internal<T1>(arg1, arg2);
    }

    public fun storage<T0: drop>(arg0: T0, arg1: &0x2::kiosk::Kiosk) : &0x2::bag::Bag {
        assert!(is_installed<T0>(arg1), 3);
        &extension<T0>(arg1).storage
    }

    public fun storage_mut<T0: drop>(arg0: T0, arg1: &mut 0x2::kiosk::Kiosk) : &mut 0x2::bag::Bag {
        assert!(is_installed<T0>(arg1), 3);
        &mut extension_mut<T0>(arg1).storage
    }

    // decompiled from Move bytecode v6
}

