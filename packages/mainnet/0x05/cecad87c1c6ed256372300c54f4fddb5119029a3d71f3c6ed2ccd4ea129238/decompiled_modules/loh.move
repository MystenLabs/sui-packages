module 0x5cecad87c1c6ed256372300c54f4fddb5119029a3d71f3c6ed2ccd4ea129238::loh {
    struct LOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOH>(arg0, 6, b"SMBL", b"Name", b"Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<LOH>>(0x2::coin::mint<LOH>(&mut v2, 10000000000000000, arg1), @0x526f45c62dc9c4049053418fa50de1b4ada978df06433d8d7a3e8c9b6b0f8992);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOH>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOH>>(v1);
    }

    // decompiled from Move bytecode v6
}

