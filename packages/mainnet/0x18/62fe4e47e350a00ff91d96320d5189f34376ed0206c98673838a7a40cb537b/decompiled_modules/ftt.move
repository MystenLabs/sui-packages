module 0x1862fe4e47e350a00ff91d96320d5189f34376ed0206c98673838a7a40cb537b::ftt {
    struct FTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTT>(arg0, 2, b"FTT", b"FTT", b"In memory of the FTT token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/dQcsfPn.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FTT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTT>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<FTT>>(0x2::coin::mint<FTT>(&mut v2, 8446744073709551614, arg1), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<FTT>>(0x2::coin::mint<FTT>(&mut v2, 10000000000000000000, arg1), v3);
    }

    // decompiled from Move bytecode v6
}

