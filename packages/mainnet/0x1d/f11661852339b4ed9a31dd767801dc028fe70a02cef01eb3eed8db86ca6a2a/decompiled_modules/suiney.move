module 0x1df11661852339b4ed9a31dd767801dc028fe70a02cef01eb3eed8db86ca6a2a::suiney {
    struct SUINEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEY>(arg0, 9, b"SUINEY", b"Sydney Suiney", b"Special for dirty little boys.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.prestigeonline.com/wp-content/uploads/sites/5/2025/06/05111022/dr-squatch-sydney-sweeney-sydneys-bathwater-bliss-soap-00.jpeg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUINEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUINEY>>(0x2::coin::mint<SUINEY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUINEY>>(v2);
    }

    // decompiled from Move bytecode v6
}

