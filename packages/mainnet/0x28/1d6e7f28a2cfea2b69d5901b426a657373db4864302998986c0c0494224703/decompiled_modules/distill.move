module 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::distill {
    struct DistillKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Terms has copy, drop, store {
        open: bool,
        poison: u64,
        remedy: u64,
    }

    struct Distilled has copy, drop {
        by: address,
        kind: u8,
        doses: u64,
        scrap: u64,
        back: u64,
    }

    struct DistillConfigured has copy, drop {
        dig: 0x2::object::ID,
        open: bool,
        poison: u64,
        remedy: u64,
    }

    public fun distill_poison(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = rate_of(arg0, 0);
        let v1 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(&arg1) / v0;
        assert!(v1 >= 1, 611);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::use_poison_n(&mut arg1, v1 * v0);
        let v2 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::poison_doses(&arg1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Poison>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::destroy_empty_poison(arg1);
        };
        give(arg0, 0, v1, v0, v2, arg2);
    }

    public fun distill_remedy(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = rate_of(arg0, 1);
        let v1 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(&arg1) / v0;
        assert!(v1 >= 1, 611);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::use_remedy_n(&mut arg1, v1 * v0);
        let v2 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::remedy_doses(&arg1);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::Remedy>(arg1, 0x2::tx_context::sender(arg2));
        } else {
            0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::vials::destroy_empty_remedy(arg1);
        };
        give(arg0, 1, v1, v0, v2, arg2);
    }

    public fun distill_terms(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig) : (bool, u64, u64) {
        let v0 = terms_of(arg0);
        (v0.open, v0.poison, v0.remedy)
    }

    fun give(arg0: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::add_scrap(arg0, v0, arg2);
        let v1 = Distilled{
            by    : v0,
            kind  : arg1,
            doses : arg2 * arg3,
            scrap : arg2,
            back  : arg4,
        };
        0x2::event::emit<Distilled>(v1);
    }

    fun rate_of(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg1: u8) : u64 {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::assert_current(arg0);
        let v0 = terms_of(arg0);
        assert!(v0.open, 610);
        if (arg1 == 0) {
            v0.poison
        } else {
            v0.remedy
        }
    }

    entry fun set_distill(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::shovels::ShedCap, arg1: &mut 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig, arg2: bool, arg3: u64, arg4: u64) {
        0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::admin_ok(arg0, arg1);
        let v0 = if (arg3 >= 1) {
            if (arg3 <= 100) {
                if (arg4 >= 1) {
                    arg4 <= 100
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 612);
        let v1 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid_mut(arg1);
        let v2 = DistillKey{dummy_field: false};
        if (0x2::dynamic_field::exists<DistillKey>(v1, v2)) {
            let v3 = DistillKey{dummy_field: false};
            0x2::dynamic_field::remove<DistillKey, Terms>(v1, v3);
        };
        let v4 = DistillKey{dummy_field: false};
        let v5 = Terms{
            open   : arg2,
            poison : arg3,
            remedy : arg4,
        };
        0x2::dynamic_field::add<DistillKey, Terms>(v1, v4, v5);
        let v6 = DistillConfigured{
            dig    : 0x2::object::id<0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig>(arg1),
            open   : arg2,
            poison : arg3,
            remedy : arg4,
        };
        0x2::event::emit<DistillConfigured>(v6);
    }

    fun terms_of(arg0: &0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::Dig) : Terms {
        let v0 = 0x2c6c9f8936a2b348660b7d1e55c4caca0024e72e1571d06992fbc2ecf8fc666b::dig::uid(arg0);
        let v1 = DistillKey{dummy_field: false};
        if (0x2::dynamic_field::exists<DistillKey>(v0, v1)) {
            let v3 = DistillKey{dummy_field: false};
            *0x2::dynamic_field::borrow<DistillKey, Terms>(v0, v3)
        } else {
            Terms{open: false, poison: 15, remedy: 30}
        }
    }

    // decompiled from Move bytecode v7
}

