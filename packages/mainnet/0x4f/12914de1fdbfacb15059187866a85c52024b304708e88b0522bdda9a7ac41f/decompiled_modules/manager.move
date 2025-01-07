module 0x4f12914de1fdbfacb15059187866a85c52024b304708e88b0522bdda9a7ac41f::manager {
    struct MANAGER has drop {
        dummy_field: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    public entry fun mint(arg0: &OwnerCap, arg1: &mut 0x1e520f3bb4b93938cf2bc90fb8d709ed3042dbf3c0290824c0ace15e583e8162::suishiba::Global, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x1e520f3bb4b93938cf2bc90fb8d709ed3042dbf3c0290824c0ace15e583e8162::suishiba::mint(arg1, arg2, arg3, arg4);
    }

    fun init(arg0: MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::package::claim_and_keep<MANAGER>(arg0, arg1);
        let v1 = OwnerCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        };
        0x2::transfer::transfer<OwnerCap>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

