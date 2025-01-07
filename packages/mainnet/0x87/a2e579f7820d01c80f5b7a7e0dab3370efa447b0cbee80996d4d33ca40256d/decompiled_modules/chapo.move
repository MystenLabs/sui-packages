module 0x87a2e579f7820d01c80f5b7a7e0dab3370efa447b0cbee80996d4d33ca40256d::chapo {
    struct CHAPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAPO>(arg0, 6, b"CHAPO", b"Chapo Sui", b"Life is a celebration, and $CHAPO always know  how to add fire to it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002359_d65c47a891.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

