module 0x541023fc967e97500b68d08b20d4b00178ce66bc54b81baa15bac3a6faf41d0e::gem {
    struct GEM has drop {
        dummy_field: bool,
    }

    struct Gem has store, key {
        id: 0x2::object::UID,
        n: u64,
    }

    struct Plain has store, key {
        id: 0x2::object::UID,
        n: u64,
    }

    fun init(arg0: GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GEM>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Gem>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Gem>(&mut v4, &v3, 500, 1000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Gem>(&mut v4, &v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Gem>>(v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Gem>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Gem {
        Gem{
            id : 0x2::object::new(arg1),
            n  : arg0,
        }
    }

    public fun mint_plain(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Plain {
        Plain{
            id : 0x2::object::new(arg1),
            n  : arg0,
        }
    }

    // decompiled from Move bytecode v7
}

