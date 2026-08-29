module 0xd399f1cf21603783e1482a439ad5611f0db41bb6082bd78151fdaffdae855e06::alcohol {
    struct ALCOHOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALCOHOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALCOHOL>(arg0, 6, b"ALCOHOL", b"Alcohol", b"Alchol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/3c0a63d6cd3d918fc62021468ac7f7898e6040f020ca03477e741de75448ceec.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALCOHOL>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ALCOHOL>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

