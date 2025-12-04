module 0x31769761457c91ba9addffc72e653b0c20997c7120fbdf0f7396b1e96f188415::vault_acl {
    struct ACL has store {
        permissions: 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::LinkedTable<address, u128>,
    }

    struct Member has copy, drop, store {
        address: address,
        permission: u128,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ACL {
        ACL{permissions: 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::new<address, u128>(arg0)}
    }

    public fun add_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 939729457959745944);
        if (0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            let v0 = 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
            *v0 = *v0 | 1 << arg2;
        } else {
            0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, 1 << arg2);
        };
    }

    public fun get_members(arg0: &ACL) : vector<Member> {
        let v0 = 0x1::vector::empty<Member>();
        let v1 = 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::head<address, u128>(&arg0.permissions);
        while (0x1::option::is_some<address>(&v1)) {
            let v2 = *0x1::option::borrow<address>(&v1);
            let v3 = 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow_node<address, u128>(&arg0.permissions, v2);
            let v4 = Member{
                address    : v2,
                permission : *0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow_value<address, u128>(v3),
            };
            0x1::vector::push_back<Member>(&mut v0, v4);
            v1 = 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::next<address, u128>(v3);
        };
        v0
    }

    public fun get_permission(arg0: &ACL, arg1: address) : u128 {
        if (!0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            0
        } else {
            *0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow<address, u128>(&arg0.permissions, arg1)
        }
    }

    public fun has_role(arg0: &ACL, arg1: address, arg2: u8) : bool {
        assert!(arg2 < 128, 939729457959745944);
        0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<address, u128>(&arg0.permissions, arg1) && *0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow<address, u128>(&arg0.permissions, arg1) & 1 << arg2 > 0
    }

    public fun notices() : (vector<u8>, vector<u8>) {
        (x"c2a92032303235204d65746162797465204c6162732c20496e632e2020416c6c205269676874732052657365727665642e", b"Patent pending - U.S. Patent Application No. 63/861,982")
    }

    public fun remove_member(arg0: &mut ACL, arg1: address) {
        assert!(0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<address, u128>(&arg0.permissions, arg1), 943957943929212325);
        0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::remove<address, u128>(&mut arg0.permissions, arg1);
    }

    public fun remove_role(arg0: &mut ACL, arg1: address, arg2: u8) {
        assert!(arg2 < 128, 939729457959745944);
        assert!(0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<address, u128>(&arg0.permissions, arg1), 943957943929212325);
        let v0 = 0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1);
        *v0 = *v0 & 340282366920938463463374607431768211455 - (1 << arg2);
    }

    public fun set_roles(arg0: &mut ACL, arg1: address, arg2: u128) {
        if (0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::contains<address, u128>(&arg0.permissions, arg1)) {
            *0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::borrow_mut<address, u128>(&mut arg0.permissions, arg1) = arg2;
        } else {
            0x2d8a7d4c585f1c20758f9b2c500477e1be35e178e79efb6ddf9d14a0dceff211::linked_table::push_back<address, u128>(&mut arg0.permissions, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

