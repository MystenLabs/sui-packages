module 0x3675877327b9bcf345adcd48233178dd789db5dbf9f05c4b942647c4ab2c5ceb::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 9, b"FISH", b"FISH", b"Fish.Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.ethoswallet.xyz/ipfs/bafybeielfvz4m33f3vesmp3kxc2oplp3lmoaq7cu4tq45p5tp3fqdcnkxm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FISH>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

