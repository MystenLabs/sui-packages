module 0x7a359f0f94680e51572591b435b3626a78b448e5427b34e3ea048477e1f7043e::partner {
    struct PARTNER has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PartnerCap has key {
        id: 0x2::object::UID,
        level: u8,
        fee_receiver: address,
    }

    public fun get_fee_receiver(arg0: &PartnerCap) : address {
        arg0.fee_receiver
    }

    public fun get_partner_level(arg0: u8) : u8 {
        let v0 = &arg0;
        if (*v0 == 0) {
            0
        } else if (*v0 == 1) {
            1
        } else if (*v0 == 2) {
            2
        } else {
            2
        }
    }

    fun init(arg0: PARTNER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    entry fun mint_partner_cap(arg0: &AdminCap, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PartnerCap{
            id           : 0x2::object::new(arg3),
            level        : get_partner_level(arg2),
            fee_receiver : arg1,
        };
        0x2::transfer::share_object<PartnerCap>(v0);
    }

    // decompiled from Move bytecode v6
}

