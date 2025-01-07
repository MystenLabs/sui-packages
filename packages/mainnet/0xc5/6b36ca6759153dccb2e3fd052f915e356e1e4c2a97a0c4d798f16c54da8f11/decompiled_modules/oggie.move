module 0xc56b36ca6759153dccb2e3fd052f915e356e1e4c2a97a0c4d798f16c54da8f11::oggie {
    struct OGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGIE>(arg0, 6, b"OGGIE", b"OGGIEonSUI", x"546865206772616e64666174686572206f66206d656d652063756c7475726520686173206172726976656420f09f90b80a4f676769652c206272696e67696e67207468652076696265732073696e636520e2809936342e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730959619451.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

