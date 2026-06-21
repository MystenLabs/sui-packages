module 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::m1n3 {
    struct M1N3 has drop {
        dummy_field: bool,
    }

    struct M1N3Treasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<M1N3>,
        total_minted: u64,
    }

    entry fun admin_mint_for_testing(arg0: &mut M1N3Treasury, arg1: &0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::Pool, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == 0x9a5e441ab67702541e490e3f208faacb13c20e2a855f7304906f7faac2012761::pool::admin(arg1), 13906834474991091713);
        arg0.total_minted = arg0.total_minted + arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<M1N3>>(0x2::coin::mint<M1N3>(&mut arg0.cap, arg2, arg4), arg3);
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

    // decompiled from Move bytecode v7
}

