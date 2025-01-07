module 0xc6a3017ea374b3249ff9783f9ce9976c9158d92b5b800ed54b1923c86d6f216::game {
    struct GameInfo has store, key {
        id: 0x2::object::UID,
        owner: address,
        ref: address,
    }

    public entry fun create_user(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = GameInfo{
            id    : 0x2::object::new(arg1),
            owner : v0,
            ref   : arg0,
        };
        0x2::transfer::transfer<GameInfo>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

