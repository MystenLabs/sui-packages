module 0x99d6f1b0e3e8dafd83e65d81369da6650dc1c35c40288a626eb3d68ac920fde::smogy {
    struct SMOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOGY>(arg0, 9, b"SMOGY", b"SMOGY", b"SMOGY MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SMOGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMOGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOGY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

