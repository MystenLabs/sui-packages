module 0x3d19bf09ae8b84e88399164cc20d4802b6ba16ad4c13404a45602297b1cca22::felon {
    struct FELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: FELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FELON>(arg0, 9, b"FELON", b"felon", b"Trump is a felon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FELON>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FELON>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

