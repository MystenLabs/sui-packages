module 0x2d62336f06432989088ceeac7abe2a35b21ac179871ac5252fcbdf5261e7cb78::luck_vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        luck: 0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>,
    }

    struct LuckVault has store, key {
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

    entry fun deposit_luck_from_new_vault(arg0: &0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut LuckVault, arg2: 0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>(&mut arg1.luck, arg2);
    }

    entry fun deposit_luck_from_vault(arg0: &0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut Vault, arg2: 0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>(&mut arg1.luck, arg2);
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

    entry fun init_luck_vault(arg0: &0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = LuckVault{
            id   : 0x2::object::new(arg1),
            luck : 0x2::coin::zero<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>(arg1),
        };
        0x2::transfer::public_share_object<LuckVault>(v0);
    }

    public(friend) fun new_get_luck(arg0: &mut LuckVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK> {
        let v0 = GetLuck{
            user   : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<GetLuck>(v0);
        0x2::coin::split<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>(&mut arg0.luck, arg1, arg2)
    }

    public entry fun withdraw_luck(arg0: &mut Vault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
    }

    entry fun withdraw_luck_from_vault(arg0: &0xaff8c4874f0145d8d586aff69fdd8de07276200c985ce4878d05bddc6854a0ba::admin::Manage, arg1: &mut LuckVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>>(0x2::coin::split<0x202591744d54ee4f4af736ef3b8508f3d46d982c36747d9587032bd549122179::luck::LUCK>(&mut arg1.luck, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

