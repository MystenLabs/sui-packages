module 0x77bb2743cb4ef07afded6676a8a05c6c9e133ba30150cefcca3a5546e2dc2992::blueprint {
    struct BlueprintMintEvent has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
    }

    struct BlueprintBurnEvent has copy, drop {
        id: 0x2::object::ID,
    }

    struct Blueprint has store, key {
        id: 0x2::object::UID,
    }

    struct BLUEPRINT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: Blueprint) {
        let v0 = BlueprintBurnEvent{id: 0x2::object::id<Blueprint>(&arg0)};
        0x2::event::emit<BlueprintBurnEvent>(v0);
        let Blueprint { id: v1 } = arg0;
        0x2::object::delete(v1);
    }

    fun init(arg0: BLUEPRINT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<BLUEPRINT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &0xf137a9af0d71238fc7db25daef2fedaef2c4793842066ad2389b9454f8bccb60::admin::AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Blueprint{id: 0x2::object::new(arg2)};
        let v1 = BlueprintMintEvent{
            id        : 0x2::object::id<Blueprint>(&v0),
            recipient : arg1,
        };
        0x2::event::emit<BlueprintMintEvent>(v1);
        0x2::transfer::transfer<Blueprint>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

