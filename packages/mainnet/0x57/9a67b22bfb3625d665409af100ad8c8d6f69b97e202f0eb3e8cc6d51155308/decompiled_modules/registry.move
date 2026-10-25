module 0xaaa207456758bfc1c608e7e3032ab367235aadec966511784c340b1962bdfd53::registry {
    struct Registry has key {
        id: 0x2::object::UID,
        revision: u64,
        frozen: bool,
    }

    struct ContentWritten has copy, drop {
        domain: 0x1::string::String,
        key: 0x1::string::String,
        revision: u64,
    }

    public fun bump(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut Registry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::tx_context::TxContext) {
        0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::verify(arg0, arg4);
        assert!(!arg1.frozen, 4101);
        arg1.revision = arg1.revision + 1;
        let v0 = ContentWritten{
            domain   : arg2,
            key      : arg3,
            revision : arg1.revision,
        };
        0x2::event::emit<ContentWritten>(v0);
    }

    public fun freeze_forever(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut Registry) {
        0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::verify_super(arg0);
        arg1.frozen = true;
        let v0 = ContentWritten{
            domain   : 0x1::string::utf8(b"registry"),
            key      : 0x1::string::utf8(b"freeze_forever"),
            revision : arg1.revision,
        };
        0x2::event::emit<ContentWritten>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id       : 0x2::object::new(arg0),
            revision : 0,
            frozen   : false,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun is_frozen(arg0: &Registry) : bool {
        arg0.frozen
    }

    public fun revision(arg0: &Registry) : u64 {
        arg0.revision
    }

    public fun uid_mut(arg0: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg1: &mut Registry, arg2: &0x2::tx_context::TxContext) : &mut 0x2::object::UID {
        0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::verify(arg0, arg2);
        assert!(!arg1.frozen, 4101);
        &mut arg1.id
    }

    // decompiled from Move bytecode v7
}

