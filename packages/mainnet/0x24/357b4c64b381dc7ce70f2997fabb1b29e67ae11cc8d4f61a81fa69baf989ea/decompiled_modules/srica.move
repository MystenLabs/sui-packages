module 0x24357b4c64b381dc7ce70f2997fabb1b29e67ae11cc8d4f61a81fa69baf989ea::srica {
    struct SRICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRICA>(arg0, 1, b"SRICA", b"PirateRica on Sui", b"LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SRICA>(&mut v2, 34522154527512120, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRICA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

