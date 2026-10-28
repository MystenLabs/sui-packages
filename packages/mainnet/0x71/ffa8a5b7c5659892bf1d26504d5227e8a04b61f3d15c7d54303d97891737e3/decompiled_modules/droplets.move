module 0x71ffa8a5b7c5659892bf1d26504d5227e8a04b61f3d15c7d54303d97891737e3::droplets {
    struct DROPLETS has drop {
        dummy_field: bool,
    }

    public fun drops() : u64 {
        2222
    }

    fun init(arg0: DROPLETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DROPLETS>(arg0, 9, 0x1::string::utf8(b"DROPLETS"), 0x1::string::utf8(b"Droplets"), 0x1::string::utf8(b"2222 drops of water on Sui. Hold one whole token and it can be condensed into a Droplet NFT; melt the Droplet and the token comes back. Fuse three and the water grows."), 0x1::string::utf8(b"https://suidroplets.com/icon.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<DROPLETS>(&mut v3, v2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<DROPLETS>(v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DROPLETS>>(0x2::coin::mint<DROPLETS>(&mut v2, total_supply(), arg1), 0x2::tx_context::sender(arg1));
    }

    public fun one() : u64 {
        1000000000
    }

    public fun total_supply() : u64 {
        2222 * 1000000000
    }

    // decompiled from Move bytecode v7
}

