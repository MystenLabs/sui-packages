module 0xfc30d96a770b44c4b9bf7efe16cf23ec6d74afb69635c9761318b30ba0134e55::book {
    struct Safety has key {
        id: 0x2::object::UID,
        salt: 0x1::string::String,
        verifyHash: 0x1::string::String,
        verifySalt: 0x1::string::String,
    }

    struct Slot has key {
        id: 0x2::object::UID,
        creation: u64,
        summary: 0x1::string::String,
        root: 0x1::option::Option<bool>,
        archive: 0x1::option::Option<bool>,
        content: 0x1::option::Option<0x1::string::String>,
        contentType: 0x1::option::Option<u64>,
        parents: 0x1::option::Option<vector<address>>,
    }

    public fun create_safety(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Safety{
            id         : 0x2::object::new(arg3),
            salt       : arg0,
            verifyHash : arg1,
            verifySalt : arg2,
        };
        0x2::transfer::transfer<Safety>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun create_slot(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::option::Option<bool>, arg3: 0x1::option::Option<bool>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<vector<address>>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Slot{
            id          : 0x2::object::new(arg7),
            creation    : arg0,
            summary     : arg1,
            root        : arg2,
            archive     : arg3,
            content     : arg4,
            contentType : arg5,
            parents     : arg6,
        };
        0x2::transfer::transfer<Slot>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun remove_safety(arg0: Safety) {
        let Safety {
            id         : v0,
            salt       : _,
            verifyHash : _,
            verifySalt : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun remove_slot(arg0: Slot) {
        let Slot {
            id          : v0,
            creation    : _,
            summary     : _,
            root        : _,
            archive     : _,
            content     : _,
            contentType : _,
            parents     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun remove_slots(arg0: &mut vector<Slot>) {
        while (!0x1::vector::is_empty<Slot>(arg0)) {
            remove_slot(0x1::vector::pop_back<Slot>(arg0));
        };
    }

    public fun update_slot(arg0: &mut Slot, arg1: 0x1::string::String, arg2: 0x1::option::Option<bool>, arg3: 0x1::option::Option<bool>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<vector<address>>) {
        arg0.summary = arg1;
        arg0.content = arg4;
        arg0.root = arg2;
        arg0.archive = arg3;
        arg0.content = arg4;
        arg0.contentType = arg5;
        arg0.parents = arg6;
    }

    // decompiled from Move bytecode v6
}

