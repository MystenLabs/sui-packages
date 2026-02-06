module 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::m1n3 {
    struct M1N3 has drop {
        dummy_field: bool,
    }

    struct M1N3Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<M1N3>,
        total_minted: u64,
    }

    fun init(arg0: M1N3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M1N3>(arg0, 8, b"m1n3", b"m1n3 Token", b"Bitcoin block verification reward token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M1N3>>(v1);
        let v2 = M1N3Treasury{
            id           : 0x2::object::new(arg1),
            cap          : v0,
            total_minted : 0,
        };
        0x2::transfer::share_object<M1N3Treasury>(v2);
    }

    public(friend) fun mint_reward(arg0: &mut M1N3Treasury, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.total_minted = arg0.total_minted + arg1;
        0x2::transfer::public_transfer<0x2::coin::Coin<M1N3>>(0x2::coin::mint<M1N3>(&mut arg0.cap, arg1, arg3), arg2);
    }

    public fun total_minted(arg0: &M1N3Treasury) : u64 {
        arg0.total_minted
    }

    // decompiled from Move bytecode v6
}

