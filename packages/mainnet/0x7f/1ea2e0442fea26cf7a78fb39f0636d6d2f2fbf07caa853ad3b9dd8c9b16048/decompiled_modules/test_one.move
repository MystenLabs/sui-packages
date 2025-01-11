module 0x7f1ea2e0442fea26cf7a78fb39f0636d6d2f2fbf07caa853ad3b9dd8c9b16048::test_one {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GrowPermision has key {
        id: 0x2::object::UID,
        width: u64,
        lenght: u64,
    }

    struct Pipisa has store, key {
        id: 0x2::object::UID,
        length: u64,
        width: u64,
    }

    public entry fun free_grow_pipisa(arg0: &mut Pipisa, arg1: GrowPermision, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.length = arg0.length + arg1.lenght;
        arg0.width = arg0.width + arg1.width;
        let GrowPermision {
            id     : v0,
            width  : _,
            lenght : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public entry fun grow_pipisa(arg0: &mut Pipisa, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1) / 100000000;
        arg0.length = arg0.length + v0;
        arg0.width = arg0.width + v0 / 3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::address::from_u256(21191008618190185438256436847326602874326757637836654303888079732481058468383));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_grow_permision(arg0: &AdminCap, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = GrowPermision{
            id     : 0x2::object::new(arg4),
            width  : arg2,
            lenght : arg3,
        };
        0x2::transfer::transfer<GrowPermision>(v0, arg1);
    }

    public entry fun mint_pipisa(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pipisa{
            id     : 0x2::object::new(arg0),
            length : 10,
            width  : 3,
        };
        0x2::transfer::public_transfer<Pipisa>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

