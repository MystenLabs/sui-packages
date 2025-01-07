module 0xebfb73a6c426fbb2fa440d746a0e79faa1c9c4872e956a15de9264811c80970e::kiosk_transfers {
    struct Store has key {
        id: 0x2::object::UID,
        escrow_kiosk_cap: 0x2::kiosk::KioskOwnerCap,
    }

    struct Escrow has store, key {
        id: 0x2::object::UID,
        receiver: address,
    }

    struct SentEvent has copy, drop {
        sender: address,
        nft_id: 0x2::object::ID,
    }

    struct ReceivedEvent has copy, drop {
        receiver: address,
        nft_id: 0x2::object::ID,
    }

    public fun transfer<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: address, arg6: &0x2::transfer_policy::TransferPolicy<T0>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let (v0, v1) = 0x2::kiosk::purchase_with_cap<T0>(arg2, 0x2::kiosk::list_with_purchase_cap<T0>(arg2, arg3, arg4, 0, arg7), 0x2::coin::zero<0x2::sui::SUI>(arg7));
        0x2::kiosk::lock<T0>(arg1, &arg0.escrow_kiosk_cap, arg6, v0);
        let v2 = Escrow{
            id       : 0x2::object::new(arg7),
            receiver : arg5,
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Escrow>(&mut arg0.id, arg4, v2);
        let v3 = SentEvent{
            sender : 0x2::tx_context::sender(arg7),
            nft_id : arg4,
        };
        0x2::event::emit<SentEvent>(v3);
        v1
    }

    public fun claim<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: 0x2::object::ID, arg5: &0x2::transfer_policy::TransferPolicy<T0>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::transfer_policy::TransferRequest<T0> {
        let v0 = 0x2::dynamic_object_field::remove<0x2::object::ID, Escrow>(&mut arg0.id, arg4);
        assert!(0x2::tx_context::sender(arg6) == v0.receiver, 0);
        let Escrow {
            id       : v1,
            receiver : _,
        } = v0;
        0x2::object::delete(v1);
        let (v3, v4) = 0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, &arg0.escrow_kiosk_cap, arg4, 0, arg6), 0x2::coin::zero<0x2::sui::SUI>(arg6));
        0x2::kiosk::lock<T0>(arg2, arg3, arg5, v3);
        let v5 = ReceivedEvent{
            receiver : 0x2::tx_context::sender(arg6),
            nft_id   : arg4,
        };
        0x2::event::emit<ReceivedEvent>(v5);
        v4
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        let v2 = Store{
            id               : 0x2::object::new(arg0),
            escrow_kiosk_cap : v1,
        };
        0x2::transfer::share_object<Store>(v2);
    }

    // decompiled from Move bytecode v6
}

