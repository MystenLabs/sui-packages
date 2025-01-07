module 0xfd40162b687fb45e0c3e5b3400bc3637f96f3386318f04f3f718251f3372701c::storage {
    struct StorageAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Storage has store, key {
        id: 0x2::object::UID,
        paused: bool,
    }

    struct Paused has copy, drop {
        paused: bool,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StorageAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<StorageAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Storage{
            id     : 0x2::object::new(arg0),
            paused : false,
        };
        0x2::transfer::share_object<Storage>(v1);
    }

    public entry fun set_pause(arg0: &StorageAdminCap, arg1: &mut Storage, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun transfer_multi_cap(arg0: StorageAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<StorageAdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

