module 0xed1cb587194eb51c7bb9fb8bacdb678812faac216769c2997bde2d4bcec77760::blast_boosts_aftermath {
    struct BLAST_BOOSTS_AFTERMATH has drop {
        dummy_field: bool,
    }

    struct Protocol has key {
        id: 0x2::object::UID,
        generation: 0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::operational_version::OperationalVersion<BLAST_BOOSTS_AFTERMATH>,
    }

    struct PartnerKey has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    fun new(arg0: &BLAST_BOOSTS_AFTERMATH, arg1: &mut 0x2::tx_context::TxContext) : Protocol {
        Protocol{
            id         : 0x2::object::new(arg1),
            generation : 0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::operational_version::new<BLAST_BOOSTS_AFTERMATH>(arg0),
        }
    }

    public(friend) fun assert_current(arg0: &Protocol) {
        0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::operational_version::assert_current<BLAST_BOOSTS_AFTERMATH>(&arg0.generation, 1);
    }

    public(friend) fun activate(arg0: &mut Protocol) {
        0x59f4f4f31d2a3290019f81bd4b794523f5d840659372e1bbda328965be3f5288::operational_version::advance<BLAST_BOOSTS_AFTERMATH>(&mut arg0.generation, &arg0.id, 1);
    }

    public(friend) fun add_partner(arg0: &mut Protocol, arg1: 0x2::object::ID) {
        let v0 = PartnerKey{pos0: arg1};
        if (0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v0);
            assert!(*v1 != 18446744073709551615, 37);
            *v1 = 18446744073709551615;
        } else {
            0x2::dynamic_field::add<PartnerKey, u64>(&mut arg0.id, v0, 18446744073709551615);
        };
    }

    public(friend) fun assert_partner(arg0: &Protocol, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PartnerKey{pos0: arg1};
        assert!(0x2::dynamic_field::exists<PartnerKey>(&arg0.id, v0), 36);
        assert!(arg2 < *0x2::dynamic_field::borrow<PartnerKey, u64>(&arg0.id, v0), 36);
    }

    fun init(arg0: BLAST_BOOSTS_AFTERMATH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new(&arg0, arg1);
        0x2::transfer::share_object<Protocol>(v0);
        0x2::package::claim_and_keep<BLAST_BOOSTS_AFTERMATH>(arg0, arg1);
    }

    public(friend) fun remove_partner(arg0: &mut Protocol, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        assert_partner(arg0, arg1, arg2);
        let v0 = PartnerKey{pos0: arg1};
        let v1 = 0x2::dynamic_field::borrow_mut<PartnerKey, u64>(&mut arg0.id, v0);
        assert!(*v1 == 18446744073709551615, 37);
        *v1 = arg3;
    }

    // decompiled from Move bytecode v7
}

