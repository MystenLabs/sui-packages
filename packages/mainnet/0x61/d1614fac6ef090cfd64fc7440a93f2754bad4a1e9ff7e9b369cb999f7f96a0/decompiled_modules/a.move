module 0x61d1614fac6ef090cfd64fc7440a93f2754bad4a1e9ff7e9b369cb999f7f96a0::a {
    struct A has store {
        per: 0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::LinkedTable<address, u128>,
    }

    struct M has copy, drop, store {
        add: address,
        per: u128,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : A {
        A{per: 0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::new<address, u128>(arg0)}
    }

    public fun a(arg0: &mut A, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
        if (0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::contains<address, u128>(&arg0.per, arg1)) {
            let v0 = 0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::borrow_mut<address, u128>(&mut arg0.per, arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::push_back<address, u128>(&mut arg0.per, arg1, 1 << arg2);
        };
    }

    public fun g(arg0: &A) : vector<M> {
        let v0 = 0x1::vector::empty<M>();
        let v1 = 0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::head<address, u128>(&arg0.per);
        while (0x1::option::is_some<address>(&v1)) {
            let v2 = *0x1::option::borrow<address>(&v1);
            let v3 = 0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::borrow_node<address, u128>(&arg0.per, v2);
            let v4 = M{
                add : v2,
                per : *0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::borrow_value<address, u128>(v3),
            };
            0x1::vector::push_back<M>(&mut v0, v4);
            v1 = 0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::next<address, u128>(v3);
        };
        v0
    }

    public fun gp(arg0: &A, arg1: address) : u128 {
        if (!0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::contains<address, u128>(&arg0.per, arg1)) {
            0
        } else {
            *0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::borrow<address, u128>(&arg0.per, arg1)
        }
    }

    public fun h(arg0: &A, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 0);
        0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::contains<address, u128>(&arg0.per, arg1) && *0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::borrow<address, u128>(&arg0.per, arg1) & 1 << arg2 > 0
    }

    public fun r(arg0: &mut A, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 0);
        if (0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::contains<address, u128>(&arg0.per, arg1)) {
            let v0 = 0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::borrow_mut<address, u128>(&mut arg0.per, arg1);
            *v0 = *v0 - (1 << arg2);
        };
    }

    public fun rm(arg0: &mut A, arg1: address) {
        if (0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::contains<address, u128>(&arg0.per, arg1)) {
            0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::remove<address, u128>(&mut arg0.per, arg1);
        };
    }

    public fun s(arg0: &mut A, arg1: address, arg2: u128) {
        if (0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::contains<address, u128>(&arg0.per, arg1)) {
            *0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::borrow_mut<address, u128>(&mut arg0.per, arg1) = arg2;
        } else {
            0x751d5558c21e3692d35ca9ec5a7dccaf7e88821683865a1c938b0f51ee46a43::linked_table::push_back<address, u128>(&mut arg0.per, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

