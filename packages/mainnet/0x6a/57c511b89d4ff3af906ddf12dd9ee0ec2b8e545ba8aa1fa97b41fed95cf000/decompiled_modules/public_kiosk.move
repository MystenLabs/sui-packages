module 0x6a57c511b89d4ff3af906ddf12dd9ee0ec2b8e545ba8aa1fa97b41fed95cf000::public_kiosk {
    struct PUBLIC_KIOSK has drop {
        dummy_field: bool,
    }

    struct PublicKiosk has store {
        kiosk: 0x2::kiosk::Kiosk,
        ownerCap: 0x2::kiosk::KioskOwnerCap,
    }

    public(friend) fun place<T0: store + key>(arg0: &mut PublicKiosk, arg1: T0, arg2: &0x6a57c511b89d4ff3af906ddf12dd9ee0ec2b8e545ba8aa1fa97b41fed95cf000::version::Version) {
        0x6a57c511b89d4ff3af906ddf12dd9ee0ec2b8e545ba8aa1fa97b41fed95cf000::version::checkVersion(arg2, 1);
        0x2::kiosk::place<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1);
    }

    public(friend) fun purchase<T0: store + key>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: &0x6a57c511b89d4ff3af906ddf12dd9ee0ec2b8e545ba8aa1fa97b41fed95cf000::version::Version, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        0x6a57c511b89d4ff3af906ddf12dd9ee0ec2b8e545ba8aa1fa97b41fed95cf000::version::checkVersion(arg2, 1);
        0x2::tx_context::sender(arg3);
        0x2::kiosk::purchase<T0>(&mut arg0.kiosk, arg1, 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    public(friend) fun take<T0: store + key>(arg0: &mut PublicKiosk, arg1: 0x2::object::ID, arg2: address, arg3: &0x6a57c511b89d4ff3af906ddf12dd9ee0ec2b8e545ba8aa1fa97b41fed95cf000::version::Version) {
        0x6a57c511b89d4ff3af906ddf12dd9ee0ec2b8e545ba8aa1fa97b41fed95cf000::version::checkVersion(arg3, 1);
        0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(&mut arg0.kiosk, &arg0.ownerCap, arg1), arg2);
    }

    public(friend) fun create(arg0: &0x6a57c511b89d4ff3af906ddf12dd9ee0ec2b8e545ba8aa1fa97b41fed95cf000::version::Version, arg1: &mut 0x2::tx_context::TxContext) : PublicKiosk {
        0x6a57c511b89d4ff3af906ddf12dd9ee0ec2b8e545ba8aa1fa97b41fed95cf000::version::checkVersion(arg0, 1);
        let (v0, v1) = 0x2::kiosk::new(arg1);
        PublicKiosk{
            kiosk    : v0,
            ownerCap : v1,
        }
    }

    fun init(arg0: PUBLIC_KIOSK, arg1: &mut 0x2::tx_context::TxContext) {
    }

    // decompiled from Move bytecode v6
}

