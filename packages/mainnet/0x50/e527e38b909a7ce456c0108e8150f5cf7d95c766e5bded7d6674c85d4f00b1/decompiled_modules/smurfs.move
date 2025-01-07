module 0x50e527e38b909a7ce456c0108e8150f5cf7d95c766e5bded7d6674c85d4f00b1::smurfs {
    struct SMURFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFS>(arg0, 9, b"SMURFS", b"Smurfs", b"The Smurfs Sui Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1823320491509026818/MJ5VrNrU_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMURFS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMURFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

