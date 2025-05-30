module 0xde4b05571fc9788431781cb771db1d68d4c14d50edf1c6f3da9dd2e98c022278::exercise {
    struct Registry has key {
        id: 0x2::object::UID,
        manager_cap: 0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::ManagerCap,
    }

    public fun level_up(arg0: &Registry, arg1: 0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::Tails) : 0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::Tails {
        0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::level_up(&arg0.manager_cap, &mut arg1);
        arg1
    }

    entry fun create_registry(arg0: 0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::ManagerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id          : 0x2::object::new(arg1),
            manager_cap : arg0,
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun earn_exp(arg0: &Registry, arg1: 0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::Tails) : 0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::Tails {
        0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::nft_exp_up(&arg0.manager_cap, &mut arg1, 1000);
        arg1
    }

    public fun earn_exp_mut(arg0: &Registry, arg1: &mut 0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::Tails) {
        0x27321bc52766f3ed3f809524ca0149bdbbf01f7f18bdccc261eab2dc5fa14589::mover_nft::nft_exp_up(&arg0.manager_cap, arg1, 1000);
    }

    // decompiled from Move bytecode v6
}

