module 0x90f37f9eaeb3a67e0d403037fb0718ed2cc186f8807eba9e8d434c00beeafe0f::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOAT>(arg0, 9, b"GOAT", b"Aqua Goat", b"Meme Token famous from bsc 2022 , will launch Sui Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmayUm8qJgbLu6R48K2H5QJrikN52pYegPg1LENY3TrX8Q")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GOAT>(&mut v2, 666666666000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

