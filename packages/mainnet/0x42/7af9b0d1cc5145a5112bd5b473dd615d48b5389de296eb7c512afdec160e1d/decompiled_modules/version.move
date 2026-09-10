module 0x427af9b0d1cc5145a5112bd5b473dd615d48b5389de296eb7c512afdec160e1d::version {
    struct Version has store, key {
        id: 0x2::object::UID,
        current_version: u64,
    }

    entry fun admin_freeze(arg0: &mut Version, arg1: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg2: &0x2::tx_context::TxContext) {
        0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::verify(arg1, arg2);
        arg0.current_version = 0;
    }

    entry fun admin_update(arg0: &mut Version, arg1: &0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::AdminCap, arg2: &0x2::tx_context::TxContext) {
        0x42b5165ab47d760c38e0158328aba7c960d3f12d129cd2e960bea60e09d9d19b::admin::verify(arg1, arg2);
        assert!(arg0.current_version < 1, 601);
        arg0.current_version = 1;
    }

    public fun assert_latest(arg0: &Version) {
        assert!(arg0.current_version == 1, 601);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Version{
            id              : 0x2::object::new(arg0),
            current_version : 1,
        };
        0x2::transfer::share_object<Version>(v0);
    }

    // decompiled from Move bytecode v7
}

