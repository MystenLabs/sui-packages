module 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        luck: 0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>,
    }

    struct GetLuck has copy, drop {
        user: address,
        amount: u64,
    }

    public entry fun deposit_luck(arg0: &mut Vault, arg1: 0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>(&mut arg0.luck, arg1);
    }

    public(friend) fun get_luck(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK> {
        let v0 = GetLuck{
            user   : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<GetLuck>(v0);
        0x2::coin::split<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>(&mut arg0.luck, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id   : 0x2::object::new(arg0),
            luck : 0x2::coin::zero<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>(arg0),
        };
        0x2::transfer::public_share_object<Vault>(v0);
    }

    public entry fun withdraw_luck(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>>(0x2::coin::split<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>(&mut arg0.luck, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

