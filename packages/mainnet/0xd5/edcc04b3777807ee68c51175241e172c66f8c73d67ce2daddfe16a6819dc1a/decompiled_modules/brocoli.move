module 0xd5edcc04b3777807ee68c51175241e172c66f8c73d67ce2daddfe16a6819dc1a::brocoli {
    struct BROCOLI has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BROCOLI>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BROCOLI>>(0x2::coin::mint<BROCOLI>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    fun init(arg0: BROCOLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCOLI>(arg0, 9, b"COLI", b"BROCOLI", b"just a Broccoli inspsired by the great mind of CZ the real shepard of sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1876848151203569664/GS-w6kLs_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BROCOLI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCOLI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCOLI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

