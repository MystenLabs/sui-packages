module 0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::airdrop_ext {
    struct Extension has drop {
        dummy_field: bool,
    }

    struct AirdropExtCap has store, key {
        id: 0x2::object::UID,
    }

    struct AirdropExtCapMinted has copy, drop {
        id: 0x2::object::ID,
        app: address,
    }

    public fun add(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::add<Extension>(v0, arg0, arg1, 3, arg2);
    }

    public fun lock<T0: store + key>(arg0: &AirdropExtCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0, arg3: &0x2::transfer_policy::TransferPolicy<T0>) {
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::lock<Extension, T0>(v0, arg1, arg2, arg3);
    }

    public fun place<T0: store + key>(arg0: &AirdropExtCap, arg1: &mut 0x2::kiosk::Kiosk, arg2: T0, arg3: &0x2::transfer_policy::TransferPolicy<T0>) {
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::place<Extension, T0>(v0, arg1, arg2, arg3);
    }

    public fun authorize_address(arg0: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropExtCap{id: 0x2::object::new(arg2)};
        let v1 = AirdropExtCapMinted{
            id  : 0x2::object::id<AirdropExtCap>(&v0),
            app : arg1,
        };
        0x2::event::emit<AirdropExtCapMinted>(v1);
        0x2::transfer::transfer<AirdropExtCap>(v0, arg1);
    }

    public(friend) fun create_airdrop_ext_cap(arg0: &0xc8dbff8adb6aaa895b7d35b03adad3e97f7f57dff7e3adb051f599c5a21d2a55::panzerdogs::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AirdropExtCap {
        let v0 = AirdropExtCap{id: 0x2::object::new(arg1)};
        let v1 = AirdropExtCapMinted{
            id  : 0x2::object::id<AirdropExtCap>(&v0),
            app : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<AirdropExtCapMinted>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

