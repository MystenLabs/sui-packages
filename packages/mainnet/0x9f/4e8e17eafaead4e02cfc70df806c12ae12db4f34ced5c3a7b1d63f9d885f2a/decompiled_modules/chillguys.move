module 0x9f4e8e17eafaead4e02cfc70df806c12ae12db4f34ced5c3a7b1d63f9d885f2a::chillguys {
    struct CHILLGUYS has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CHILLGUYS>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CHILLGUYS>>(0x2::coin::mint<CHILLGUYS>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: CHILLGUYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLGUYS>(arg0, 9, b"CHADS", b"CHILLGUYS", b"Just a chill guys, holdlers of SUI riding into the waves of the bull-run, unstopable meme inspiring the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1865407392328134656/NNc9ljii_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHILLGUYS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLGUYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLGUYS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

