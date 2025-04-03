module 0xe89cdbf27272268b899aca7fc679016908d4137d5aa0a2c4c78002b31ab044c4::extension {
    struct Extension has drop {
        dummy_field: bool,
    }

    struct Marketplace has store {
        dummy_field: bool,
    }

    struct EXTENSION has drop {
        dummy_field: bool,
    }

    public(friend) fun lock<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: T0, arg2: &0x2::transfer_policy::TransferPolicy<T0>) {
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::lock<Extension, T0>(v0, arg0, arg1, arg2);
    }

    public(friend) fun bag_mut(arg0: &mut 0x2::kiosk::Kiosk) : &mut 0x2::bag::Bag {
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::storage_mut<Extension>(v0, arg0)
    }

    fun init(arg0: EXTENSION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<EXTENSION>(arg0, arg1);
        let (v2, v3) = 0x2::transfer_policy::new<Marketplace>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Marketplace>>(v3, v0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Marketplace>>(v2);
    }

    public fun install(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::add<Extension>(v0, arg0, arg1, 3, arg2);
    }

    // decompiled from Move bytecode v6
}

