module 0x943cbc0238bb9e38837e5aa215c21653bd25c7fccc429648cc838c9c1aec5938::FUCK {
    struct FUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCK>(arg0, 2, b"FUCK", b"FUCK", b"A Dirty Fish in the Waters of the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUCK>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FUCK>(&mut v2, 100000000000, @0x5cd9f58650934831f5ea5614d1b5b215d8b7de078215ae283e0090c48d50a5a9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCK>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

