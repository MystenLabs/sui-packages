module 0x31510a658effb764a14f709c96707ce38ce475a2be14fe1187c6969768750812::edick {
    struct EDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EDICK>(arg0, 9, b"EDick", b"Elons Dick", b"Best Meme For Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EDICK>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EDICK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EDICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

