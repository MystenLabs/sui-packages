module 0x2a2d837322df11db1b2db21f938ba11c34a7facfa3884c1f6e15e8879feeb69e::resource {
    struct Tags has copy, drop, store {
        nick: 0x1::string::String,
        tags: vector<0x1::string::String>,
    }

    struct Resource has key {
        id: 0x2::object::UID,
        table: 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::Table<address, Tags>,
    }

    public fun remove(arg0: &mut Resource, arg1: address, arg2: vector<0x1::string::String>) {
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, Tags>(&arg0.id, &arg0.table, arg1)) {
            let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, Tags>(&mut arg0.id, &mut arg0.table, arg1);
            let v1 = 0;
            while (v1 < 0x1::vector::length<0x1::string::String>(&arg2)) {
                let (v2, v3) = 0x1::vector::index_of<0x1::string::String>(&v0.tags, 0x1::vector::borrow<0x1::string::String>(&arg2, v1));
                if (v2) {
                    0x1::vector::remove<0x1::string::String>(&mut v0.tags, v3);
                };
                v1 = v1 + 1;
            };
        };
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Resource {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_address(&v0);
        Resource{
            id    : v0,
            table : 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::new<address, Tags>(&v1),
        }
    }

    public(friend) fun transfer(arg0: Resource, arg1: address) {
        0x2::transfer::transfer<Resource>(arg0, arg1);
    }

    public fun add(arg0: &mut Resource, arg1: address, arg2: 0x1::option::Option<0x1::string::String>, arg3: vector<0x1::string::String>) {
        if (0x1::option::is_none<0x1::string::String>(&arg2) && 0x1::vector::is_empty<0x1::string::String>(&arg3)) {
            return
        };
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, Tags>(&arg0.id, &arg0.table, arg1)) {
            let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, Tags>(&mut arg0.id, &mut arg0.table, arg1);
            if (0x1::option::is_some<0x1::string::String>(&arg2)) {
                let v1 = 0x1::option::borrow<0x1::string::String>(&arg2);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN(v1);
                v0.nick = *v1;
            };
            let v2 = 0;
            while (v2 < 0x1::vector::length<0x1::string::String>(&arg3)) {
                let v3 = 0x1::vector::borrow<0x1::string::String>(&arg3, v2);
                if (0x1::string::length(v3) <= 64) {
                    if (!0x1::vector::contains<0x1::string::String>(&v0.tags, v3)) {
                        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::resource::TAG_COUNT(0x1::vector::length<0x1::string::String>(&v0.tags));
                        0x1::vector::push_back<0x1::string::String>(&mut v0.tags, *v3);
                    };
                };
                v2 = v2 + 1;
            };
        } else {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::resource::TAG_LEN(0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::length<address, Tags>(&arg0.table));
            let v4 = 0x1::string::utf8(b"");
            if (0x1::option::is_some<0x1::string::String>(&arg2)) {
                let v5 = 0x1::option::borrow<0x1::string::String>(&arg2);
                0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN(v5);
                v4 = *v5;
            };
            let v6 = 0x1::vector::empty<0x1::string::String>();
            let v7 = 0;
            while (v7 < 0x1::vector::length<0x1::string::String>(&arg3)) {
                let v8 = 0x1::vector::borrow<0x1::string::String>(&arg3, v7);
                if (0x1::string::length(v8) <= 64) {
                    if (!0x1::vector::contains<0x1::string::String>(&v6, v8)) {
                        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::resource::TAG_COUNT(0x1::vector::length<0x1::string::String>(&v6));
                        0x1::vector::push_back<0x1::string::String>(&mut v6, *v8);
                    };
                };
                v7 = v7 + 1;
            };
            let v9 = Tags{
                nick : v4,
                tags : v6,
            };
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<address, Tags>(&mut arg0.id, &mut arg0.table, arg1, v9);
        };
    }

    public fun create(arg0: Resource, arg1: &mut 0x2::tx_context::TxContext) : address {
        0x2::transfer::transfer<Resource>(arg0, 0x2::tx_context::sender(arg1));
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun destroy(arg0: Resource) {
        let Resource {
            id    : v0,
            table : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun refund(arg0: Resource, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Resource>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun removeall(arg0: &mut Resource, arg1: address) {
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, Tags>(&arg0.id, &arg0.table, arg1)) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::remove<address, Tags>(&mut arg0.id, &mut arg0.table, arg1);
        };
    }

    public(friend) fun switch(arg0: &mut Resource, arg1: &address, arg2: &0x1::string::String) : bool {
        if (0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::contains<address, Tags>(&arg0.id, &arg0.table, *arg1)) {
            let v0 = 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::borrow_mut<address, Tags>(&mut arg0.id, &mut arg0.table, *arg1);
            let (v1, v2) = 0x1::vector::index_of<0x1::string::String>(&v0.tags, arg2);
            if (v1) {
                0x1::vector::remove<0x1::string::String>(&mut v0.tags, v2);
                return false
            };
            0x1::vector::push_back<0x1::string::String>(&mut v0.tags, *arg2);
        } else {
            let v3 = Tags{
                nick : 0x1::string::utf8(b""),
                tags : 0x1::vector::singleton<0x1::string::String>(*arg2),
            };
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::table::add<address, Tags>(&mut arg0.id, &mut arg0.table, *arg1, v3);
        };
        true
    }

    // decompiled from Move bytecode v6
}

