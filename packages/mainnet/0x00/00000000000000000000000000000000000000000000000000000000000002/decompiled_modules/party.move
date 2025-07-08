module 0x2::party {
    struct Party has copy, drop {
        default: Permissions,
        members: 0x2::vec_map::VecMap<address, Permissions>,
    }

    struct Permissions has copy, drop {
        pos0: u64,
    }

    fun empty() : Party {
        let v0 = Permissions{pos0: 0};
        Party{
            default : v0,
            members : 0x2::vec_map::empty<address, Permissions>(),
        }
    }

    public(friend) fun into_native(arg0: Party) : (u64, vector<address>, vector<u64>) {
        let Party {
            default : v0,
            members : v1,
        } = arg0;
        let v2 = v0;
        let (v3, v4) = 0x2::vec_map::into_keys_values<address, Permissions>(v1);
        let v5 = vector[];
        let v6 = v4;
        0x1::vector::reverse<Permissions>(&mut v6);
        let v7 = 0;
        while (v7 < 0x1::vector::length<Permissions>(&v6)) {
            let Permissions { pos0: v8 } = 0x1::vector::pop_back<Permissions>(&mut v6);
            0x1::vector::push_back<u64>(&mut v5, v8);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<Permissions>(v6);
        (v2.pos0, v3, v5)
    }

    public(friend) fun is_single_owner(arg0: &Party) : bool {
        if (arg0.default.pos0 == 0) {
            if (0x2::vec_map::size<address, Permissions>(&arg0.members) == 1) {
                let (_, v2) = 0x2::vec_map::get_entry_by_idx<address, Permissions>(&arg0.members, 0);
                v2.pos0 == 15
            } else {
                false
            }
        } else {
            false
        }
    }

    fun set_permissions(arg0: &mut Party, arg1: address, arg2: Permissions) {
        if (0x2::vec_map::contains<address, Permissions>(&arg0.members, &arg1)) {
            let (_, _) = 0x2::vec_map::remove<address, Permissions>(&mut arg0.members, &arg1);
        };
        0x2::vec_map::insert<address, Permissions>(&mut arg0.members, arg1, arg2);
    }

    public fun single_owner(arg0: address) : Party {
        let v0 = empty();
        let v1 = &mut v0;
        let v2 = Permissions{pos0: 15};
        set_permissions(v1, arg0, v2);
        v0
    }

    // decompiled from Move bytecode v6
}

